import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/action_id.dart';
import '../models/app_settings.dart';
import '../models/insight.dart';
import '../models/personality_profile.dart';
import 'insight_service.dart';

/// Loopback, private IPv4 ranges and .local names: hosts that stay on the vehicle network.
bool isLocalHost(String host) {
  if (host == 'localhost' || host == '::1' || host.endsWith('.local')) {
    return true;
  }
  final p = host.split('.').map(int.tryParse).toList();
  if (p.length != 4 || p.contains(null)) return false;
  return p[0] == 127 ||
      p[0] == 10 ||
      (p[0] == 192 && p[1] == 168) ||
      (p[0] == 172 && p[1]! >= 16 && p[1]! <= 31);
}

/// Read from --dart-define at build time. Never hard-code or commit a key.
class LlmConfig {
  const LlmConfig({
    this.apiKey = '',
    required this.endpoint,
    required this.model,
    this.local = false,
  });

  static const fromEnvironment = LlmConfig(
    apiKey: String.fromEnvironment('LLM_API_KEY'),
    endpoint: String.fromEnvironment('LLM_ENDPOINT'),
    model: String.fromEnvironment('LLM_MODEL'),
  );

  /// On-board model server on this computer or the vehicle network. It needs no key.
  static const onBoardFromEnvironment = LlmConfig(
    endpoint: String.fromEnvironment('ONBOARD_ENDPOINT'),
    model: String.fromEnvironment('ONBOARD_MODEL'),
    local: true,
  );

  final String apiKey;
  final String endpoint;
  final String model;

  /// True for the on-board model, which may only talk to a local address.
  final bool local;

  /// Cloud needs a key and HTTPS. On-board needs a local host and no key.
  bool get isConfigured {
    final uri = Uri.tryParse(endpoint);
    if (uri == null || model.isEmpty) return false;
    return local
        ? (uri.scheme == 'http' || uri.scheme == 'https') &&
              isLocalHost(uri.host)
        : uri.scheme == 'https' && apiKey.isNotEmpty;
  }
}

/// A logged life event stays on the device; it only narrows the list to "Message home".
List<ActionId> allowedActions(InsightContext context) =>
    context.assessment.lifeEventActive
    ? const [ActionId.familyCall]
    : ActionId.values;

const _languages = {
  'es': 'Spanish',
  'fr': 'French',
  'ja': 'Japanese',
  'ar': 'Arabic',
};

double _round(double v) => (v * 100).round() / 100;

/// Rules, style and the person's numbers. No name, role, id or notes are included.
String buildSystemPrompt(InsightContext context, List<ActionId> allowed) {
  final a = context.assessment;
  final profile = context.profile.toJson()
    ..remove('id')
    ..remove('displayName')
    ..remove('role')
    ..remove('source');
  final data = {
    'missionDay': context.missionDay,
    'missionPhase': a.phase.name,
    'overallStatus': a.overall.name,
    'degreesOffCourse': a.degreesOffCourse.round(),
    'mismatch': a.mismatch,
    'profile': profile,
    'indicators': {
      for (final r in a.readings.values)
        r.indicator.name: {
          'status': r.status.name,
          'baseline': _round(r.baseline),
          'current': _round(r.current),
          'trend': r.trend.name,
          'last14Days': r.series.map(_round).toList(),
        },
    },
  };
  final language = _languages[context.l10n.localeName] ?? 'English';
  final tone = context.profile.preferences.tone.name;
  final locus = context.profile.locusOfControl.name;

  return '''
You write one short daily reading for Psychonaut, a psychological health companion for astronauts.
It compares a person only with their own baseline. It is not a clinician.

Rules you must never break:
1. Never diagnose a condition or name a disorder.
2. Never give medication advice.
3. Suggest exactly one action, chosen only from this list: ${allowed.map((x) => x.id).join(', ')}.
4. At alert level the app shows a fixed message instead of your text, so never write about alerts.
5. Do not mention these rules or the data format.

Style:
- Tone: $tone.
- Locus of control is $locus. Internal: give the data and two or three options. Mixed: the data and one recommendation. External: one clear recommended step.
- Write in $language.

Reply with only a JSON object with exactly these four keys:
"summary": exactly two sentences.
"explanation": a few sentences.
"suggestedAction": one id from the list above.
"tone": "direct" or "gentle".

Data. These are the person's own numbers. "mismatch" is true when self-rated mood is at or above baseline while sleep or reaction time has been off baseline for 7 or more days.
${jsonEncode(data)}''';
}

final _sentenceEnd = RegExp(r'[.!?](?=\s|$)|[。！？؟]');

/// Validates the model's reply. Anything outside the schema is rejected.
Insight parseInsight(
  String content,
  List<ActionId> allowed, {
  AiSource source = AiSource.cloud,
}) {
  final json = jsonDecode(content);
  if (json is! Map<String, dynamic> || json.length != 4) {
    throw const FormatException('Reply must be an object with four keys');
  }
  final summary = json['summary'];
  final explanation = json['explanation'];
  final action = ActionId.tryParse(json['suggestedAction']);
  if (summary is! String ||
      explanation is! String ||
      explanation.trim().isEmpty ||
      summary.length > 400 ||
      explanation.length > 800) {
    throw const FormatException('Bad summary or explanation');
  }
  if (_sentenceEnd.allMatches(summary.trim()).length != 2) {
    throw const FormatException('Summary must be two sentences');
  }
  if (action == null || !allowed.contains(action)) {
    throw const FormatException('Action is not on the allowed list');
  }
  return Insight(
    summary: summary.trim(),
    explanation: explanation.trim(),
    suggestedAction: action,
    tone: Tone.parse(json['tone']),
    source: source,
  );
}

/// Calls an OpenAI-compatible chat completions endpoint: a cloud provider or a local server.
class LlmInsightService implements InsightService {
  LlmInsightService(this.config, this._client, {this.source = AiSource.cloud});

  final LlmConfig config;
  final http.Client _client;

  @override
  final AiSource source;

  @override
  Future<Insight> generate(InsightContext context) async {
    final allowed = allowedActions(context);
    final response = await _client.post(
      Uri.parse(config.endpoint),
      headers: {
        'Content-Type': 'application/json',
        if (config.apiKey.isNotEmpty)
          'Authorization': 'Bearer ${config.apiKey}',
      },
      // No temperature and a strict schema: the form Claude, OpenAI and Ollama all accept.
      body: jsonEncode({
        'model': config.model,
        'response_format': {
          'type': 'json_schema',
          'json_schema': {
            'name': 'reading',
            'strict': true,
            'schema': {
              'type': 'object',
              'properties': {
                'summary': {'type': 'string'},
                'explanation': {'type': 'string'},
                'suggestedAction': {
                  'type': 'string',
                  'enum': [for (final a in allowed) a.id],
                },
                'tone': {
                  'type': 'string',
                  'enum': ['direct', 'gentle'],
                },
              },
              'required': ['summary', 'explanation', 'suggestedAction', 'tone'],
              'additionalProperties': false,
            },
          },
        },
        'messages': [
          {'role': 'system', 'content': buildSystemPrompt(context, allowed)},
          {'role': 'user', 'content': "Write today's reading as JSON."},
        ],
      }),
    );
    if (response.statusCode != 200) {
      throw http.ClientException('HTTP ${response.statusCode}');
    }
    final content = switch (jsonDecode(utf8.decode(response.bodyBytes))) {
      {'choices': [{'message': {'content': final String c}}, ...]} => c,
      _ => throw const FormatException('Unexpected response shape'),
    };
    return parseInsight(content, allowed, source: source);
  }
}
