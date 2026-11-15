import 'health_models.dart';
import 'mission.dart';
import 'status.dart';

enum TrendDirection { improving, steady, slipping }

class IndicatorReading {
  const IndicatorReading({
    required this.indicator,
    required this.hasData,
    required this.status,
    required this.baseline,
    required this.sd,
    required this.current,
    required this.z,
    required this.daysBeyondDrift,
    required this.trend,
    required this.series,
    required this.flaggedSooner,
  });

  final Indicator indicator;
  final bool hasData;
  final Status status;

  /// Personal mean (profile baseline until 30 days exist).
  final double baseline;
  final double sd;

  /// Mean of the last 3 values.
  final double current;

  /// SD from baseline on the unfavourable side; negative means better than baseline.
  final double z;

  /// Consecutive recent days beyond the drift limit.
  final int daysBeyondDrift;
  final TrendDirection trend;

  /// Last 14 values, oldest first.
  final List<double> series;

  /// A profile trait or life event shortened the day requirement.
  final bool flaggedSooner;

  double get delta => current - baseline;
}

class RiskAssessment {
  const RiskAssessment({
    required this.readings,
    required this.degreesOffCourse,
    required this.overall,
    required this.mismatch,
    required this.sleepDaysBelowBaseline,
    required this.reactionDaysOffBaseline,
    required this.nightsUnder6,
    required this.nightsUnder5,
    required this.lapsesRising,
    required this.latestReaction,
    required this.lifeEventActive,
    required this.latestMood,
    required this.missionDay,
  });

  final Map<Indicator, IndicatorReading> readings;
  final double degreesOffCourse;
  final Status overall;

  /// Self-rated mood at or above baseline while sleep or reaction time has been off baseline for 7+ days.
  final bool mismatch;
  final int sleepDaysBelowBaseline;
  final int reactionDaysOffBaseline;
  final int nightsUnder6;
  final int nightsUnder5;
  final bool lapsesRising;
  final ReactionResult? latestReaction;
  final bool lifeEventActive;
  final double? latestMood;
  final int missionDay;

  MissionPhase get phase => MissionPhase.forDay(missionDay);

  IndicatorReading reading(Indicator i) => readings[i]!;

  int get offCourseCount => readings.values
      .where((r) => r.status.index >= Status.offCourse.index)
      .length;
}
