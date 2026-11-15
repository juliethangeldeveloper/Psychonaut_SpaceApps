import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:psychonaut_application/app/providers.dart';
import 'package:psychonaut_application/l10n/l10n.dart';
import 'package:psychonaut_application/models/app_settings.dart';
import 'package:psychonaut_application/models/health_models.dart';
import 'package:psychonaut_application/models/status.dart';
import 'package:psychonaut_application/services/format.dart';
import 'package:psychonaut_application/services/insight_coordinator.dart';
import 'package:psychonaut_application/services/insight_service.dart';
import 'package:psychonaut_application/services/rule_based_insight_service.dart';

import 'risk_engine_test.dart' as f;
import 'test_app.dart';

const _locales = ['en', 'es', 'fr', 'ja', 'ar', 'ru'];

Map<String, dynamic> _arb(String code) =>
    jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
        as Map<String, dynamic>;

Set<String> _placeholders(String s) =>
    RegExp(r'\{(\w+)(?:,|\})').allMatches(s).map((m) => m.group(1)!).toSet();

InsightContext _ctx(String code, {List<double>? sleep}) => InsightContext(
  profile: f.profile(),
  assessment: f.run(m: f.metrics(sleep: sleep)),
  metrics: f.metrics(),
  checkIns: f.checkIns(),
  missionDay: 100,
  l10n: lookupAppLocalizations(Locale(code)),
);

