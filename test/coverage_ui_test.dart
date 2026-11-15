import 'package:fl_chart/fl_chart.dart' show BarChart, LineChart;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:psychonaut_application/app/providers.dart';
import 'package:psychonaut_application/data/health_data_source.dart';
import 'package:psychonaut_application/features/trends/charts.dart';
import 'package:psychonaut_application/l10n/l10n.dart';
import 'package:psychonaut_application/models/action_id.dart';
import 'package:psychonaut_application/models/app_settings.dart';
import 'package:psychonaut_application/models/health_models.dart';
import 'package:psychonaut_application/models/insight.dart';
import 'package:psychonaut_application/models/personality_profile.dart';

import 'risk_engine_test.dart' as f;
import 'test_app.dart';

const _phone = Size(390, 844);

/// Sleep fixed at [sleep] hours; reactions replaced by [reactions].
HealthSnapshot Function(HealthSnapshot) _tweak({
  double Function(int day)? sleep,
  List<ReactionResult>? reactions,
}) =>
    (s) => HealthSnapshot(
      metrics: [
        for (var i = 0; i < s.metrics.length; i++)
          DayMetrics(
            date: s.metrics[i].date,
            sleepHours: sleep?.call(i) ?? s.metrics[i].sleepHours,
            hrv: s.metrics[i].hrv,
            restingHeartRate: s.metrics[i].restingHeartRate,
            activityMinutes: s.metrics[i].activityMinutes,
          ),
      ],
      reactions: reactions ?? s.reactions,
      checkIns: s.checkIns,
    );

ReactionResult _slow(HealthSnapshot s) => ReactionResult(
  date: s.metrics[5].date,
  meanMs: 310,
  lapses: 1,
  falseStarts: 0,
  trials: 50,
);

Insight _insight({AiSource source = AiSource.cloud, bool alert = false}) =>
    alert
    ? Insight.alert('Alert message from the vehicle', Tone.direct)
    : Insight(
        summary: 'Sleep is a little short. Try a sleep reset tonight.',
        explanation: 'Your sleep has slipped.',
        suggestedAction: ActionId.sleepReset,
        tone: Tone.direct,
        source: source,
      );

