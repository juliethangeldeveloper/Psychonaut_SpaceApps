import 'dart:math' as math;

import '../models/health_models.dart';
import '../models/personality_profile.dart';
import '../models/risk_assessment.dart';
import '../models/status.dart';
import 'risk_constants.dart';

typedef BaselineStats = ({double mean, double sd});

/// Plain Dart risk rules. Compares each person with their own baseline.
class RiskEngine {
  const RiskEngine();

  /// Design assumption: whether the profile makes [indicator] flag one day sooner.
  static bool flagsSooner(
    Indicator indicator,
    PersonalityProfile profile, {
    bool lifeEventActive = false,
  }) {
    const high = RiskConstants.traitHigh;
    const low = RiskConstants.traitLow;
    final f = profile.facets;
    return switch (indicator) {
      Indicator.motivation =>
        profile.boredomProneness >= high ||
            (f != null && f.excitementSeeking >= high),
      Indicator.connection =>
        profile.bigFive.extraversion >= high ||
            (f != null && f.gregariousness >= high),
      Indicator.stress =>
        profile.bigFive.emotionalStability <= low ||
            (f != null && f.vulnerability >= high),
      Indicator.mood => lifeEventActive,
      _ => false,
    };
  }

  /// Design assumption: low conscientiousness or self-discipline means more reminders.
  static bool needsMoreReminders(PersonalityProfile profile) {
    final f = profile.facets;
    return profile.bigFive.conscientiousness <= RiskConstants.traitLow ||
        (f != null && f.selfDiscipline <= RiskConstants.traitLow);
  }

  static int reactionPromptDays(PersonalityProfile profile) =>
      needsMoreReminders(profile)
      ? RiskConstants.reactionPromptDaysLowDiscipline
      : RiskConstants.reactionPromptDays;

  static int checkInNudgeHour(PersonalityProfile profile) =>
      needsMoreReminders(profile)
      ? RiskConstants.checkInNudgeHourLowDiscipline
      : RiskConstants.checkInNudgeHour;

  static double driftSdFor(int missionDay) =>
      missionDay > RiskConstants.lateMissionAfterDay
      ? RiskConstants.lateMissionDriftSd
      : RiskConstants.driftSd;

