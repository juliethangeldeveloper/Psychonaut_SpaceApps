import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:psychonaut_application/features/crew/crew_data.dart';

import 'test_app.dart';

void main() {
  setUpAll(loadAppFonts);

  test('morale levels', () {
    expect(moraleLevel(80), MoraleLevel.high);
    expect(moraleLevel(75), MoraleLevel.high);
    expect(moraleLevel(60), MoraleLevel.steady);
    expect(moraleLevel(40), MoraleLevel.strained);
    expect(moraleLevel(10), MoraleLevel.low);
  });

  Future<void> openCrew(WidgetTester tester) async {
    await tester.tap(find.text('Crew'));
    await tester.pumpAndSettle();
  }

  testWidgets('meter, goal with 6 segments, privacy card, no leaderboard', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openCrew(tester);
    expect(find.text('Ship morale'), findsOneWidget);
    expect(find.text('Steady'), findsOneWidget);
    expect(find.textContaining('Names are never shown'), findsOneWidget);
    expect(find.text('Sample data'), findsOneWidget);
    await scrollTo(tester, find.text('Join this goal'));
    expect(find.textContaining('4 of 6 evenings done'), findsOneWidget);
    await scrollTo(tester, find.text('Your privacy'));
    for (final word in ['leaderboard', 'Leaderboard', 'rank #']) {
      expect(find.textContaining(word), findsNothing);
    }
    app.expectNoErrors();
  });

  testWidgets('joining and leaving the goal', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openCrew(tester);
    await scrollTo(tester, find.text('Join this goal'));
    expect(find.textContaining('4 crew joined'), findsOneWidget);
    await tester.tap(find.text('Join this goal'));
    await tester.pumpAndSettle();
    expect(find.textContaining('5 crew joined'), findsOneWidget);
    expect(find.text("You've joined. Tap to leave"), findsOneWidget);
    await tester.tap(find.text("You've joined. Tap to leave"));
    await tester.pumpAndSettle();
    expect(find.text('Join this goal'), findsOneWidget);
    app.expectNoErrors();
  });

  for (final size in const [Size(800, 900), Size(1280, 800)]) {
    testWidgets('fits at ${size.width.toInt()} wide', (tester) async {
      final app = await pumpApp(tester, size: size);
      await openCrew(tester);
      expect(find.text('Ship morale'), findsOneWidget);
      app.expectNoErrors();
    });
  }
}
