import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

Future<void> tapText(WidgetTester tester, String text, {int index = 0}) async {
  final f = find.text(text).at(index);
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

FilledButton nextButton(WidgetTester tester) =>
    tester.widget<FilledButton>(find.byType(FilledButton));

void main() {
  setUpAll(loadAppFonts);

  testWidgets('questionnaire creates and saves a profile', (tester) async {
    final app = await pumpApp(
      tester,
      size: const Size(390, 700),
      withProfile: false,
    );
    expect(find.text('Welcome aboard'), findsOneWidget);

    // Next stays disabled until a name is entered.
    expect(nextButton(tester).onPressed, isNull);
    await tester.enterText(find.byType(TextField).first, 'Test Pilot');
    await tester.enterText(find.byType(TextField).last, 'Pilot');
    await tester.pumpAndSettle();
    expect(nextButton(tester).onPressed, isNotNull);
    await tapText(tester, 'Next');
    await tapText(tester, 'Back');
    expect(find.text('Welcome aboard'), findsOneWidget);
    await tapText(tester, 'Next');

    for (var page = 0; page < 4; page++) {
      // Disabled until every item on the page is answered.
      expect(nextButton(tester).onPressed, isNull);
      for (var i = 0; i < 5; i++) {
        await tapText(tester, '4', index: i);
      }
      expect(nextButton(tester).onPressed, isNotNull);
      await tapText(tester, 'Next');
    }

    expect(find.text('When things go well or badly'), findsOneWidget);
    expect(nextButton(tester).onPressed, isNull);
    await tapText(tester, 'A mix of both');
    await tapText(tester, 'Next');

    expect(find.text('How should Psychonaut talk to you?'), findsOneWidget);
    await tapText(tester, 'Direct');
    await tapText(tester, 'Gentle');
    await tapText(tester, 'Next');

    expect(find.text('What helps you reset?'), findsOneWidget);
    expect(nextButton(tester).onPressed, isNull);
    await tapText(tester, 'Journal');
    await tapText(tester, 'Exercise');
    await tapText(tester, 'Window and garden time');
    await tapText(tester, 'Window and garden time');
    await tapText(tester, 'Next');

    expect(find.text('Your profile'), findsOneWidget);
    expect(find.text('Emotional stability'), findsOneWidget);
    await tapText(tester, 'Create profile');

    expect(find.text('Your heading'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    final saved =
        jsonDecode(prefs.getString('profile')!) as Map<String, dynamic>;
    expect(saved['id'], 'test-pilot');
    expect(saved['role'], 'Pilot');
    expect(saved['source'], 'mini-ipip');
    expect(saved['locusOfControl'], 'mixed');
    expect((saved['preferences'] as Map)['tone'], 'gentle');
    expect((saved['preferences'] as Map)['preferredActions'], [
      'journal',
      'exercise',
    ]);
    app.expectNoErrors();
  });

  testWidgets('a sample profile can be loaded from the first step', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      size: const Size(390, 844),
      withProfile: false,
    );
    await tester.tap(find.text('Lena Voss, Mission Specialist'));
    await tester.pumpAndSettle();
    expect(find.text('Your heading'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('wide windows keep the form readable', (tester) async {
    final app = await pumpApp(
      tester,
      size: const Size(1280, 800),
      withProfile: false,
    );
    expect(find.text('Welcome aboard'), findsOneWidget);
    app.expectNoErrors();
  });

  testWidgets('a retake can be cancelled', (tester) async {
    final app = await pumpApp(tester, size: const Size(390, 844));
    await tester.tap(find.byTooltip('Profile and settings'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Retake the questionnaire'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Retake the questionnaire'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Retake the questionnaire'));
    await tester.pumpAndSettle();
    await tapText(tester, 'Cancel and keep my current profile');
    expect(find.text('Your heading'), findsOneWidget);
    app.expectNoErrors();
  });
}
