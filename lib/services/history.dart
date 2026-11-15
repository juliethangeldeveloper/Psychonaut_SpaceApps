import '../models/health_models.dart';
import 'risk_constants.dart';

/// Seed history plus what the user logged. A user entry replaces a seed entry for the same day.
List<CheckIn> mergeCheckIns(List<CheckIn> seed, List<CheckIn> mine) {
  final byDay = {for (final c in seed) dateOnly(c.date): c};
  for (final c in mine) {
    byDay[dateOnly(c.date)] = c;
  }
  return byDay.values.toList()..sort((a, b) => a.date.compareTo(b.date));
}

/// Adds or replaces the entry for the same day.
List<CheckIn> upsertCheckIn(List<CheckIn> items, CheckIn entry) {
  final day = dateOnly(entry.date);
  return [...items.where((c) => dateOnly(c.date) != day), entry]
    ..sort((a, b) => a.date.compareTo(b.date));
}

/// Days in a row, ending today or yesterday, on which the user made an entry.
/// Counts entries only. It never looks at the scores.
int entryStreak(List<CheckIn> mine, DateTime now) {
  final days = {for (final c in mine) dateOnly(c.date)};
  var cursor = dateOnly(now);
  if (!days.contains(cursor)) cursor = shiftDays(cursor, -1);
  var streak = 0;
  while (days.contains(cursor)) {
    streak++;
    cursor = shiftDays(cursor, -1);
  }
  return streak;
}

bool loggedToday(List<CheckIn> mine, DateTime now) =>
    mine.any((c) => dateOnly(c.date) == dateOnly(now));

int missionDayFor(DateTime start, DateTime now) => daysBetween(start, now) + 1;

/// Default demo mission day when the user has not set one.
const defaultMissionDay = 112;

bool reactionTestDue(
  List<ReactionResult> tests,
  DateTime now,
  int intervalDays,
) {
  if (tests.isEmpty) return true;
  final last = tests
      .map((t) => dateOnly(t.date))
      .reduce((a, b) => a.isAfter(b) ? a : b);
  return daysBetween(last, now) >= intervalDays;
}

/// Mean, lapses and false starts for a finished test.
class PvtRecorder {
  final List<double> _reactions = [];
  int falseStarts = 0;

  void recordReaction(double ms) => _reactions.add(ms);

  void recordFalseStart() => falseStarts++;

  int get trials => _reactions.length;

  int get lapses => _reactions.where((ms) => ms > RiskConstants.lapseMs).length;

  double get meanMs => _reactions.isEmpty
      ? 0
      : _reactions.reduce((a, b) => a + b) / _reactions.length;

  ReactionResult toResult(DateTime when) => ReactionResult(
    date: when,
    meanMs: meanMs,
    lapses: lapses,
    falseStarts: falseStarts,
    trials: trials,
  );
}
