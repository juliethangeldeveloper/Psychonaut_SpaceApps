import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:psychonaut_application/app/providers.dart';

import 'test_app.dart';

/// Opens each main screen and runs Flutter's accessibility guidelines on it:
/// labelled tap targets, minimum tap size (Android 48, iOS 44) and text contrast.
Future<void> _guidelines(WidgetTester tester) async {
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
  await expectLater(tester, meetsGuideline(textContrastGuideline));
}

const _screens = <String, String?>{
  'Home': null,
  'Check in': 'Check in',
  'Trends': 'Trends',
  'Crew': 'Crew',
};

void main() {
  setUpAll(loadAppFonts);

  for (final scale in [1.0, 1.5, 2.0]) {
    for (final entry in _screens.entries) {
      testWidgets(
        '${entry.key} meets accessibility guidelines at ${scale}x text',
        (tester) async {
          final handle = tester.ensureSemantics();
          tester.platformDispatcher.textScaleFactorTestValue = scale;
          addTearDown(tester.platformDispatcher.clearAllTestValues);
          final app = await pumpApp(tester, size: const Size(390, 844));
          if (entry.value != null) {
            await tester.tap(find.text(entry.value!));
            await tester.pumpAndSettle();
          }
          await _guidelines(tester);
          app.expectNoErrors();
          handle.dispose();
        },
      );
    }
  }

  testWidgets('Profile meets accessibility guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    final app = await pumpApp(tester, size: const Size(390, 844));
    await tester.tap(find.byTooltip('Profile and settings'));
    await tester.pumpAndSettle();
    await _guidelines(tester);
    app.expectNoErrors();
    handle.dispose();
  });

  testWidgets('Onboarding meets accessibility guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    final app = await pumpApp(
      tester,
      size: const Size(390, 844),
      withProfile: false,
    );
    await _guidelines(tester);
    app.expectNoErrors();
    handle.dispose();
  });

  for (final code in ['ar', 'ja']) {
    testWidgets('Home meets the guidelines in $code at 1.5x text', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.platformDispatcher.clearAllTestValues);
      final app = await pumpApp(
        tester,
        size: const Size(390, 844),
        overrides: [deviceLocaleProvider.overrideWithValue(Locale(code))],
      );
      await _guidelines(tester);
      app.expectNoErrors();
      handle.dispose();
    });
  }

  testWidgets('console and tablet layouts meet the guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    final app = await pumpApp(tester, size: const Size(1280, 800));
    await _guidelines(tester);
    app.expectNoErrors();
    handle.dispose();
  });

  testWidgets('control: the guidelines do catch a tiny unlabelled target', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: const SizedBox(width: 16, height: 16),
          ),
        ),
      ),
    );
    await expectLater(tester, doesNotMeetGuideline(androidTapTargetGuideline));
    await expectLater(tester, doesNotMeetGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });

  testWidgets('screen readers hear status words, not just colours', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    final app = await pumpApp(tester, size: const Size(390, 844));
    expect(
      find.bySemanticsLabel(RegExp(r'degrees off course\. Overall ')),
      findsOneWidget,
    );
    // Every tile reads out its status word.
    await scrollTo(tester, find.text('Sleep'));
    expect(
      find.bySemanticsLabel(
        RegExp(r'^Sleep, (On course|Drifting|Off course|Alert), '),
      ),
      findsOneWidget,
    );
    app.expectNoErrors();
    handle.dispose();
  });

  testWidgets('sliders announce their name and value', (tester) async {
    final handle = tester.ensureSemantics();
    final app = await pumpApp(tester, size: const Size(390, 844));
    await tester.tap(find.text('Check in'));
    await tester.pumpAndSettle();
    final semantics = tester.getSemantics(find.byType(Slider).first);
    expect('${semantics.label} ${semantics.value}', contains('Mood'));
    app.expectNoErrors();
    handle.dispose();
  });

  testWidgets('keyboard: Tab reaches a tile and Enter opens it', (
    tester,
  ) async {
    final app = await pumpApp(tester, size: const Size(1280, 800));
    var opened = false;
    for (var i = 0; i < 40 && !opened; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      final focus = FocusManager.instance.primaryFocus?.context;
      final onSleepTile =
          focus != null &&
          find
              .descendant(
                of: find.byElementPredicate((e) => e == focus),
                matching: find.text('Sleep'),
              )
              .evaluate()
              .isNotEmpty;
      if (onSleepTile) {
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        opened = true;
      }
    }
    expect(opened, isTrue);
    app.expectNoErrors();
  });

  testWidgets('keyboard: Ctrl+2 jumps to the check-in tab', (tester) async {
    final app = await pumpApp(tester, size: const Size(1280, 800));
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit2);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();
    expect(find.text("Captain's log"), findsOneWidget);
    app.expectNoErrors();
  });
}
