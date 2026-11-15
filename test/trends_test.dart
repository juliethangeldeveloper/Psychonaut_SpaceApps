import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_app.dart';

void main() {
  setUpAll(loadAppFonts);

  Future<void> openTrends(WidgetTester tester) async {
    await tester.tap(find.text('Trends'));
    await tester.pumpAndSettle();
  }

  testWidgets('phone: sleep chart, reaction chart, why it matters, actions', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openTrends(tester);
    expect(find.text('Course deviation'), findsOneWidget);
    expect(find.text('Sleep, last 14 nights'), findsOneWidget);
    expect(find.textContaining('Your baseline 7.2 h'), findsOneWidget);
    // Status words sit next to the colours in the chart legend.
    expect(find.text('On course'), findsWidgets);

    await scrollTo(tester, find.text('Reaction time'));
    await scrollTo(tester, find.text('Why it matters'));
    expect(find.textContaining('Inadequate sleep'), findsOneWidget);
    await scrollTo(tester, find.text('Course corrections'));
    app.expectNoErrors();
  });

  testWidgets('course corrections follow the profile and are selectable', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await openTrends(tester);
    await scrollTo(tester, find.text('Course corrections'));
    // Maya prefers sleep reset, then window and garden time, then message home.
    final sleep = find.text('Sleep reset');
    final garden = find.text('Window and garden time');
    final home = find.text('Message home');
    await scrollTo(tester, home);
    expect(sleep, findsOneWidget);
    expect(garden, findsOneWidget);
    expect(
      tester.getTopLeft(sleep).dy < tester.getTopLeft(garden).dy &&
          tester.getTopLeft(garden).dy < tester.getTopLeft(home).dy,
      isTrue,
    );
    expect(find.text('Suggested'), findsOneWidget);

    expect(find.textContaining('Your plan:'), findsNothing);
    await tester.tap(garden);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Your plan: Window and garden time'),
      findsOneWidget,
    );
    await tester.tap(garden);
    await tester.pumpAndSettle();
    expect(find.textContaining('Your plan:'), findsNothing);
    app.expectNoErrors();
  });

  testWidgets('another profile is offered different actions first', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      size: const Size(390, 844),
      profileId: 'idris-okafor',
    );
    await openTrends(tester);
    await scrollTo(tester, find.text('Course corrections'));
    await scrollTo(tester, find.text('Journal'));
    expect(find.text('Start a small project'), findsOneWidget);
    expect(find.text('Exercise'), findsOneWidget);
    expect(find.text('Sleep reset'), findsNothing);
    app.expectNoErrors();
  });

  for (final size in const [Size(800, 900), Size(1280, 800)]) {
    testWidgets('two columns without overflow at ${size.width.toInt()} wide', (
      tester,
    ) async {
      final app = await pumpApp(tester, size: size);
      await openTrends(tester);
      expect(find.text('Sleep, last 14 nights'), findsOneWidget);
      expect(find.text('Why it matters'), findsOneWidget);
      app.expectNoErrors();
    });
  }
}
