import 'package:flutter_test/flutter_test.dart';
import 'package:psychonaut_application/models/health_models.dart';
import 'package:psychonaut_application/services/history.dart';

CheckIn entry(DateTime d, {double mood = 7}) => CheckIn(
  date: d,
  mood: mood,
  stress: 4,
  workload: 5,
  engagement: 7,
  focus: 7,
  connection: 7,
);

void main() {
  final now = DateTime(2026, 3, 10, 21);

  group('streak counts entries, never scores', () {
    test('consecutive days ending today', () {
      final mine = [
        entry(DateTime(2026, 3, 10), mood: 1),
        entry(DateTime(2026, 3, 9), mood: 10),
        entry(DateTime(2026, 3, 8), mood: 3),
      ];
      expect(entryStreak(mine, now), 3);
    });

    test('still alive if today is not logged yet', () {
      final mine = [entry(DateTime(2026, 3, 9)), entry(DateTime(2026, 3, 8))];
      expect(entryStreak(mine, now), 2);
    });

    test('a missed day resets it', () {
      final mine = [entry(DateTime(2026, 3, 10)), entry(DateTime(2026, 3, 8))];
      expect(entryStreak(mine, now), 1);
      expect(entryStreak([entry(DateTime(2026, 3, 7))], now), 0);
      expect(entryStreak(const [], now), 0);
    });

    test('same scores in any order give the same streak', () {
      final good = [
        for (var i = 0; i < 4; i++) entry(DateTime(2026, 3, 10 - i), mood: 10),
      ];
      final bad = [
        for (var i = 0; i < 4; i++) entry(DateTime(2026, 3, 10 - i), mood: 1),
      ];
      expect(entryStreak(good, now), entryStreak(bad, now));
    });
  });

  test('a user entry replaces the seed entry for the same day', () {
    final seed = [
      entry(DateTime(2026, 3, 9), mood: 7),
      entry(DateTime(2026, 3, 10), mood: 7),
    ];
    final merged = mergeCheckIns(seed, [
      entry(DateTime(2026, 3, 10, 18), mood: 4),
    ]);
    expect(merged, hasLength(2));
    expect(merged.last.mood, 4);
  });

  test('upsert keeps one entry per day', () {
    final one = upsertCheckIn([], entry(DateTime(2026, 3, 10), mood: 5));
    final two = upsertCheckIn(one, entry(DateTime(2026, 3, 10, 20), mood: 8));
    expect(two, hasLength(1));
    expect(two.single.mood, 8);
    expect(loggedToday(two, now), isTrue);
  });

  test('mission day counts from day 1', () {
    expect(missionDayFor(DateTime(2026, 3, 10), now), 1);
    expect(missionDayFor(DateTime(2026, 3, 1), now), 10);
  });

  group('reaction prompt', () {
    ReactionResult at(DateTime d) => ReactionResult(
      date: d,
      meanMs: 250,
      lapses: 1,
      falseStarts: 0,
      trials: 50,
    );

    test('due every 4 days, or 3 for people who need more reminders', () {
      final tests = [at(DateTime(2026, 3, 6))];
      expect(reactionTestDue(tests, now, 4), isTrue);
      expect(reactionTestDue([at(DateTime(2026, 3, 7))], now, 4), isFalse);
      expect(reactionTestDue([at(DateTime(2026, 3, 7))], now, 3), isTrue);
      expect(reactionTestDue(const [], now, 4), isTrue);
    });
  });

  group('PvtRecorder', () {
    test('mean, lapses over 500 ms and false starts', () {
      final r = PvtRecorder()
        ..recordReaction(240)
        ..recordReaction(260)
        ..recordReaction(500)
        ..recordReaction(620)
        ..recordFalseStart()
        ..recordFalseStart();
      expect(r.trials, 4);
      expect(r.meanMs, closeTo(405, 1e-9));
      expect(r.lapses, 1);
      expect(r.falseStarts, 2);
      final result = r.toResult(now);
      expect(result.lapses, 1);
      expect(result.trials, 4);
    });

    test('empty test has zero mean', () {
      expect(PvtRecorder().meanMs, 0);
    });
  });
}