void main() {
  setUpAll(loadAppFonts);

  group('translation files', () {
    final en = _arb('en');
    final keys = en.keys.where((k) => !k.startsWith('@')).toSet();

    test('every language has exactly the English keys', () {
      for (final code in _locales.skip(1)) {
        final other = _arb(code).keys.where((k) => !k.startsWith('@')).toSet();
        expect(other.difference(keys), isEmpty, reason: '$code has extra keys');
        expect(
          keys.difference(other),
          isEmpty,
          reason: '$code is missing keys',
        );
      }
    });

    test('placeholders match the English text and nothing is empty', () {
      for (final code in _locales) {
        final arb = _arb(code);
        for (final k in keys) {
          final text = arb[k] as String;
          expect(text.trim(), isNotEmpty, reason: '$code/$k');
          expect(
            _placeholders(text),
            _placeholders(en[k] as String),
            reason: '$code/$k',
          );
        }
      }
    });

    test('non-English text is actually translated', () {
      for (final code in _locales.skip(1)) {
        final arb = _arb(code);
        final same = keys.where((k) => arb[k] == en[k]).toList();
        // Names, units and symbols may legitimately match English.
        expect(same.length, lessThan(keys.length ~/ 8), reason: '$code: $same');
      }
    });
  });

  group('generated localizations', () {
    test('every supported language resolves and has its own words', () {
      expect(
        AppLocalizations.supportedLocales.map((l) => l.languageCode),
        unorderedEquals(_locales),
      );
      expect(lookupAppLocalizations(const Locale('en')).navHome, 'Home');
      expect(lookupAppLocalizations(const Locale('es')).navHome, 'Inicio');
      expect(lookupAppLocalizations(const Locale('fr')).navHome, 'Accueil');
      expect(lookupAppLocalizations(const Locale('ja')).navHome, 'ホーム');
      expect(lookupAppLocalizations(const Locale('ar')).navHome, 'الرئيسية');
      expect(lookupAppLocalizations(const Locale('ru')).navHome, 'Главная');
    });

    test('plurals follow each language', () {
      final en = lookupAppLocalizations(const Locale('en'));
      expect(en.insNights(1), contains('1 recent night '));
      expect(en.insNights(3), contains('3 recent nights'));
      final es = lookupAppLocalizations(const Locale('es'));
      expect(es.insNights(1), contains('1 noche'));
      expect(es.insNights(3), contains('3 noches'));
      // Russian has three count forms: 1 and 21, 2 to 4, and 5 to 20.
      final ru = lookupAppLocalizations(const Locale('ru'));
      expect(ru.insNights(1), contains('1 недавняя ночь'));
      expect(ru.insNights(3), contains('3 недавние ночи'));
      expect(ru.insNights(5), contains('5 недавних ночей'));
      expect(ru.insNights(21), contains('21 недавняя ночь'));
      expect(formatNumber(ru, 6.4), '6,4');
    });

    test('the alert message is fixed text in every language', () {
      final english = lookupAppLocalizations(const Locale('en')).alertMessage;
      expect(
        english,
        'Tell your crew medical officer and prepare a summary for Earth',
      );
      for (final code in _locales.skip(1)) {
        expect(
          lookupAppLocalizations(Locale(code)).alertMessage,
          isNot(english),
        );
      }
    });

    test('status, indicator, action and phase labels are localized', () {
      final fr = lookupAppLocalizations(const Locale('fr'));
      expect(Status.onCourse.label(fr), 'Sur la bonne trajectoire');
      expect(Indicator.sleep.label(fr), 'Sommeil');
      expect(Indicator.reaction.label(fr), 'Temps de réaction');
      for (final code in _locales) {
        final l = lookupAppLocalizations(Locale(code));
        for (final i in Indicator.values) {
          expect(i.label(l), isNotEmpty);
          expect(l.measured(i), isNotEmpty);
          expect(l.why(i), isNotEmpty);
          expect(l.todo(i), isNotEmpty);
        }
        for (var n = 0; n < 20; n++) {
          expect(l.ipipItem(n), isNotEmpty);
        }
        for (var n = 1; n <= 5; n++) {
          expect(l.ipipAnswer(n), isNotEmpty);
        }
      }
    });
  });

  group('number formatting and locale choice', () {
    test('decimals follow the language', () {
      expect(
        formatNumber(lookupAppLocalizations(const Locale('en')), 6.4),
        '6.4',
      );
      expect(
        formatNumber(lookupAppLocalizations(const Locale('fr')), 6.4),
        '6,4',
      );
      expect(
        formatNumber(lookupAppLocalizations(const Locale('es')), 6.4),
        '6,4',
      );
      expect(
        formatValue(
          lookupAppLocalizations(const Locale('ja')),
          Indicator.sleep,
          6.4,
        ),
        '6.4時間',
      );
      expect(
        formatValue(
          lookupAppLocalizations(const Locale('en')),
          Indicator.reaction,
          249.6,
        ),
        '250 ms',
      );
    });

    test('the chosen language wins, then the device, then English', () {
      expect(resolveAppLocale('fr', const Locale('ja')), const Locale('fr'));
      expect(
        resolveAppLocale(null, const Locale('ja', 'JP')),
        const Locale('ja'),
      );
      expect(resolveAppLocale(null, const Locale('de')), const Locale('en'));
      expect(resolveAppLocale('xx', const Locale('ja')), const Locale('en'));
    });

    test('settings remember the language', () {
      const s = AppSettings();
      expect(s.languageCode, isNull);
      final fr = s.copyWith(languageCode: 'fr');
      expect(AppSettings.fromJson(fr.toJson()).languageCode, 'fr');
      expect(fr.copyWith(followDeviceLanguage: true).languageCode, isNull);
    });
  });

  group('written insights', () {
    test('rule-based text is produced in each language', () async {
      const service = RuleBasedInsightService();
      final slow = f.series(7, f.repeat(6.0, 3));
      final seen = <String>{};
      for (final code in _locales) {
        final i = await service.generate(_ctx(code, sleep: slow));
        expect(i.summary, isNotEmpty);
        expect(i.explanation, isNotEmpty);
        seen.add(i.summary);
      }
      expect(seen, hasLength(_locales.length));
    });

    test('the fixed alert message is translated and never generated', () async {
      final coordinator = InsightCoordinator(
        ruleBased: const RuleBasedInsightService(),
      );
      final alertSleep = f.series(7, f.repeat(4.5, 3));
      final es = await coordinator.resolve(
        _ctx('es', sleep: alertSleep),
        AiSource.cloud,
      );
      expect(es.fixedAlert, isTrue);
      expect(
        es.summary,
        lookupAppLocalizations(const Locale('es')).alertMessage,
      );
      final ja = await coordinator.resolve(
        _ctx('ja', sleep: alertSleep),
        AiSource.ruleBased,
      );
      expect(
        ja.summary,
        lookupAppLocalizations(const Locale('ja')).alertMessage,
      );
    });

    test('fallback notes are translated', () async {
      final coordinator = InsightCoordinator(
        ruleBased: const RuleBasedInsightService(),
      );
      final i = await coordinator.resolve(_ctx('fr'), AiSource.onBoard);
      expect(i.note, contains('Modèle embarqué'));
    });
  });

  group('screens in each language', () {
    for (final code in ['es', 'fr', 'ja', 'ar', 'ru']) {
      testWidgets('Home renders in $code without overflow', (tester) async {
        final app = await pumpApp(
          tester,
          size: const Size(390, 844),
          overrides: [deviceLocaleProvider.overrideWithValue(Locale(code))],
        );
        final l = lookupAppLocalizations(Locale(code));
        expect(find.text(l.homeTitle), findsOneWidget);
        expect(find.text(l.navHome), findsOneWidget);
        expect(find.text(l.readingTitle), findsOneWidget);
        expect(find.text(l.disclaimer), findsNothing);
        await scrollTo(tester, find.text(l.disclaimer));
        expect(find.text(l.disclaimer), findsOneWidget);
        app.expectNoErrors();
      });
    }

    testWidgets('Arabic lays out right to left, others left to right', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        size: const Size(390, 844),
        overrides: [deviceLocaleProvider.overrideWithValue(const Locale('ar'))],
      );
      final element = tester.element(find.byType(NavigationBar));
      expect(Directionality.of(element), TextDirection.rtl);
      app.expectNoErrors();
    });

    testWidgets('English stays left to right', (tester) async {
      final app = await pumpApp(tester, size: const Size(390, 844));
      expect(
        Directionality.of(tester.element(find.byType(NavigationBar))),
        TextDirection.ltr,
      );
      app.expectNoErrors();
    });

    testWidgets('choosing a language in settings switches the whole app', (
      tester,
    ) async {
      final app = await pumpApp(tester, size: const Size(390, 844));
      await tester.tap(find.byTooltip('Profile and settings'));
      await tester.pumpAndSettle();
      await scrollTo(tester, find.text('Español'));
      await tester.tap(find.text('Español'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Scrollable).first, const Offset(0, 6000));
      await tester.pumpAndSettle();
      expect(find.text('Perfil'), findsOneWidget);
      await tester.tap(find.byTooltip('Atrás'));
      await tester.pumpAndSettle();
      expect(find.text('Tu rumbo'), findsOneWidget);
      expect(find.text('Inicio'), findsOneWidget);
      expect(find.text('Registro'), findsOneWidget);
      app.expectNoErrors();
    });

    for (final code in ['es', 'ja', 'ar', 'ru']) {
      testWidgets('check-in, trends, crew and profile fit in $code', (
        tester,
      ) async {
        final app = await pumpApp(
          tester,
          size: const Size(390, 844),
          overrides: [deviceLocaleProvider.overrideWithValue(Locale(code))],
        );
        final l = lookupAppLocalizations(Locale(code));
        for (final tab in [l.navCheckIn, l.navTrends, l.navCrew]) {
          await tester.tap(find.text(tab));
          await tester.pumpAndSettle();
        }
        expect(find.text(l.crewTitle), findsOneWidget);
        await tester.tap(find.text(l.navCheckIn));
        await tester.pumpAndSettle();
        expect(find.text(l.checkinTitle), findsOneWidget);
        await tester.tap(find.text(l.navTrends));
        await tester.pumpAndSettle();
        expect(find.text(l.trendsTitle), findsOneWidget);
        app.expectNoErrors();
      });
    }

    testWidgets('onboarding questionnaire appears in French', (tester) async {
      final app = await pumpApp(
        tester,
        size: const Size(390, 700),
        withProfile: false,
        overrides: [deviceLocaleProvider.overrideWithValue(const Locale('fr'))],
      );
      expect(find.text('Bienvenue à bord'), findsOneWidget);
      app.expectNoErrors();
    });
  });
}
