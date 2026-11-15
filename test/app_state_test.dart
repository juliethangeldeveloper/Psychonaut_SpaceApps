import 'dart:convert';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:psychonaut_application/app/layout.dart';
import 'package:psychonaut_application/app/providers.dart';
import 'package:psychonaut_application/data/local_store.dart';
import 'package:psychonaut_application/data/mock_health_data_source.dart';
import 'package:psychonaut_application/data/profile_repository.dart';
import 'package:psychonaut_application/data/reference_content.dart';
import 'package:psychonaut_application/features/crew/crew_data.dart';
import 'package:psychonaut_application/l10n/l10n.dart';
import 'package:psychonaut_application/models/app_settings.dart';
import 'package:psychonaut_application/models/health_models.dart';
import 'package:psychonaut_application/models/status.dart';
import 'package:psychonaut_application/services/insight_service.dart';
import 'package:psychonaut_application/services/rule_based_insight_service.dart';
import 'package:psychonaut_application/theme/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'risk_engine_test.dart' as f;

const _mayaJson = '''
{"id":"maya-reyes","displayName":"Maya Reyes","role":"Commander","source":"mini-ipip",
"bigFive":{"openness":72,"conscientiousness":88,"extraversion":55,"agreeableness":64,"emotionalStability":78},
"locusOfControl":"internal","copingStyle":"problem_focused","boredomProneness":35,
"baseline":{"sleepHours":7.2,"mood":7,"stress":4,"workload":5,"engagement":7,"focus":7,"connection":7,"reactionMs":250,"restingHeartRate":58,"hrv":62},
"preferences":{"tone":"direct","preferredActions":["sleep_reset"]}}''';

base class _FakeFile extends PlatformFile {
  _FakeFile(this._bytes);

  final Uint8List _bytes;

  @override
  String get name => 'profile.json';

  @override
  Uri get uri => Uri.parse('file:///profile.json');

  @override
  XFile get xFile => XFile.fromData(_bytes);

  @override
  Future<Uint8List> readAsBytes() async => _bytes;

  @override
  int? lengthSync() => _bytes.length;

  @override
  Future<int?> length() async => _bytes.length;

  @override
  Stream<Uint8List> readAsByteStream() => Stream.value(_bytes);
}

class _FakePicker extends FilePickerPlatform {
  _FakePicker(this.result);

  final PlatformFile? result;
  String? title;

  @override
  Future<PlatformFile?> pickFile({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(),
    DarwinOptions darwinOptions = const DarwinOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
  }) async {
    title = dialogTitle;
    return result;
  }
}

Future<ProviderContainer> _container({
  bool withProfile = true,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues({
    if (withProfile) 'profile': _mayaJson,
    ...prefs,
  });
  final sp = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(sp)],
  );
  addTearDown(c.dispose);
  return c;
}

