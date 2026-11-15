import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_app.dart';

void main() {
  setUpAll(loadAppFonts);

  Future<void> openCheckIn(WidgetTester tester, Size size) async {
    await tester.tap(find.text('Check in'));
    await tester.pumpAndSettle();
  }

  testWidgets('phone: six sliders, scrolls, logging bumps the streak', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 700));
    await openCheckIn(tester, const Size(390, 700));
    expect(find.text("Captain's log"), findsOneWidget);
    expect(find.text('0-day streak'), findsOneWidget);
    expect(find.byType(Slider, skipOffstage: false), findsAtLeastNWidgets(1));

    for (final label in [
      'Mood',
      'Stress',
      'Workload',
      'Engagement',
      'Focus',
      'Crew connection',
    ]) {
      await scrollTo(tester, find.text(label));
    }

    await scrollTo(tester, find.text('Something happened at home'));
    expect(find.text('Private note'), findsNothing);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Private note'));
    await tester.enterText(find.byType(TextField), 'Dad is in hospital');
    await tester.pumpAndSettle();

    await scrollTo(tester, find.text('Log entry'));
    await tester.tap(find.text('Log entry'));
    await tester.pumpAndSettle();
    expect(find.text('Entry logged. Thank you.'), findsOneWidget);

    await tester.drag(find.byType(Scrollable).first, const Offset(0, 2000));
    await tester.pumpAndSettle();
    expect(find.text('1-day streak'), findsOneWidget);
    expect(find.text("Update today's entry"), findsNothing);
    app.expectNoErrors();
  });

  testWidgets('streak counts the entry, not the scores', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openCheckIn(tester, const Size(390, 844));
    // Drag the first slider to its lowest value.
    await tester.drag(find.byType(Slider).first, const Offset(-400, 0));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Log entry'));
    await tester.tap(find.text('Log entry'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 2000));
    await tester.pumpAndSettle();
    expect(find.text('1-day streak'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('logged check-in changes Home and shows life-event support', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openCheckIn(tester, const Size(390, 844));
    await scrollTo(tester, find.text('Something happened at home'));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Log entry'));
    await tester.tap(find.text('Log entry'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Something happened at home'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('tablet layout keeps the form centred without overflow', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(900, 900));
    await tester.tap(find.text('Check in'));
    await tester.pumpAndSettle();
    expect(find.text("Captain's log"), findsOneWidget);
    app.expectNoErrors();
  });
}
