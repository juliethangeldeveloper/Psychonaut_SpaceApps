import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:psychonaut_application/l10n/l10n.dart';
import 'package:psychonaut_application/models/action_id.dart';
import 'package:psychonaut_application/models/app_settings.dart';
import 'package:psychonaut_application/services/insight_coordinator.dart';
import 'package:psychonaut_application/services/insight_service.dart';
import 'package:psychonaut_application/services/llm_insight_service.dart';
import 'package:psychonaut_application/services/rule_based_insight_service.dart';

import 'risk_engine_test.dart' as f;

const _config = LlmConfig(
  apiKey: 'test-key',
  endpoint: 'https://llm.example/v1/chat/completions',
  model: 'test-model',
);

InsightContext _ctx({String code = 'en', Set<int> lifeEvents = const {}}) =>
    InsightContext(
      profile: f.profile(),
      assessment: f.run(c: f.checkIns(lifeEvents: lifeEvents)),
      metrics: f.metrics(),
      checkIns: f.checkIns(),
      missionDay: 100,
      l10n: lookupAppLocalizations(Locale(code)),
    );

Map<String, Object?> _fields({
  String summary = 'Sleep is a little short. A sleep reset tonight could help.',
  String explanation = 'Your sleep sits below your own baseline.',
  String action = 'sleep_reset',
  String tone = 'direct',
}) => {
  'summary': summary,
  'explanation': explanation,
  'suggestedAction': action,
  'tone': tone,
};

