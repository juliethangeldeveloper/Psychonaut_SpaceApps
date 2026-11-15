import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_app.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('first launch with no profile shows onboarding', (tester) async {
    final app = await pumpApp(
      tester,
      size: const Size(390, 844),
      withProfile: false,
    );
    expect(find.text('Welcome aboard'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('phone layout: bottom bar, tiles, detail on tap', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    expect(find.text('Your heading'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.text("Today's reading"), findsOneWidget);
    expect(find.textContaining('Source: Rule-based'), findsOneWidget);
    expect(find.text('Sample data'), findsOneWidget);

    await scrollTo(tester, find.text('Sleep'));
    await tester.tap(find.text('Sleep'));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Why it matters'));
    expect(find.text("How it's measured"), findsOneWidget);
    expect(find.text('What to do now'), findsOneWidget);
    expect(find.textContaining('Inadequate sleep'), findsOneWidget);

    await scrollTo(
      tester,
      find.text('Psychonaut does not diagnose or replace a clinician.'),
    );
    app.expectNoErrors();
  });

  testWidgets('tablet layout: rail and two columns', (tester) async {
    final app = await pumpApp(tester, size: const Size(800, 900));
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Mood'), findsWidgets);
    expect(find.text("Today's reading"), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('console layout: three panels visible together', (tester) async {
    final app = await pumpApp(tester, size: const Size(1280, 800));
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Sleep, 14 nights'), findsOneWidget);
    expect(find.text("How it's measured"), findsOneWidget);
    expect(find.text('Reaction time'), findsWidgets);
    app.expectNoErrors();
  });

  for (final id in ['idris-okafor', 'lena-voss']) {
    testWidgets('$id renders on a 390 wide phone', (tester) async {
      final app = await pumpApp(
        tester,
        size: const Size(390, 844),
        profileId: id,
      );
      expect(find.text("Today's reading"), findsOneWidget);
      app.expectNoErrors();
    });
  }
}
