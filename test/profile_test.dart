import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:psychonaut_application/app/providers.dart';

import 'test_app.dart';

Future<void> openProfile(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Profile and settings'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('profile screen shows the loaded profile', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openProfile(tester);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Maya Reyes'), findsOneWidget);
    expect(find.textContaining('Commander'), findsOneWidget);
    expect(find.text('Emotional stability'), findsOneWidget);
    await scrollTo(tester, find.text('Retake the questionnaire'));
    expect(find.text('Retake the questionnaire'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('sample switcher changes the loaded person', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openProfile(tester);
    await scrollTo(tester, find.text('Idris Okafor, Flight Engineer'));
    await tester.tap(find.text('Idris Okafor, Flight Engineer'));
    await tester.pumpAndSettle();
    expect(find.text('Loaded Idris Okafor.'), findsOneWidget);

    await tester.drag(find.byType(Scrollable).first, const Offset(0, 3000));
    await tester.pumpAndSettle();
    expect(find.text('Idris Okafor'), findsOneWidget);
    expect(find.textContaining('IPIP-NEO-120'), findsOneWidget);
    expect(find.text('Facets'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Your heading'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('retake opens onboarding with name filled in', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openProfile(tester);
    await scrollTo(tester, find.text('Retake the questionnaire'));
    await tester.tap(find.text('Retake the questionnaire'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome aboard'), findsOneWidget);
    expect(find.text('Maya Reyes'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('mission day changes the phase shown on Home', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    expect(find.text('Mission day 112 · Mid-mission'), findsOneWidget);
    await openProfile(tester);
    await scrollTo(tester, find.text('Day 151'));
    await tester.tap(find.text('Day 151'));
    await tester.pumpAndSettle();
    expect(find.text('Late mission'), findsOneWidget);
    await scrollTo(tester, find.byTooltip('Previous day'));
    await tester.tap(find.byTooltip('Previous day'));
    await tester.pumpAndSettle();
    expect(find.text('Day 150'), findsWidgets);
    expect(find.text('Mid-mission'), findsOneWidget);
    await tester.tap(find.text('Day 151'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Mission day 151 · Late mission'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('AI source defaults to rule-based and is shown on Home', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    expect(find.textContaining('Source: Rule-based'), findsOneWidget);
    expect(find.text('AI-generated'), findsNothing);

    await openProfile(tester);
    await scrollTo(tester, find.text('On-board model'));
    await tester.tap(find.text('On-board model'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    // The on-board model is a stub, so the reading falls back and says so.
    expect(find.textContaining('Source: Rule-based'), findsOneWidget);
    expect(find.textContaining('On-board model unavailable'), findsOneWidget);
    expect(find.text('AI-generated'), findsNothing);
    app.expectNoErrors();
  });

  testWidgets('cloud choice falls back when no key is configured', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openProfile(tester);
    await scrollTo(tester, find.text('Cloud model'));
    await tester.tap(find.text('Cloud model'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Cloud model unavailable'), findsOneWidget);
    app.expectNoErrors();
  });

  const importedJson = '''
{
  "id": "sam-lee", "displayName": "Sam Lee", "role": "Pilot",
  "bigFive": {"openness": 60, "conscientiousness": 55, "extraversion": 40, "agreeableness": 70, "emotionalStability": 65},
  "locusOfControl": "mixed", "copingStyle": "avoidant", "boredomProneness": 45,
  "baseline": {"sleepHours": 7, "mood": 6, "stress": 5, "workload": 5, "engagement": 6, "focus": 7, "connection": 6, "reactionMs": 260, "restingHeartRate": 60, "hrv": 58},
  "preferences": {"tone": "gentle", "preferredActions": ["window_time", "journal"]}
}
''';

  testWidgets('import loads a different person without code changes', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      size: const Size(390, 844),
      overrides: [
        profileFilePickerProvider.overrideWithValue((_) async => importedJson),
      ],
    );
    await openProfile(tester);
    await scrollTo(tester, find.text('Import profile JSON'));
    await tester.tap(find.text('Import profile JSON'));
    await tester.pumpAndSettle();
    expect(find.text('Imported Sam Lee.'), findsOneWidget);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 4000));
    await tester.pumpAndSettle();
    expect(find.text('Sam Lee'), findsOneWidget);
    expect(find.textContaining('Imported file'), findsOneWidget);
    app.expectNoErrors();
  });

  for (final bad in ['not json at all', '{"id": "x"}', '[1, 2]']) {
    testWidgets(
      'bad file "$bad" shows a readable error and keeps the profile',
      (tester) async {
        final app = await pumpApp(
          tester,
          size: const Size(390, 844),
          overrides: [
            profileFilePickerProvider.overrideWithValue((_) async => bad),
          ],
        );
        await openProfile(tester);
        await scrollTo(tester, find.text('Import profile JSON'));
        await tester.tap(find.text('Import profile JSON'));
        await tester.pumpAndSettle();
        expect(
          find.textContaining("Couldn't import this file."),
          findsOneWidget,
        );
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 4000));
        await tester.pumpAndSettle();
        expect(find.text('Maya Reyes'), findsOneWidget);
        app.expectNoErrors();
      },
    );
  }

  testWidgets('cancelling the picker changes nothing', (tester) async {
    final app = await pumpApp(
      tester,
      size: const Size(390, 844),
      overrides: [
        profileFilePickerProvider.overrideWithValue((_) async => null),
      ],
    );
    await openProfile(tester);
    await scrollTo(tester, find.text('Import profile JSON'));
    await tester.tap(find.text('Import profile JSON'));
    await tester.pumpAndSettle();
    expect(find.textContaining("Couldn't import"), findsNothing);
    app.expectNoErrors();
  });

  testWidgets('profile fits a wide window', (tester) async {
    final app = await pumpApp(tester, size: const Size(1280, 800));
    await tester.tap(find.byTooltip('Profile and settings'));
    await tester.pumpAndSettle();
    expect(find.text('Profile'), findsOneWidget);
    app.expectNoErrors();
  });
}
