import '../../l10n/l10n.dart';

/// Group-level numbers only. There are no per-person values anywhere in this app.
class CrewMorale {
  const CrewMorale({
    required this.score,
    required this.contributed,
    required this.crewSize,
  });

  /// 0 to 100, the crew average.
  final double score;

  /// How many crew members checked in today, as a count with no names.
  final int contributed;
  final int crewSize;

  MoraleLevel get level => moraleLevel(score);
}

enum MoraleLevel { high, steady, strained, low }

extension MoraleText on MoraleLevel {
  String label(AppLocalizations l) => switch (this) {
    MoraleLevel.high => l.moraleHigh,
    MoraleLevel.steady => l.moraleSteady,
    MoraleLevel.strained => l.moraleStrained,
    MoraleLevel.low => l.moraleLow,
  };
}

MoraleLevel moraleLevel(double score) {
  if (score >= 75) return MoraleLevel.high;
  if (score >= 55) return MoraleLevel.steady;
  if (score >= 35) return MoraleLevel.strained;
  return MoraleLevel.low;
}

class WeeklyGoal {
  const WeeklyGoal({
    required this.segments,
    required this.done,
    required this.participants,
  });

  /// Number of progress segments.
  final int segments;
  final int done;

  /// Crew members who have joined, not counting you.
  final int participants;
}

/// Sample crew data, shown with a "Sample data" chip. A real build would read
/// anonymous group averages from the vehicle network.
const sampleCrewMorale = CrewMorale(score: 68, contributed: 5, crewSize: 6);

const sampleWeeklyGoal = WeeklyGoal(segments: 6, done: 4, participants: 4);
