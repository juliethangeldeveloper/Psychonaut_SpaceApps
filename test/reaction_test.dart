import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psychonaut_application/app/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

const _key = 'reactions_maya-reyes';

Future<TestApp> _openAndStart(WidgetTester tester) async {
  final app = await pumpApp(
    tester,
    size: const Size(390, 844),
    // Fake time, so three minutes pass instantly and timings are exact.
    overrides: [stopwatchProvider.overrideWithValue(() => clock.stopwatch())],
  );
  await tester.tap(find.text('Trends'));
  await tester.pumpAndSettle();
  await scrollTo(tester, find.text('Start test'));
  await tester.tap(find.text('Start test'));
  await tester.pumpAndSettle();
  expect(find.textContaining('3-minute test'), findsOneWidget);
  await tester.tap(find.text('Start test'));
  await tester.pump();
  expect(find.text('Wait…'), findsOneWidget);
  return app;
}

Future<void> _waitForSignal(WidgetTester tester) async {
  for (var i = 0; i < 60 && find.text('Tap now').evaluate().isEmpty; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  expect(find.text('Tap now'), findsOneWidget);
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('records mean, lapses and false starts, then saves', (
    tester,
  ) async {
    final app = await _openAndStart(tester);

    // Tapping before the signal is a false start.
    await tester.tap(find.text('Wait…'));
    await tester.pump();
    expect(find.text('Too soon. Wait for the signal.'), findsOneWidget);

    // A quick response by touch.
    await _waitForSignal(tester);
    await tester.pump(const Duration(milliseconds: 250));
    await tester.tap(find.text('Tap now'));
    await tester.pump();
    expect(find.text('Wait…'), findsOneWidget);

    // A slow response by keyboard counts as a lapse.
    await _waitForSignal(tester);
    await tester.pump(const Duration(milliseconds: 600));
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump();

    await tester.pump(const Duration(seconds: 181));
    await tester.pumpAndSettle();
    expect(find.text('Test complete'), findsOneWidget);
    expect(find.text('Saved. You can see it in Trends.'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    final saved = (jsonDecode(prefs.getString(_key)!) as List).single as Map;
    expect(saved['trials'], 2);
    expect(saved['lapses'], 1);
    expect(saved['falseStarts'], 1);
    // 250 and 600 ms, each plus up to one 100 ms polling step.
    expect(saved['meanMs'], inInclusiveRange(425, 525));

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.textContaining('1 lapse'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('a run with no responses is not saved', (tester) async {
    final app = await _openAndStart(tester);
    await tester.pump(const Duration(seconds: 181));
    await tester.pumpAndSettle();
    expect(
      find.text('No responses were recorded, so nothing was saved.'),
      findsOneWidget,
    );
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(_key), isNull);
    app.expectNoErrors();
  });

  testWidgets('going back mid-test discards the run', (tester) async {
    final app = await _openAndStart(tester);
    await _waitForSignal(tester);
    await tester.tap(find.text('Tap now'));
    await tester.pump();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    // Back on Trends, which is still scrolled to the reaction card.
    expect(find.text('Start test'), findsOneWidget);
    expect(find.text('Wait…'), findsNothing);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(_key), isNull);
    app.expectNoErrors();
  });
}