CheckIn _entry(DateTime d, {bool lifeEvent = false, String? note}) => CheckIn(
  date: d,
  mood: 6,
  stress: 5,
  workload: 4,
  engagement: 7,
  focus: 6,
  connection: 8,
  lifeEvent: lifeEvent,
  note: note,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('local store', () {
    test('round-trips settings, check-ins and reaction results', () async {
      SharedPreferences.setMockInitialValues({});
      final store = LocalStore(await SharedPreferences.getInstance());
      final start = DateTime(2026, 1, 1);
      await store.saveSettings(
        AppSettings(
          aiSource: AiSource.cloud,
          missionStart: start,
          languageCode: 'ja',
        ),
      );
      final s = store.loadSettings();
      expect(s.aiSource, AiSource.cloud);
      expect(s.missionStart, start);
      expect(s.languageCode, 'ja');

      await store.saveCheckIns('me', [
        _entry(DateTime(2026, 2, 1), lifeEvent: true, note: 'call home'),
      ]);
      final c = store.loadCheckIns('me').single;
      expect(c.lifeEvent, isTrue);
      expect(c.note, 'call home');
      expect(c.connection, 8);
      expect(store.loadCheckIns('someone-else'), isEmpty);

      final when = DateTime(2026, 2, 2, 9, 30);
      await store.saveReactions('me', [
        ReactionResult(
          date: when,
          meanMs: 262.5,
          lapses: 2,
          falseStarts: 1,
          trials: 48,
        ),
      ]);
      final r = store.loadReactions('me').single;
      expect(r.meanMs, 262.5);
      expect(r.lapses, 2);
      expect(r.falseStarts, 1);
      expect(r.trials, 48);
      expect(r.date, when);

      expect(store.crewJoined, isFalse);
      await store.setCrewJoined(true);
      expect(store.crewJoined, isTrue);
    });

    test('damaged data falls back to defaults instead of crashing', () async {
      SharedPreferences.setMockInitialValues({
        'profile': 'not json',
        'settings': '{{{',
        'checkins_me': 'nope',
        'reactions_me': '[1, 2]',
      });
      final store = LocalStore(await SharedPreferences.getInstance());
      expect(store.loadProfile(), isNull);
      expect(store.loadSettings().aiSource, AiSource.ruleBased);
      expect(store.loadCheckIns('me'), isEmpty);
      expect(store.loadReactions('me'), isEmpty);
    });
  });

  group('providers', () {
    test('shared preferences must be provided', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      expect(() => c.read(sharedPreferencesProvider), throwsA(anything));
    });

    test(
      'without a profile there is no data and loading fails clearly',
      () async {
        final c = await _container(withProfile: false);
        expect(c.read(profileProvider), isNull);
        expect(c.read(checkInsProvider), isEmpty);
        expect(c.read(reactionsProvider), isEmpty);
        expect(c.read(assessmentProvider).isLoading, isTrue);
        await expectLater(c.read(snapshotProvider.future), throwsStateError);
      },
    );

    test(
      'defaults: sample data source and the file picker are wired',
      () async {
        final c = await _container();
        expect(c.read(healthDataSourceProvider).isSample, isTrue);
        expect(c.read(profileFilePickerProvider), isNotNull);
        expect(c.read(deviceLocaleProvider), isA<Locale>());
        expect(c.read(localeProvider).languageCode, isNotEmpty);
        expect(c.read(l10nProvider), isA<AppLocalizations>());
      },
    );

    test('language can be chosen and cleared', () async {
      final c = await _container();
      final n = c.read(settingsProvider.notifier);
      await n.setLanguage('fr');
      expect(c.read(localeProvider).languageCode, 'fr');
      await n.setLanguage(null);
      expect(c.read(settingsProvider).languageCode, isNull);
    });

    test('mission day follows the settings', () async {
      final c = await _container();
      expect(c.read(missionDayProvider), 112);
      await c.read(settingsProvider.notifier).setMissionDay(151);
      expect(c.read(missionDayProvider), 151);
    });

    test('reaction results are added and saved', () async {
      final c = await _container();
      await c
          .read(reactionsProvider.notifier)
          .add(
            ReactionResult(
              date: DateTime(2026, 3, 1),
              meanMs: 255,
              lapses: 1,
              falseStarts: 0,
              trials: 50,
            ),
          );
      expect(c.read(reactionsProvider), hasLength(1));
      final store = c.read(localStoreProvider);
      expect(store.loadReactions('maya-reyes'), hasLength(1));
    });

    test('long histories are trimmed to 14 days for the insight', () async {
      final old = [
        for (var i = 20; i < 30; i++)
          _entry(DateTime.now().subtract(Duration(days: i))).toJson(),
      ];
      final c = await _container(
        prefs: {'checkins_maya-reyes': jsonEncode(old)},
      );
      final history = await c.read(snapshotProvider.future);
      expect(history.checkIns, hasLength(14));
      expect(
        c.read(checkInHistoryProvider).requireValue.length,
        greaterThan(14),
      );
      final insight = await c.read(insightProvider.future);
      expect(insight.summary, isNotEmpty);
    });
  });

  group('profile files and the picker', () {
    tearDown(() => FilePickerPlatform.instance = FilePickerPlatform.instance);

    test(
      'reads the text of the chosen file and passes the dialog title',
      () async {
        final fake = _FakePicker(
          _FakeFile(Uint8List.fromList(utf8.encode(_mayaJson))),
        );
        FilePickerPlatform.instance = fake;
        final text = await pickProfileJsonText('Pick one');
        expect(text, _mayaJson);
        expect(fake.title, 'Pick one');
        expect(parseProfileFile(text!).displayName, 'Maya Reyes');
      },
    );

    test('cancelling returns nothing', () async {
      FilePickerPlatform.instance = _FakePicker(null);
      expect(await pickProfileJsonText('Pick one'), isNull);
    });

    test('bad text is reported with the translatable marker', () {
      expect(
        () => parseProfileFile('oops'),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            notJsonMessage,
          ),
        ),
      );
    });

    test('bundled profiles load', () async {
      for (final p in bundledProfiles) {
        expect((await loadBundledProfile(p.id)).id, p.id);
      }
    });
  });

  group('small pieces', () {
    test('every status has a colour and a label in every language', () {
      for (final s in Status.values) {
        expect(AppColors.forStatus(s), isA<Color>());
      }
      for (final locale in AppLocalizations.supportedLocales) {
        final l = lookupAppLocalizations(locale);
        for (final s in Status.values) {
          expect(s.label(l), isNotEmpty);
        }
        for (final a in AiSource.values) {
          expect(a.label(l), isNotEmpty);
          expect(a.description(l), isNotEmpty);
          expect(a.sourceLine(l), isNotEmpty);
        }
        for (final h in NasaHazard.values) {
          expect(h.label(l), isNotEmpty);
        }
        for (final k in NasaRisk.values) {
          expect(k.label(l), isNotEmpty);
        }
        for (final m in MoraleLevel.values) {
          expect(m.label(l), isNotEmpty);
        }
      }
    });

    test('morale levels', () {
      expect(moraleLevel(80), MoraleLevel.high);
      expect(moraleLevel(60), MoraleLevel.steady);
      expect(moraleLevel(40), MoraleLevel.strained);
      expect(moraleLevel(10), MoraleLevel.low);
      expect(sampleCrewMorale.level, MoraleLevel.steady);
    });

    test('layout breakpoints', () {
      expect(LayoutMode.forWidth(390), LayoutMode.phone);
      expect(LayoutMode.forWidth(599.9), LayoutMode.phone);
      expect(LayoutMode.forWidth(600), LayoutMode.tablet);
      expect(LayoutMode.forWidth(1000), LayoutMode.tablet);
      expect(LayoutMode.forWidth(1000.1), LayoutMode.console);
      expect(LayoutMode.phone.isPhone, isTrue);
    });

    test('the sample source says it is sample data', () {
      expect(MockHealthDataSource().isSample, isTrue);
    });

    test(
      'rule-based service reports its source and covers rarer wording',
      () async {
        const service = RuleBasedInsightService();
        expect(service.source, AiSource.ruleBased);

        // Reaction time slow for 7+ days with sleep on baseline: mismatch from reaction.
        final slowReaction = InsightContext(
          profile: f.profile(),
          assessment: f.run(r: [f.reaction(daysAgo: 8, ms: 300)]),
          metrics: f.metrics(),
          checkIns: f.checkIns(),
          missionDay: 100,
          l10n: lookupAppLocalizations(const Locale('en')),
        );
        expect(slowReaction.assessment.mismatch, isTrue);
        final a = await service.generate(slowReaction);
        expect(a.summary, contains('body data'));

        // Rising lapses alone flag Focus without any day count.
        final lapses = InsightContext(
          profile: f.profile(),
          assessment: f.run(r: [f.reaction(daysAgo: 1, lapses: 4)]),
          metrics: f.metrics(),
          checkIns: f.checkIns(),
          missionDay: 100,
          l10n: lookupAppLocalizations(const Locale('en')),
        );
        final b = await service.generate(lapses);
        expect(b.explanation, contains('Lapses'));
      },
    );

    test('settings read a stored mission start', () {
      final s = AppSettings.fromJson({
        'missionStart': '2026-01-05T00:00:00.000',
      });
      expect(s.missionStart, DateTime(2026, 1, 5));
      expect(s.aiSource, AiSource.ruleBased);
    });
  });
}