http.Response _completion(String content, {int status = 200}) => http.Response(
  jsonEncode({
    'choices': [
      {
        'message': {'role': 'assistant', 'content': content},
      },
    ],
  }),
  status,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

InsightCoordinator _coordinator(http.Client client) => InsightCoordinator(
  ruleBased: const RuleBasedInsightService(),
  cloud: LlmInsightService(_config, client),
  timeout: const Duration(milliseconds: 80),
);

void main() {
  test('the cloud model needs a key, a model and an HTTPS endpoint', () {
    expect(_config.isConfigured, isTrue);
    expect(LlmConfig.fromEnvironment.isConfigured, isFalse);
    for (final bad in const [
      LlmConfig(apiKey: '', endpoint: 'https://x.example', model: 'm'),
      LlmConfig(apiKey: 'k', endpoint: 'https://x.example', model: ''),
      LlmConfig(apiKey: 'k', endpoint: 'http://x.example', model: 'm'),
      LlmConfig(apiKey: 'k', endpoint: '', model: 'm'),
    ]) {
      expect(bad.isConfigured, isFalse);
    }
    expect(
      const InsightCoordinator(ruleBased: RuleBasedInsightService()).timeout,
      const Duration(seconds: 8),
    );
  });

  test(
    'the request carries the rules and the numbers, never the name',
    () async {
      late http.Request sent;
      final service = LlmInsightService(
        _config,
        MockClient((request) async {
          sent = request;
          return _completion(jsonEncode(_fields()));
        }),
      );
      final insight = await service.generate(_ctx());
      expect(insight.source, AiSource.cloud);
      expect(insight.isAiGenerated, isTrue);
      expect(insight.suggestedAction, ActionId.sleepReset);

      expect(sent.method, 'POST');
      expect(sent.url.toString(), _config.endpoint);
      expect(sent.headers['Authorization'], 'Bearer test-key');
      final body = jsonDecode(sent.body) as Map<String, dynamic>;
      expect(body['model'], 'test-model');
      // Claude rejects a temperature below 1 and the json_object format.
      expect(body.containsKey('temperature'), isFalse);
      expect(body['response_format']['type'], 'json_schema');
      expect(body['response_format']['json_schema']['strict'], isTrue);
      final prompt = (body['messages'] as List).first['content'] as String;
      for (final expected in [
        'Never diagnose a condition or name a disorder.',
        'Never give medication advice.',
        'exercise, journal, family_call, garden, window_time, new_project, sleep_reset',
        'Write in English.',
        '"missionDay":100',
        '"mismatch":false',
        '"last14Days"',
        '"bigFive"',
      ]) {
        expect(prompt, contains(expected));
      }
      for (final private in [
        'Test Person',
        'Tester',
        'displayName',
        'lifeEvent',
        'note',
      ]) {
        expect(sent.body, isNot(contains(private)));
      }
    },
  );

  test(
    'the prompt follows the language and a life event narrows the actions',
    () {
      final fr = _ctx(code: 'fr');
      expect(
        buildSystemPrompt(fr, allowedActions(fr)),
        contains('Write in French.'),
      );

      final event = _ctx(lifeEvents: {12});
      expect(allowedActions(event), [ActionId.familyCall]);
      expect(
        buildSystemPrompt(event, allowedActions(event)),
        contains('only from this list: family_call.'),
      );
      expect(
        () => parseInsight(jsonEncode(_fields()), allowedActions(event)),
        throwsFormatException,
      );
    },
  );

  test('replies outside the schema are rejected', () {
    final bad = <String>[
      'Here is your reading!',
      '[1, 2]',
      jsonEncode({..._fields(), 'extra': 'x'}),
      jsonEncode(_fields()..remove('tone')),
      jsonEncode(_fields(action: 'skydiving')),
      jsonEncode(_fields(tone: 'sarcastic')),
      jsonEncode(_fields(summary: 'Only one sentence.')),
      jsonEncode(_fields(summary: 'One. Two. Three.')),
      jsonEncode(_fields(explanation: '  ')),
      jsonEncode(_fields(explanation: 'x' * 801)),
      jsonEncode({..._fields(), 'summary': 7}),
    ];
    for (final content in bad) {
      expect(
        () => parseInsight(content, ActionId.values),
        throwsFormatException,
        reason: content,
      );
    }
    expect(
      parseInsight(
        jsonEncode(_fields(tone: 'gentle')),
        ActionId.values,
      ).summary,
      startsWith('Sleep is a little short.'),
    );
  });

  test('server errors and odd response shapes are errors', () async {
    for (final response in [
      _completion(jsonEncode(_fields()), status: 500),
      http.Response('{"choices": []}', 200),
      http.Response('not json', 200),
    ]) {
      final service = LlmInsightService(
        _config,
        MockClient((_) async => response),
      );
      await expectLater(service.generate(_ctx()), throwsA(anything));
    }
  });

  group('fallback to rule-based', () {
    test('a valid reply is used and labelled as the cloud model', () async {
      final c = _coordinator(
        MockClient((_) async => _completion(jsonEncode(_fields()))),
      );
      final i = await c.resolve(_ctx(), AiSource.cloud);
      expect(i.source, AiSource.cloud);
      expect(i.note, isNull);
    });

    test(
      'diagnosis or medication wording is rejected in any language',
      () async {
        for (final summary in [
          'This looks like depression. Rest well tonight.',
          'Take 5 mg tonight. Sleep well.',
          'Esto parece depresión. Descansa bien.',
          'Prenez un médicament ce soir. Dormez bien.',
          'うつの可能性があります。よく休みましょう。',
          'قد يكون هذا اكتئاب. نم جيداً.',
        ]) {
          final c = _coordinator(
            MockClient(
              (_) async => _completion(jsonEncode(_fields(summary: summary))),
            ),
          );
          final i = await c.resolve(_ctx(), AiSource.cloud);
          expect(i.source, AiSource.ruleBased, reason: summary);
          expect(i.note, contains('Cloud model unavailable'));
        }
      },
    );

    test('failures and slow calls fall back', () async {
      for (final client in [
        MockClient((_) async => throw http.ClientException('offline')),
        MockClient((_) async => _completion('nope')),
        MockClient((_) => Completer<http.Response>().future),
      ]) {
        final i = await _coordinator(client).resolve(_ctx(), AiSource.cloud);
        expect(i.source, AiSource.ruleBased);
        expect(i.note, isNotNull);
      }
    });
  });

  group('on-board model', () {
    const local = LlmConfig(
      endpoint: 'http://localhost:11434/v1/chat/completions',
      model: 'local-model',
      local: true,
    );

    test('needs no key but only accepts a local address', () {
      expect(local.isConfigured, isTrue);
      expect(LlmConfig.onBoardFromEnvironment.isConfigured, isFalse);
      for (final host in [
        'localhost',
        '127.0.0.1',
        '10.0.0.5',
        '192.168.1.20',
        '172.16.4.1',
        'ship.local',
      ]) {
        expect(isLocalHost(host), isTrue, reason: host);
      }
      for (final host in [
        'api.example.com',
        '8.8.8.8',
        '172.32.0.1',
        '10.0.0.5.example.com',
        '',
      ]) {
        expect(isLocalHost(host), isFalse, reason: host);
      }
      expect(
        const LlmConfig(
          endpoint: 'https://api.example.com/v1/chat/completions',
          model: 'm',
          local: true,
        ).isConfigured,
        isFalse,
      );
      expect(
        const LlmConfig(
          endpoint: 'http://localhost:11434/v1',
          model: '',
          local: true,
        ).isConfigured,
        isFalse,
      );
    });

    test('sends no key and labels the reading as on-board', () async {
      late http.Request sent;
      final c = InsightCoordinator(
        ruleBased: const RuleBasedInsightService(),
        onBoard: LlmInsightService(
          local,
          MockClient((request) async {
            sent = request;
            return _completion(jsonEncode(_fields()));
          }),
          source: AiSource.onBoard,
        ),
      );
      final i = await c.resolve(_ctx(), AiSource.onBoard);
      expect(i.source, AiSource.onBoard);
      expect(i.isAiGenerated, isTrue);
      expect(sent.headers.containsKey('Authorization'), isFalse);
      expect(sent.url.host, 'localhost');
      expect(c.onBoardTimeout, const Duration(seconds: 60));
    });
  });
}
