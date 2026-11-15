import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:ui' show Locale, PlatformDispatcher;

import '../data/health_data_source.dart';
import '../data/local_store.dart';
import '../data/mock_health_data_source.dart';
import '../data/profile_repository.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/health_models.dart';
import '../models/insight.dart';
import '../models/personality_profile.dart';
import '../models/risk_assessment.dart';
import '../services/history.dart';
import '../services/insight_coordinator.dart';
import '../services/insight_service.dart';
import '../services/llm_insight_service.dart';
import '../services/risk_engine.dart';
import '../services/rule_based_insight_service.dart';

/// Overridden in main() with the real instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override sharedPreferencesProvider'),
);

final localStoreProvider = Provider<LocalStore>(
  (ref) => LocalStore(ref.watch(sharedPreferencesProvider)),
);

/// Injectable so tests can pin the date.
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// Injectable so tests can drive reaction timing with fake time.
final stopwatchProvider = Provider<Stopwatch Function()>(
  (ref) => Stopwatch.new,
);

/// The loaded profile. Null means onboarding has not been completed.
class ProfileNotifier extends Notifier<PersonalityProfile?> {
  @override
  PersonalityProfile? build() => ref.read(localStoreProvider).loadProfile();

  Future<void> set(PersonalityProfile profile) async {
    state = profile;
    await ref.read(localStoreProvider).saveProfile(profile);
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, PersonalityProfile?>(
  ProfileNotifier.new,
);

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.read(localStoreProvider).loadSettings();

  Future<void> setAiSource(AiSource source) =>
      _save(state.copyWith(aiSource: source));

  Future<void> setMissionDay(int day) {
    final today = dateOnly(ref.read(clockProvider)());
    return _save(state.copyWith(missionStart: shiftDays(today, -(day - 1))));
  }

  Future<void> setLanguage(String? code) => _save(
    code == null
        ? state.copyWith(followDeviceLanguage: true)
        : state.copyWith(languageCode: code),
  );

  Future<void> _save(AppSettings next) async {
    state = next;
    await ref.read(localStoreProvider).saveSettings(next);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

/// Device language, injectable so tests can pin it.
final deviceLocaleProvider = Provider<Locale>(
  (ref) => PlatformDispatcher.instance.locale,
);

final localeProvider = Provider<Locale>(
  (ref) => resolveAppLocale(
    ref.watch(settingsProvider.select((s) => s.languageCode)),
    ref.watch(deviceLocaleProvider),
  ),
);

/// Strings for code that has no BuildContext, such as insight services.
final l10nProvider = Provider<AppLocalizations>(
  (ref) => lookupAppLocalizations(ref.watch(localeProvider)),
);

final missionDayProvider = Provider<int>((ref) {
  final now = ref.watch(clockProvider)();
  final start = ref.watch(settingsProvider).missionStart;
  final day = start == null ? defaultMissionDay : missionDayFor(start, now);
  return day < 1 ? 1 : day;
});

/// Injectable so tests can skip the native file picker.
final profileFilePickerProvider = Provider<Future<String?> Function(String)>(
  (ref) => pickProfileJsonText,
);

final healthDataSourceProvider = Provider<HealthDataSource>(
  (ref) => MockHealthDataSource(clock: ref.watch(clockProvider)),
);

final snapshotProvider = FutureProvider<HealthSnapshot>((ref) async {
  final profile = ref.watch(profileProvider);
  if (profile == null) throw StateError('No profile loaded');
  return ref.watch(healthDataSourceProvider).fetch(profile);
});

/// Entries the user logged, per profile.
class CheckInsNotifier extends Notifier<List<CheckIn>> {
  @override
  List<CheckIn> build() {
    final profile = ref.watch(profileProvider);
    if (profile == null) return [];
    return ref.read(localStoreProvider).loadCheckIns(profile.id);
  }

  Future<void> log(CheckIn entry) async {
    final profile = ref.read(profileProvider);
    state = upsertCheckIn(state, entry);
    if (profile != null) {
      await ref.read(localStoreProvider).saveCheckIns(profile.id, state);
    }
  }
}

final checkInsProvider = NotifierProvider<CheckInsNotifier, List<CheckIn>>(
  CheckInsNotifier.new,
);

class ReactionsNotifier extends Notifier<List<ReactionResult>> {
  @override
  List<ReactionResult> build() {
    final profile = ref.watch(profileProvider);
    if (profile == null) return [];
    return ref.read(localStoreProvider).loadReactions(profile.id);
  }

  Future<void> add(ReactionResult result) async {
    final profile = ref.read(profileProvider);
    state = [...state, result];
    if (profile != null) {
      await ref.read(localStoreProvider).saveReactions(profile.id, state);
    }
  }
}

final reactionsProvider =
    NotifierProvider<ReactionsNotifier, List<ReactionResult>>(
      ReactionsNotifier.new,
    );

final checkInHistoryProvider = Provider<AsyncValue<List<CheckIn>>>((ref) {
  final mine = ref.watch(checkInsProvider);
  return ref
      .watch(snapshotProvider)
      .whenData((s) => mergeCheckIns(s.checkIns, mine));
});

final reactionHistoryProvider = Provider<AsyncValue<List<ReactionResult>>>((
  ref,
) {
  final mine = ref.watch(reactionsProvider);
  return ref
      .watch(snapshotProvider)
      .whenData(
        (s) =>
            [...s.reactions, ...mine]..sort((a, b) => a.date.compareTo(b.date)),
      );
});

final assessmentProvider = Provider<AsyncValue<RiskAssessment>>((ref) {
  final profile = ref.watch(profileProvider);
  final snap = ref.watch(snapshotProvider);
  final checkIns = ref.watch(checkInHistoryProvider);
  final reactions = ref.watch(reactionHistoryProvider);
  final day = ref.watch(missionDayProvider);
  final now = ref.watch(clockProvider)();
  if (profile == null) return const AsyncValue.loading();
  if (snap.hasError) return AsyncValue.error(snap.error!, snap.stackTrace!);
  final s = snap.value;
  final c = checkIns.value;
  final r = reactions.value;
  if (s == null || c == null || r == null) return const AsyncValue.loading();
  return AsyncValue.data(
    const RiskEngine().assess(
      profile: profile,
      metrics: s.metrics,
      checkIns: c,
      reactions: r,
      missionDay: day,
      today: now,
    ),
  );
});

/// Indicator picked on Home. Null until the user taps one.
class SelectedIndicatorNotifier extends Notifier<Indicator?> {
  @override
  Indicator? build() => null;

  void select(Indicator? i) => state = i;
}

final selectedIndicatorProvider =
    NotifierProvider<SelectedIndicatorNotifier, Indicator?>(
      SelectedIndicatorNotifier.new,
    );

final crewJoinedProvider = NotifierProvider<CrewJoinedNotifier, bool>(
  CrewJoinedNotifier.new,
);

class CrewJoinedNotifier extends Notifier<bool> {
  @override
  bool build() => ref.read(localStoreProvider).crewJoined;

  Future<void> set(bool joined) async {
    state = joined;
    await ref.read(localStoreProvider).setCrewJoined(joined);
  }
}

/// Cloud model settings from --dart-define. Empty when not provided.
final llmConfigProvider = Provider<LlmConfig>(
  (ref) => LlmConfig.fromEnvironment,
);

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

/// On-board model settings from --dart-define. Empty when not provided.
final onBoardConfigProvider = Provider<LlmConfig>(
  (ref) => LlmConfig.onBoardFromEnvironment,
);

final insightCoordinatorProvider = Provider<InsightCoordinator>((ref) {
  final cloud = ref.watch(llmConfigProvider);
  final onBoard = ref.watch(onBoardConfigProvider);
  // A source that is not configured falls back to rule-based and says so.
  return InsightCoordinator(
    ruleBased: const RuleBasedInsightService(),
    onBoard: onBoard.isConfigured
        ? LlmInsightService(
            onBoard,
            ref.watch(httpClientProvider),
            source: AiSource.onBoard,
          )
        : null,
    cloud: cloud.isConfigured
        ? LlmInsightService(cloud, ref.watch(httpClientProvider))
        : null,
  );
});

/// Today's reading. Recomputes when data, profile or the AI source changes.
final insightProvider = FutureProvider<Insight>((ref) async {
  final profile = ref.watch(profileProvider);
  final source = ref.watch(settingsProvider.select((s) => s.aiSource));
  final day = ref.watch(missionDayProvider);
  final l10n = ref.watch(l10nProvider);
  final snap = await ref.watch(snapshotProvider.future);
  // The snapshot loaded, so the profile and everything derived from it exist.
  final assessment = ref.watch(assessmentProvider).requireValue;
  final checkIns = ref.watch(checkInHistoryProvider).requireValue;
  final recent = checkIns.length <= 14
      ? checkIns
      : checkIns.sublist(checkIns.length - 14);
  return ref
      .watch(insightCoordinatorProvider)
      .resolve(
        InsightContext(
          profile: profile!,
          assessment: assessment,
          metrics: snap.metrics,
          checkIns: recent,
          missionDay: day,
          l10n: l10n,
        ),
        source,
      );
});