  /// Mean and SD over the first 30 days, or the profile baseline until 30 days exist.
  static BaselineStats baselineStats(
    List<double> history,
    double profileMean,
    double defaultSd,
  ) {
    if (history.length < RiskConstants.baselineDays) {
      return (mean: profileMean, sd: defaultSd);
    }
    final first = history.sublist(0, RiskConstants.baselineDays);
    final mean = first.reduce((a, b) => a + b) / first.length;
    final variance =
        first.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b) /
        first.length;
    // Floor stops a very steady first month from making every wobble look huge.
    return (mean: mean, sd: math.max(math.sqrt(variance), defaultSd * 0.5));
  }

  /// Status from SD rules alone. [zs] are unfavourable SD per day, oldest first.
  static Status statusFromZ(
    List<double> zs, {
    required double driftSd,
    bool sooner = false,
  }) {
    final cut = sooner ? RiskConstants.soonerDaysReduction : 0;
    final run1 = trailingRun(zs, (z) => z > driftSd);
    final run2 = trailingRun(zs, (z) => z > RiskConstants.offCourseSd);
    if (run2 >= RiskConstants.offCourseDaysAtOffCourseSd - cut ||
        run1 >= RiskConstants.offCourseDaysAtDriftSd - cut) {
      return Status.offCourse;
    }
    if (run1 >= RiskConstants.driftDays - cut) return Status.drifting;
    return Status.onCourse;
  }

  /// Fixed sleep rules, independent of the personal baseline.
  static Status sleepRuleStatus(List<double> hours) {
    final under5 = trailingRun(hours, (h) => h < RiskConstants.sleepAlertHours);
    if (under5 >= RiskConstants.sleepAlertNights) return Status.alert;
    final under6 = trailingRun(
      hours,
      (h) => h < RiskConstants.sleepOffCourseHours,
    );
    if (under6 >= RiskConstants.sleepOffCourseNights) return Status.offCourse;
    return Status.onCourse;
  }

  static int trailingRun(List<double> values, bool Function(double) test) {
    var n = 0;
    for (final v in values.reversed) {
      if (!test(v)) break;
      n++;
    }
    return n;
  }

  /// Colour for one night's bar on the sleep chart. A single night, so no day-count rules.
  static Status sleepNightStatus(double hours, double baseline, double sd) {
    if (hours < RiskConstants.sleepAlertHours) return Status.alert;
    final z = (baseline - hours) / sd;
    if (hours < RiskConstants.sleepOffCourseHours ||
        z > RiskConstants.offCourseSd) {
      return Status.offCourse;
    }
    if (z > RiskConstants.driftSd) return Status.drifting;
    return Status.onCourse;
  }

  RiskAssessment assess({
    required PersonalityProfile profile,
    required List<DayMetrics> metrics,
    required List<CheckIn> checkIns,
    List<ReactionResult> reactions = const [],
    required int missionDay,
    DateTime? today,
  }) {
    final days = [...metrics]..sort((a, b) => a.date.compareTo(b.date));
    final entries = [...checkIns]..sort((a, b) => a.date.compareTo(b.date));
    final tests = [...reactions]..sort((a, b) => a.date.compareTo(b.date));
    final ref = dateOnly(today ?? DateTime.now());
    final b = profile.baseline;
    final driftSd = driftSdFor(missionDay);

    final lifeEventActive = entries.any((e) {
      final age = daysBetween(e.date, ref);
      return e.lifeEvent && age >= 0 && age < RiskConstants.lifeEventWatchDays;
    });

    final sleepSeries = days.map((d) => d.sleepHours).toList();
    final reactionSeries = _forwardFill(days, tests);

    IndicatorReading read(
      Indicator indicator,
      List<double> series,
      double profileMean,
    ) {
      final sooner = flagsSooner(
        indicator,
        profile,
        lifeEventActive: lifeEventActive,
      );
      return _reading(
        indicator,
        series,
        baselineStats(
          series,
          profileMean,
          RiskConstants.defaultSd[_sdKey(indicator)]!,
        ),
        driftSd: driftSd,
        sooner: sooner,
      );
    }

    var sleep = read(Indicator.sleep, sleepSeries, b.sleepHours);
    sleep = _withStatus(
      sleep,
      Status.worst([sleep.status, sleepRuleStatus(sleepSeries)]),
    );

    final baseLapses = _baselineLapses(tests);
    final lapsesRising =
        tests.isNotEmpty &&
        tests.last.lapses >= baseLapses + RiskConstants.lapseRiseMargin;
    var focus = read(
      Indicator.focus,
      entries.map((e) => e.focus).toList(),
      b.focus,
    );
    if (lapsesRising) {
      focus = _withStatus(focus, Status.worst([focus.status, Status.drifting]));
    }

    final mood = read(
      Indicator.mood,
      entries.map((e) => e.mood).toList(),
      b.mood,
    );
    final reaction = read(Indicator.reaction, reactionSeries, b.reactionMs);

    final readings = <Indicator, IndicatorReading>{
      Indicator.mood: mood,
      Indicator.stress: read(
        Indicator.stress,
        entries.map((e) => e.stress).toList(),
        b.stress,
      ),
      Indicator.sleep: sleep,
      Indicator.focus: focus,
      Indicator.motivation: read(
        Indicator.motivation,
        entries.map((e) => e.engagement).toList(),
        b.engagement,
      ),
      Indicator.connection: read(
        Indicator.connection,
        entries.map((e) => e.connection).toList(),
        b.connection,
      ),
      Indicator.workload: read(
        Indicator.workload,
        entries.map((e) => e.workload).toList(),
        b.workload,
      ),
      Indicator.reaction: reaction,
    };

    final severities = readings.values.map(_severity).toList();
    final mean = severities.reduce((a, c) => a + c) / severities.length;
    final peak = severities.reduce(math.max);
    final degrees =
        RiskConstants.degreesMax *
        (RiskConstants.degreesMeanWeight * mean +
            RiskConstants.degreesPeakWeight * peak);

    final offCount = readings.values
        .where((r) => r.status.index >= Status.offCourse.index)
        .length;
    final overall =
        sleep.status == Status.alert ||
            offCount >= RiskConstants.alertOffCourseCount
        ? Status.alert
        : Status.worst(readings.values.map((r) => r.status));

    final sleepBelow = trailingRun(sleepSeries, (h) => h < sleep.baseline);
    final reactionOff = trailingRun(
      reactionSeries,
      (ms) =>
          (ms - reaction.baseline) / reaction.sd >
          RiskConstants.mismatchReactionSd,
    );
    final latestMood = entries.isEmpty ? null : entries.last.mood;
    final mismatch =
        latestMood != null &&
        latestMood >= mood.baseline &&
        (sleepBelow >= RiskConstants.mismatchDays ||
            reactionOff >= RiskConstants.mismatchDays);

    return RiskAssessment(
      readings: readings,
      degreesOffCourse: degrees,
      overall: overall,
      mismatch: mismatch,
      sleepDaysBelowBaseline: sleepBelow,
      reactionDaysOffBaseline: reactionOff,
      nightsUnder6: trailingRun(
        sleepSeries,
        (h) => h <= RiskConstants.shortSleepHours,
      ),
      nightsUnder5: trailingRun(
        sleepSeries,
        (h) => h < RiskConstants.sleepAlertHours,
      ),
      lapsesRising: lapsesRising,
      latestReaction: tests.isEmpty ? null : tests.last,
      lifeEventActive: lifeEventActive,
      latestMood: latestMood,
      missionDay: missionDay,
    );
  }

  static String _sdKey(Indicator i) => switch (i) {
    Indicator.motivation => 'engagement',
    _ => i.name,
  };

  double _severity(IndicatorReading r) {
    if (!r.hasData) return 0;
    final fromZ = (r.z / RiskConstants.degreesFullSd).clamp(0.0, 1.0);
    final floor = switch (r.status) {
      Status.onCourse => 0.0,
      Status.drifting => RiskConstants.statusSeverityFloor['drifting']!,
      Status.offCourse => RiskConstants.statusSeverityFloor['offCourse']!,
      Status.alert => RiskConstants.statusSeverityFloor['alert']!,
    };
    return math.max(fromZ, floor);
  }

  /// One value per metrics day: the latest reaction test on or before that day.
  List<double> _forwardFill(List<DayMetrics> days, List<ReactionResult> tests) {
    if (days.isEmpty) return tests.map((t) => t.meanMs).toList();
    final out = <double>[];
    for (final d in days) {
      ReactionResult? latest;
      for (final t in tests) {
        if (!dateOnly(t.date).isAfter(dateOnly(d.date))) latest = t;
      }
      if (latest != null) out.add(latest.meanMs);
    }
    return out;
  }

  double _baselineLapses(List<ReactionResult> tests) {
    if (tests.length < 2) return RiskConstants.defaultBaselineLapses;
    final start = dateOnly(tests.first.date);
    final span = daysBetween(start, tests.last.date);
    if (span < RiskConstants.baselineDays) {
      return RiskConstants.defaultBaselineLapses;
    }
    final first = tests
        .where((t) => daysBetween(start, t.date) < RiskConstants.baselineDays)
        .toList();
    return first.map((t) => t.lapses).reduce((a, b) => a + b) / first.length;
  }

  IndicatorReading _withStatus(IndicatorReading r, Status status) =>
      IndicatorReading(
        indicator: r.indicator,
        hasData: r.hasData,
        status: status,
        baseline: r.baseline,
        sd: r.sd,
        current: r.current,
        z: r.z,
        daysBeyondDrift: r.daysBeyondDrift,
        trend: r.trend,
        series: r.series,
        flaggedSooner: r.flaggedSooner,
      );

  IndicatorReading _reading(
    Indicator indicator,
    List<double> series,
    BaselineStats stats, {
    required double driftSd,
    required bool sooner,
  }) {
    if (series.isEmpty) {
      return IndicatorReading(
        indicator: indicator,
        hasData: false,
        status: Status.onCourse,
        baseline: stats.mean,
        sd: stats.sd,
        current: stats.mean,
        z: 0,
        daysBeyondDrift: 0,
        trend: TrendDirection.steady,
        series: const [],
        flaggedSooner: sooner,
      );
    }

    double unfavourableZ(double v) => indicator.higherIsBetter
        ? (stats.mean - v) / stats.sd
        : (v - stats.mean) / stats.sd;

    final zs = series.map(unfavourableZ).toList();
    final recent = series.length <= 3
        ? series
        : series.sublist(series.length - 3);
    final current = recent.reduce((a, b) => a + b) / recent.length;
    final shown = series.length <= 14
        ? series
        : series.sublist(series.length - 14);

    return IndicatorReading(
      indicator: indicator,
      hasData: true,
      status: statusFromZ(zs, driftSd: driftSd, sooner: sooner),
      baseline: stats.mean,
      sd: stats.sd,
      current: current,
      z: unfavourableZ(current),
      daysBeyondDrift: trailingRun(zs, (z) => z > driftSd),
      trend: _trend(zs),
      series: shown,
      flaggedSooner: sooner,
    );
  }

  /// Last 3 days against the 4 days before, in SD.
  TrendDirection _trend(List<double> zs) {
    if (zs.length < 4) return TrendDirection.steady;
    final recent = zs.sublist(zs.length - 3);
    final earlier = zs.sublist(math.max(0, zs.length - 7), zs.length - 3);
    double mean(List<double> v) => v.reduce((a, c) => a + c) / v.length;
    final change = mean(recent) - mean(earlier);
    if (change < -0.3) return TrendDirection.improving;
    if (change > 0.3) return TrendDirection.slipping;
    return TrendDirection.steady;
  }
}
