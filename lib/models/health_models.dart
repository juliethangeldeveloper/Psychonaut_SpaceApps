enum Indicator {
  mood(higherIsBetter: true),
  stress(higherIsBetter: false),
  sleep(higherIsBetter: true),
  focus(higherIsBetter: true),
  motivation(higherIsBetter: true),
  connection(higherIsBetter: true),
  workload(higherIsBetter: false),
  reaction(higherIsBetter: false);

  const Indicator({required this.higherIsBetter});

  final bool higherIsBetter;

  /// The six indicators shown as tiles on Home.
  static const tiles = [mood, stress, sleep, focus, motivation, connection];
}

/// One day of passive body data from a wearable or the mock source.
class DayMetrics {
  const DayMetrics({
    required this.date,
    required this.sleepHours,
    required this.hrv,
    required this.restingHeartRate,
    required this.activityMinutes,
  });

  final DateTime date;
  final double sleepHours;
  final double hrv;
  final double restingHeartRate;
  final double activityMinutes;
}

/// One self-report. Scores are 1 to 10; engagement feeds the Motivation indicator.
class CheckIn {
  const CheckIn({
    required this.date,
    required this.mood,
    required this.stress,
    required this.workload,
    required this.engagement,
    required this.focus,
    required this.connection,
    this.lifeEvent = false,
    this.note,
  });

  final DateTime date;
  final double mood;
  final double stress;
  final double workload;
  final double engagement;
  final double focus;
  final double connection;

  /// "Something happened at home". The note stays on the device and is never sent anywhere.
  final bool lifeEvent;
  final String? note;

  factory CheckIn.fromJson(Map<String, dynamic> json) => CheckIn(
    date: DateTime.parse(json['date'] as String),
    mood: (json['mood'] as num).toDouble(),
    stress: (json['stress'] as num).toDouble(),
    workload: (json['workload'] as num).toDouble(),
    engagement: (json['engagement'] as num).toDouble(),
    focus: (json['focus'] as num).toDouble(),
    connection: (json['connection'] as num).toDouble(),
    lifeEvent: json['lifeEvent'] as bool? ?? false,
    note: json['note'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'date': dateOnly(date).toIso8601String(),
    'mood': mood,
    'stress': stress,
    'workload': workload,
    'engagement': engagement,
    'focus': focus,
    'connection': connection,
    'lifeEvent': lifeEvent,
    'note': ?note,
  };
}

/// Result of one 3-minute psychomotor vigilance test.
class ReactionResult {
  const ReactionResult({
    required this.date,
    required this.meanMs,
    required this.lapses,
    required this.falseStarts,
    required this.trials,
  });

  final DateTime date;
  final double meanMs;
  final int lapses;
  final int falseStarts;
  final int trials;

  factory ReactionResult.fromJson(Map<String, dynamic> json) => ReactionResult(
    date: DateTime.parse(json['date'] as String),
    meanMs: (json['meanMs'] as num).toDouble(),
    lapses: (json['lapses'] as num).toInt(),
    falseStarts: (json['falseStarts'] as num).toInt(),
    trials: (json['trials'] as num).toInt(),
  );

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'meanMs': meanMs,
    'lapses': lapses,
    'falseStarts': falseStarts,
    'trials': trials,
  };
}

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Calendar-day arithmetic that ignores daylight saving shifts.
DateTime shiftDays(DateTime d, int days) =>
    DateTime(d.year, d.month, d.day + days);

/// Whole calendar days from [from] to [to].
int daysBetween(DateTime from, DateTime to) => DateTime.utc(
  to.year,
  to.month,
  to.day,
).difference(DateTime.utc(from.year, from.month, from.day)).inDays;
