import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../models/health_models.dart';
import '../models/personality_profile.dart';
import 'health_data_source.dart';

class MockHealthDataSource implements HealthDataSource {
  MockHealthDataSource({AssetBundle? bundle, DateTime Function()? clock})
    : _bundle = bundle ?? rootBundle,
      _clock = clock ?? DateTime.now;

  final AssetBundle _bundle;
  final DateTime Function() _clock;

  @override
  bool get isSample => true;

  /// Reads `assets/sample/{profile id}.json`, or builds a steady series from the baseline.
  @override
  Future<HealthSnapshot> fetch(PersonalityProfile profile) async {
    try {
      final raw = await _bundle.loadString('assets/sample/${profile.id}.json');
      return _parse(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return _fromBaseline(profile);
    }
  }

  HealthSnapshot _parse(Map<String, dynamic> json) {
    List<double> series(Map<String, dynamic> m, String key) {
      final list = (m[key] as List).map((e) => (e as num).toDouble()).toList();
      if (list.length != 14) throw FormatException('$key needs 14 values');
      return list;
    }

    List<double?> sparse(String key) {
      final list = (json[key] as List)
          .map((e) => (e as num?)?.toDouble())
          .toList();
      if (list.length != 14) throw FormatException('$key needs 14 values');
      return list;
    }

    final sr = json['selfReport'] as Map<String, dynamic>;
    return _build(
      sleep: series(json, 'sleepHours'),
      hrv: series(json, 'hrv'),
      rhr: series(json, 'restingHeartRate'),
      activity: series(json, 'activityMinutes'),
      reactionMs: sparse('reactionMs'),
      reactionLapses: sparse('reactionLapses'),
      mood: series(sr, 'mood'),
      stress: series(sr, 'stress'),
      workload: series(sr, 'workload'),
      engagement: series(sr, 'engagement'),
      focus: series(sr, 'focus'),
      connection: series(sr, 'connection'),
    );
  }

  HealthSnapshot _fromBaseline(PersonalityProfile profile) {
    final b = profile.baseline;
    List<double> wobble(double base, double amp, {double min = 1}) =>
        List.generate(
          14,
          (i) => math.max(min, base + amp * math.sin(i * 1.7 + base)),
        );
    List<double> whole(double base) => wobble(
      base,
      0.6,
    ).map((v) => v.round().clamp(1, 10).toDouble()).toList();

    return _build(
      sleep: wobble(b.sleepHours, 0.3, min: 0),
      hrv: wobble(b.hrv, 2),
      rhr: wobble(b.restingHeartRate, 1.5),
      activity: wobble(45, 8, min: 0),
      reactionMs: [
        for (var i = 0; i < 14; i++) i % 4 == 1 ? b.reactionMs : null,
      ],
      reactionLapses: [for (var i = 0; i < 14; i++) i % 4 == 1 ? 1.0 : null],
      mood: whole(b.mood),
      stress: whole(b.stress),
      workload: whole(b.workload),
      engagement: whole(b.engagement),
      focus: whole(b.focus),
      connection: whole(b.connection),
    );
  }

  HealthSnapshot _build({
    required List<double> sleep,
    required List<double> hrv,
    required List<double> rhr,
    required List<double> activity,
    required List<double?> reactionMs,
    required List<double?> reactionLapses,
    required List<double> mood,
    required List<double> stress,
    required List<double> workload,
    required List<double> engagement,
    required List<double> focus,
    required List<double> connection,
  }) {
    final today = dateOnly(_clock());
    DateTime day(int i) => shiftDays(today, -(13 - i));
    return HealthSnapshot(
      metrics: [
        for (var i = 0; i < 14; i++)
          DayMetrics(
            date: day(i),
            sleepHours: sleep[i],
            hrv: hrv[i],
            restingHeartRate: rhr[i],
            activityMinutes: activity[i],
          ),
      ],
      reactions: [
        for (var i = 0; i < 14; i++)
          if (reactionMs[i] != null)
            ReactionResult(
              date: day(i),
              meanMs: reactionMs[i]!,
              lapses: (reactionLapses[i] ?? 0).round(),
              falseStarts: 0,
              trials: 55,
            ),
      ],
      checkIns: [
        for (var i = 0; i < 14; i++)
          CheckIn(
            date: day(i),
            mood: mood[i],
            stress: stress[i],
            workload: workload[i],
            engagement: engagement[i],
            focus: focus[i],
            connection: connection[i],
          ),
      ],
    );
  }
}
