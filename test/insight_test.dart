import 'dart:async';

import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:psychonaut_application/l10n/l10n.dart';
import 'package:psychonaut_application/models/action_id.dart';
import 'package:psychonaut_application/models/app_settings.dart';
import 'package:psychonaut_application/models/insight.dart';
import 'package:psychonaut_application/models/personality_profile.dart';
import 'package:psychonaut_application/models/status.dart';
import 'package:psychonaut_application/services/action_planner.dart';
import 'package:psychonaut_application/services/insight_coordinator.dart';
import 'package:psychonaut_application/services/insight_service.dart';
import 'package:psychonaut_application/services/rule_based_insight_service.dart';

import 'risk_engine_test.dart' as f;

PersonalityProfile variant(
  PersonalityProfile base, {
  String? locus,
  String? tone,
  List<String>? actions,
}) {
  final json = base.toJson();
  if (locus != null) json['locusOfControl'] = locus;
  final prefs = json['preferences'] as Map<String, dynamic>;
  if (tone != null) prefs['tone'] = tone;
  if (actions != null) prefs['preferredActions'] = actions;
  return PersonalityProfile.fromJson(json);
}

InsightContext ctx(
  PersonalityProfile p, {
  List<double>? sleep,
  List<double>? mood,
  List<double>? connection,
  Set<int> lifeEvents = const {},
  int missionDay = 100,
}) => InsightContext(
  profile: p,
  assessment: f.run(
    p: p,
    m: f.metrics(sleep: sleep),
    c: f.checkIns(mood: mood, connection: connection, lifeEvents: lifeEvents),
    missionDay: missionDay,
  ),
  metrics: f.metrics(),
  checkIns: f.checkIns(),
  missionDay: missionDay,
  l10n: lookupAppLocalizations(const Locale('en')),
);

int sentences(String s) => RegExp(r'\.(\s|$)').allMatches(s).length;

class _FakeService implements InsightService {
  _FakeService(this.source, this.onGenerate);

  @override
  final AiSource source;
  final Future<Insight> Function() onGenerate;
  int calls = 0;

  @override
  Future<Insight> generate(InsightContext context) {
    calls++;
    return onGenerate();
  }
}

Insight cloudInsight({
  String summary = 'Sleep is a little short. Try a sleep reset tonight.',
  ActionId? action = ActionId.sleepReset,
}) => Insight(
  summary: summary,
  explanation: 'Your sleep has slipped against your baseline.',
  suggestedAction: action,
  tone: Tone.direct,
  source: AiSource.cloud,
);