Future<void> _host(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = const Size(420, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(child: SizedBox(width: 380, child: child)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _tapAcross(WidgetTester tester, Finder chart) async {
  final box = tester.getRect(chart);
  for (var i = 1; i < 16; i++) {
    final x = box.left + box.width * i / 16;
    for (final y in [box.bottom - 40, box.center.dy, box.top + 30]) {
      final g = await tester.startGesture(Offset(x, y));
      await tester.pump(const Duration(milliseconds: 50));
      await g.up();
      await tester.pump(const Duration(milliseconds: 50));
    }
  }
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  group('error and empty states', () {
    testWidgets('Home and Trends say so when data cannot load', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          assessmentProvider.overrideWithValue(
            AsyncValue.error(Exception('boom'), StackTrace.empty),
          ),
        ],
      );
      expect(find.textContaining('Could not load your data.'), findsOneWidget);
      await tester.tap(find.text('Trends'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Could not load your data.'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('Trends says there are no reaction tests yet', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          reactionHistoryProvider.overrideWithValue(
            const AsyncValue.data(<ReactionResult>[]),
          ),
        ],
      );
      await tester.tap(find.text('Trends'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('No tests yet'));
      expect(find.text('No tests yet'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('indicators without data say so', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          checkInHistoryProvider.overrideWithValue(
            const AsyncValue.data(<CheckIn>[]),
          ),
        ],
      );
      await scrollTo(tester, find.text('Mood'));
      await tester.tap(find.text('Mood'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('What to do now'));
      expect(find.text('No data yet'), findsWidgets);
      app.expectNoErrors();
    });
  });

  group("today's reading card", () {
    testWidgets('alert level shows the fixed message and no AI label', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          insightProvider.overrideWith((ref) async => _insight(alert: true)),
        ],
      );
      expect(find.text('Alert message from the vehicle'), findsOneWidget);
      expect(
        find.text('Fixed safety message, not AI-generated.'),
        findsOneWidget,
      );
      expect(find.text('Alert'), findsWidgets);
      expect(find.text('AI-generated'), findsNothing);
      app.expectNoErrors();
    });

    testWidgets('cloud text is labelled AI-generated with its source', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [insightProvider.overrideWith((ref) async => _insight())],
      );
      expect(find.text('AI-generated'), findsOneWidget);
      expect(find.text('Source: Cloud model'), findsOneWidget);
      expect(find.text('Sleep reset'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('a failed reading shows a plain message', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          insightProvider.overrideWith((ref) async => throw StateError('x')),
        ],
      );
      expect(
        find.text('Your reading is not available right now.'),
        findsOneWidget,
      );
      app.expectNoErrors();
    });
  });

  group('reminders', () {
    testWidgets('an overdue reaction test is offered and opens its screen', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          reactionHistoryProvider.overrideWithValue(
            const AsyncValue.data(<ReactionResult>[]),
          ),
        ],
      );
      expect(find.text('Time for your reaction test'), findsOneWidget);
      await tester.tap(find.text('Start test'));
      await tester.pumpAndSettle();
      expect(find.textContaining('3-minute test'), findsOneWidget);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.text('Your heading'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('an evening nudge opens the check-in', (tester) async {
      final now = DateTime.now();
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          clockProvider.overrideWithValue(
            () => DateTime(now.year, now.month, now.day, 21, 5),
          ),
        ],
      );
      expect(find.text("Captain's log is open"), findsOneWidget);
      await tester.tap(find.text('Log entry'));
      await tester.pumpAndSettle();
      expect(find.text("Captain's log"), findsOneWidget);
      app.expectNoErrors();
    });
  });

  group('mismatch card', () {
    testWidgets('sleep and reaction time together', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        transform: (s) =>
            _tweak(sleep: (i) => i >= 5 ? 6.0 : 7.5, reactions: [_slow(s)])(s),
      );
      expect(
        find.textContaining('sleep has been below your baseline'),
        findsOneWidget,
      );
      expect(
        find.textContaining('reaction time has been slower'),
        findsOneWidget,
      );
      app.expectNoErrors();
    });

    testWidgets('reaction time alone', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        transform: (s) => _tweak(sleep: (_) => 7.5, reactions: [_slow(s)])(s),
      );
      expect(
        find.textContaining('reaction time has been slower'),
        findsOneWidget,
      );
      expect(find.textContaining('sleep has been below'), findsNothing);
      app.expectNoErrors();
    });
  });

  group('indicator details and layouts', () {
    testWidgets('a mixed profile gets data and one recommendation', (
      tester,
    ) async {
      final app = await pumpApp(tester, size: _phone, profileId: 'lena-voss');
      await scrollTo(tester, find.text('Mood'));
      await tester.tap(find.text('Mood'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('What to do now'));
      expect(find.textContaining('Recommended:'), findsWidgets);
      app.expectNoErrors();
    });

    testWidgets('an external profile gets one clear step and an early flag', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        profileId: 'idris-okafor',
      );
      await scrollTo(tester, find.text('Motivation'));
      await tester.tap(find.text('Motivation'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('What to do now'));
      expect(find.textContaining('One step:'), findsOneWidget);
      expect(find.textContaining('Watched a day sooner'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('tablet: tapping a tile opens its detail beside the grid', (
      tester,
    ) async {
      final app = await pumpApp(tester, size: const Size(800, 900));
      await tester.tap(find.text('Stress').first);
      await tester.pumpAndSettle();
      expect(find.text("How it's measured"), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('console: choosing a node on the mind map updates the panels', (
      tester,
    ) async {
      final app = await pumpApp(tester, size: const Size(1280, 800));
      for (final name in ['Stress', 'Connection', 'Sleep']) {
        await tester.tap(find.text(name).first);
        await tester.pumpAndSettle();
        expect(find.text('$name, last 14 days'), findsOneWidget);
      }
      app.expectNoErrors();
    });
  });

  group('check-in', () {
    testWidgets('tapping the life-event label toggles the note field', (
      tester,
    ) async {
      final app = await pumpApp(tester, size: _phone);
      await tester.tap(find.text('Check in'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('Something happened at home'));
      await tester.tap(find.text('Something happened at home'));
      await tester.pumpAndSettle();
      expect(find.text('Private note'), findsOneWidget);
      app.expectNoErrors();
    });
  });

  group('profile screen', () {
    testWidgets('About the science opens and goes back', (tester) async {
      final app = await pumpApp(tester, size: _phone);
      await tester.tap(find.byTooltip('Profile and settings'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('About the science'));
      await tester.tap(find.text('About the science'));
      await tester.pumpAndSettle();
      expect(
        find.text('Where the ideas in Psychonaut come from.'),
        findsOneWidget,
      );
      expect(
        find.textContaining('NASA Human Research Program'),
        findsOneWidget,
      );
      await scrollTo(tester, find.text('Design assumptions'));
      expect(
        find.textContaining('Personality traits only shift'),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.text('About the science'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('mission day can be moved forward', (tester) async {
      final app = await pumpApp(tester, size: _phone);
      await tester.tap(find.byTooltip('Profile and settings'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.byTooltip('Next day'));
      await tester.tap(find.byTooltip('Next day'));
      await tester.pumpAndSettle();
      expect(find.text('Day 113'), findsOneWidget);
      app.expectNoErrors();
    });

    testWidgets('an unreadable file is reported', (tester) async {
      final app = await pumpApp(
        tester,
        size: _phone,
        overrides: [
          profileFilePickerProvider.overrideWithValue(
            (_) async => throw StateError('disk'),
          ),
        ],
      );
      await tester.tap(find.byTooltip('Profile and settings'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('Import profile JSON'));
      await tester.tap(find.text('Import profile JSON'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('That file could not be read.'),
        findsOneWidget,
      );
      app.expectNoErrors();
    });
  });

  group('charts on their own', () {
    testWidgets('sleep chart: no data, long history, tooltips', (tester) async {
      final reading = f.run().reading(Indicator.sleep);
      await _host(tester, SleepBarChart(metrics: const [], reading: reading));
      expect(find.text('No sleep data yet.'), findsOneWidget);

      await _host(
        tester,
        SleepBarChart(
          metrics: f.metrics(sleep: f.series(6.2, const [], 20)),
          reading: reading,
        ),
      );
      await _tapAcross(tester, find.byType(BarChart));
      expect(find.byType(BarChart), findsOneWidget);
    });

    testWidgets('reaction chart: too few tests, many tests, tooltips', (
      tester,
    ) async {
      await _host(tester, const ReactionLineChart(tests: [], baselineMs: 250));
      expect(find.textContaining('Take the reaction test'), findsOneWidget);

      final tests = [
        for (var i = 0; i < 12; i++)
          ReactionResult(
            date: DateTime(2026, 1, 1 + i * 2),
            meanMs: 240.0 + i * 6,
            lapses: i % 3,
            falseStarts: 0,
            trials: 50,
          ),
      ];
      await _host(tester, ReactionLineChart(tests: tests, baselineMs: 250));
      await _tapAcross(tester, find.byType(LineChart));
      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets('indicator line: a single value is not enough', (tester) async {
      final one = f.run(c: f.checkIns(n: 1)).reading(Indicator.mood);
      await _host(tester, IndicatorLineChart(reading: one));
      expect(find.text('Not enough data yet.'), findsOneWidget);
    });
  });
}