void main() {
  const service = RuleBasedInsightService();
  final slowSleep = f.series(7, f.repeat(6.0, 3));

  group('rule-based insights', () {
    test(
      'on course: two sentences, preferred action, no source note',
      () async {
        final i = await service.generate(ctx(f.profile()));
        expect(sentences(i.summary), 2);
        expect(i.summary, contains('on course'));
        expect(i.suggestedAction, ActionId.exercise);
        expect(i.source, AiSource.ruleBased);
        expect(i.isAiGenerated, isFalse);
        expect(i.fixedAlert, isFalse);
      },
    );

    test('names the worst reading and suggests a fitting action', () async {
      final i = await service.generate(ctx(f.profile(), sleep: slowSleep));
      expect(sentences(i.summary), 2);
      expect(i.summary, contains('Sleep'));
      expect(i.suggestedAction, ActionId.sleepReset);
    });

    test('tone changes the wording', () async {
      final base = f.profile();
      final direct = await service.generate(
        ctx(variant(base, tone: 'direct'), sleep: slowSleep),
      );
      final gentle = await service.generate(
        ctx(variant(base, tone: 'gentle'), sleep: slowSleep),
      );
      expect(direct.summary, isNot(gentle.summary));
      expect(gentle.tone, Tone.gentle);
    });

    test(
      'internal locus gets data and options; external gets one clear step',
      () async {
        final base = f.profile();
        final internal = await service.generate(
          ctx(variant(base, locus: 'internal'), sleep: slowSleep),
        );
        expect(internal.explanation, contains('Options:'));
        expect(internal.explanation, contains('baseline of'));
        expect(
          ';'.allMatches(internal.explanation).length,
          greaterThanOrEqualTo(2),
        );

        final external = await service.generate(
          ctx(variant(base, locus: 'external'), sleep: slowSleep),
        );
        expect(external.explanation, startsWith('Recommended step:'));
        expect(external.explanation, isNot(contains('Options:')));
        expect(external.explanation, isNot(contains('baseline of')));

        final mixed = await service.generate(
          ctx(variant(base, locus: 'mixed'), sleep: slowSleep),
        );
        expect(mixed.explanation, contains('Recommended:'));
        expect(mixed.explanation, contains('baseline of'));
      },
    );

    test('mismatch is mentioned in the summary', () async {
      final i = await service.generate(
        ctx(f.profile(), sleep: f.series(7, f.repeat(6.8, 8))),
      );
      expect(i.summary, contains('body data'));
    });

    test('a life event offers Message home first, with support', () async {
      final i = await service.generate(ctx(f.profile(), lifeEvents: {12}));
      expect(i.suggestedAction, ActionId.familyCall);
      expect(i.explanation, contains('from home'));
    });

    test('late mission mentions the tighter watch', () async {
      final i = await service.generate(ctx(f.profile(), missionDay: 160));
      expect(i.explanation, contains('day 150'));
    });

    test('never diagnoses or gives medication advice', () async {
      final profiles = [
        for (final locus in ['internal', 'mixed', 'external'])
          for (final tone in ['direct', 'gentle'])
            variant(f.profile(), locus: locus, tone: tone),
      ];
      for (final p in profiles) {
        for (final c in [
          ctx(p),
          ctx(p, sleep: slowSleep),
          ctx(
            p,
            mood: f.series(7, f.repeat(3.0, 3)),
            connection: f.series(7, f.repeat(3.0, 3)),
          ),
          ctx(p, lifeEvents: {12}),
          ctx(p, missionDay: 200, sleep: f.series(7, f.repeat(6.8, 8))),
        ]) {
          final i = await service.generate(c);
          expect(InsightSafety.isSafe(i.summary), isTrue, reason: i.summary);
          expect(
            InsightSafety.isSafe(i.explanation),
            isTrue,
            reason: i.explanation,
          );
          expect(ActionId.values, contains(i.suggestedAction));
        }
      }
    });
  });

  group('safety deny list', () {
    test('rejects conditions and medication advice', () {
      for (final bad in [
        'You may have depression.',
        'This looks like an anxiety disorder.',
        'Take 10 mg of melatonin.',
        'A clinical diagnosis is needed.',
        'Ask about a prescription.',
      ]) {
        expect(InsightSafety.isSafe(bad), isFalse, reason: bad);
      }
    });

    test('accepts everyday wording', () {
      expect(
        InsightSafety.isSafe('Sleep is short. Try a sleep reset tonight.'),
        isTrue,
      );
    });
  });

  group('action planning', () {
    test('preferences come first, then the rest, with no duplicates', () {
      final p = variant(f.profile(), actions: ['journal', 'garden']);
      final order = orderedActions(p);
      expect(order.take(2), [ActionId.journal, ActionId.garden]);
      expect(order.toSet(), hasLength(ActionId.values.length));
      expect(order, hasLength(ActionId.values.length));
    });

    test('a life event puts Message home first', () {
      final p = variant(f.profile(), actions: ['journal', 'family_call']);
      expect(
        orderedActions(p, lifeEventActive: true).first,
        ActionId.familyCall,
      );
      expect(orderedActions(p).first, ActionId.journal);
    });

    test('suggestion prefers an action the person likes', () {
      final p = variant(f.profile(), actions: ['window_time']);
      final a = f.run(
        p: p,
        m: f.metrics(sleep: slowSleep),
      );
      expect(suggestAction(p, a), ActionId.windowTime);
    });
  });

  group('insight coordinator', () {
    final rule = _FakeService(AiSource.ruleBased, () async => cloudInsight());
    final real = const RuleBasedInsightService();

    InsightCoordinator coordinator({
      InsightService? cloud,
      InsightService? onBoard,
      Duration timeout = const Duration(milliseconds: 80),
    }) => InsightCoordinator(
      ruleBased: real,
      cloud: cloud,
      onBoard: onBoard,
      timeout: timeout,
    );

    final alertCtx = ctx(f.profile(), sleep: f.series(7, f.repeat(4.5, 3)));

    test(
      'at alert level the message is fixed and no service is called',
      () async {
        expect(alertCtx.assessment.overall, Status.alert);
        final cloud = _FakeService(AiSource.cloud, () async => cloudInsight());
        final i = await coordinator(cloud: cloud)
            .resolve(alertCtx, AiSource.cloud);
        expect(
          i.summary,
          'Tell your crew medical officer and prepare a summary for Earth',
        );
        expect(i.fixedAlert, isTrue);
        expect(i.isAiGenerated, isFalse);
        expect(cloud.calls, 0);
        expect(rule.calls, 0);
      },
    );

    test('rule-based is used by default', () async {
      final i = await coordinator().resolve(
        ctx(f.profile()),
        AiSource.ruleBased,
      );
      expect(i.source, AiSource.ruleBased);
      expect(i.note, isNull);
    });

    test('a valid cloud insight is labelled as AI-generated', () async {
      final cloud = _FakeService(AiSource.cloud, () async => cloudInsight());
      final i = await coordinator(cloud: cloud)
          .resolve(ctx(f.profile()), AiSource.cloud);
      expect(i.source, AiSource.cloud);
      expect(i.isAiGenerated, isTrue);
    });

    test('failure falls back to rule-based and says so', () async {
      final cloud = _FakeService(
        AiSource.cloud,
        () async => throw Exception('offline'),
      );
      final i = await coordinator(cloud: cloud)
          .resolve(ctx(f.profile()), AiSource.cloud);
      expect(i.source, AiSource.ruleBased);
      expect(i.note, contains('Cloud model unavailable'));
    });

    test('missing cloud service falls back', () async {
      final i = await coordinator().resolve(ctx(f.profile()), AiSource.cloud);
      expect(i.source, AiSource.ruleBased);
      expect(i.note, isNotNull);
    });

    test('a slow call times out and falls back', () async {
      final cloud = _FakeService(
        AiSource.cloud,
        () => Completer<Insight>().future,
      );
      final i = await coordinator(cloud: cloud)
          .resolve(ctx(f.profile()), AiSource.cloud);
      expect(i.source, AiSource.ruleBased);
      expect(i.note, isNotNull);
    });

    test('unsafe text and missing actions are rejected', () async {
      for (final bad in [
        cloudInsight(summary: 'This could be depression. Rest well.'),
        cloudInsight(summary: 'Take 5 mg tonight. Sleep well.'),
        cloudInsight(action: null),
      ]) {
        final cloud = _FakeService(AiSource.cloud, () async => bad);
        final i = await coordinator(cloud: cloud)
            .resolve(ctx(f.profile()), AiSource.cloud);
        expect(i.source, AiSource.ruleBased);
      }
    });

    test('an on-board model that is not set up falls back', () async {
      final i = await coordinator().resolve(ctx(f.profile()), AiSource.onBoard);
      expect(i.source, AiSource.ruleBased);
      expect(i.note, contains('On-board model unavailable'));
    });
  });
}
