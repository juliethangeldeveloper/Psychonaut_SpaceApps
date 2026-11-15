import 'package:flutter_test/flutter_test.dart';
import 'package:psychonaut_application/models/health_models.dart';
import 'package:psychonaut_application/models/mission.dart';
import 'package:psychonaut_application/models/personality_profile.dart';
import 'package:psychonaut_application/models/risk_assessment.dart';
import 'package:psychonaut_application/models/status.dart';
import 'package:psychonaut_application/services/risk_constants.dart';
import 'package:psychonaut_application/services/risk_engine.dart';

/// Baseline: sleep 7, mood 7, stress 4, workload 5, engagement 7, focus 7,
/// connection 7, reaction 250 ms. Default SD is 1 for the 1-10 scales and 0.6 h for sleep.
PersonalityProfile profile({
  double boredom = 30,
  double extraversion = 50,
  double stability = 50,
  double conscientiousness = 50,
  Facets? facets,
  double sleepBaseline = 7.0,
}) => PersonalityProfile.fromJson({
  'id': 'test',
  'displayName': 'Test Person',
  'role': 'Tester',
  'source': facets == null ? 'mini-ipip' : 'ipip-neo-120',
  'bigFive': {
    'openness': 50,
    'conscientiousness': conscientiousness,
    'extraversion': extraversion,
    'agreeableness': 50,
    'emotionalStability': stability,
  },
  'facets': ?facets?.toJson(),
  'locusOfControl': 'internal',
  'copingStyle': 'problem_focused',
  'boredomProneness': boredom,
  'baseline': {
    'sleepHours': sleepBaseline,
    'mood': 7,
    'stress': 4,
    'workload': 5,
    'engagement': 7,
    'focus': 7,
    'connection': 7,
    'reactionMs': 250,
    'restingHeartRate': 58,
    'hrv': 60,
  },
  'preferences': {
    'tone': 'direct',
    'preferredActions': ['exercise'],
  },
});

final today = DateTime(2026, 1, 20);
DateTime dayOf(int i, int n) => today.subtract(Duration(days: n - 1 - i));

/// [n] values at [base], with the last values replaced by [tail].
List<double> series(double base, [List<double> tail = const [], int n = 14]) =>
    [
      for (var i = 0; i < n; i++)
        i >= n - tail.length ? tail[i - (n - tail.length)] : base,
    ];

List<double> repeat(double v, int times) => List.filled(times, v);

List<DayMetrics> metrics({List<double>? sleep, int n = 14}) {
  final s = sleep ?? series(7.0, const [], n);
  return [
    for (var i = 0; i < s.length; i++)
      DayMetrics(
        date: dayOf(i, s.length),
        sleepHours: s[i],
        hrv: 60,
        restingHeartRate: 58,
        activityMinutes: 40,
      ),
  ];
}

List<CheckIn> checkIns({
  int n = 14,
  List<double>? mood,
  List<double>? stress,
  List<double>? workload,
  List<double>? engagement,
  List<double>? focus,
  List<double>? connection,
  Set<int> lifeEvents = const {},
}) {
  final m = mood ?? series(7, const [], n);
  return [
    for (var i = 0; i < m.length; i++)
      CheckIn(
        date: dayOf(i, m.length),
        mood: m[i],
        stress: (stress ?? series(4, const [], n))[i],
        workload: (workload ?? series(5, const [], n))[i],
        engagement: (engagement ?? series(7, const [], n))[i],
        focus: (focus ?? series(7, const [], n))[i],
        connection: (connection ?? series(7, const [], n))[i],
        lifeEvent: lifeEvents.contains(i),
      ),
  ];
}

ReactionResult reaction({
  required int daysAgo,
  double ms = 250,
  int lapses = 1,
}) => ReactionResult(
  date: today.subtract(Duration(days: daysAgo)),
  meanMs: ms,
  lapses: lapses,
  falseStarts: 0,
  trials: 50,
);

const engine = RiskEngine();

RiskAssessment run({
  PersonalityProfile? p,
  List<DayMetrics>? m,
  List<CheckIn>? c,
  List<ReactionResult> r = const [],
  int missionDay = 100,
}) => engine.assess(
  profile: p ?? profile(),
  metrics: m ?? metrics(),
  checkIns: c ?? checkIns(),
  reactions: r,
  missionDay: missionDay,
  today: today,
);

void main() {
  group('baseline', () {
    test('uses the profile baseline until 30 days exist', () {
      final a = run(c: checkIns(n: 29, mood: series(5, const [], 29)));
      expect(a.reading(Indicator.mood).baseline, 7);
      expect(a.reading(Indicator.mood).sd, 1.0);
    });

    test('uses the mean and SD of the first 30 days once they exist', () {
      final first = [for (var i = 0; i < 30; i++) i.isEven ? 4.0 : 6.0];
      final mood = [...first, ...repeat(5, 10)];
      final a = run(c: checkIns(n: 40, mood: mood));
      final r = a.reading(Indicator.mood);
      expect(r.baseline, closeTo(5, 1e-9));
      expect(r.sd, closeTo(1, 1e-9));
      expect(r.status, Status.onCourse);
    });
  });

  group('standard deviation rules', () {
    test('within 1 SD is on course', () {
      final a = run(c: checkIns(mood: series(7, repeat(6.1, 14))));
      expect(a.reading(Indicator.mood).status, Status.onCourse);
    });

    test('better than baseline is never flagged', () {
      final a = run(
        c: checkIns(
          mood: series(7, repeat(10, 14)),
          stress: series(4, repeat(1, 14)),
        ),
      );
      expect(a.reading(Indicator.mood).status, Status.onCourse);
      expect(a.reading(Indicator.stress).status, Status.onCourse);
    });

    test('drifting needs 3 consecutive days beyond 1 SD', () {
      Status mood(List<double> tail) =>
          run(c: checkIns(mood: series(7, tail)))
              .reading(Indicator.mood)
              .status;
      expect(mood([5.5, 5.5, 5.5]), Status.drifting);
      expect(mood([5.5, 5.5]), Status.onCourse);
      expect(mood([5.5, 7, 5.5, 5.5]), Status.onCourse);
    });

    test('off course: beyond 2 SD for 3 days', () {
      final a = run(c: checkIns(mood: series(7, [4.5, 4.5, 4.5])));
      expect(a.reading(Indicator.mood).status, Status.offCourse);
      final two = run(c: checkIns(mood: series(7, [4.5, 4.5])));
      expect(two.reading(Indicator.mood).status, Status.onCourse);
    });

    test('off course: beyond 1 SD for 7 days', () {
      Status mood(int days) =>
          run(c: checkIns(mood: series(7, repeat(5.5, days))))
              .reading(Indicator.mood)
              .status;
      expect(mood(7), Status.offCourse);
      expect(mood(6), Status.drifting);
    });

    test('higher-is-worse indicators flag when they rise', () {
      final a = run(
        c: checkIns(
          stress: series(4, repeat(5.5, 3)),
          workload: series(5, repeat(6.5, 3)),
        ),
      );
      expect(a.reading(Indicator.stress).status, Status.drifting);
      expect(a.reading(Indicator.workload).status, Status.drifting);
    });
  });

  group('mission phase', () {
    test('phase boundaries', () {
      expect(MissionPhase.forDay(1), MissionPhase.adjustment);
      expect(MissionPhase.forDay(30), MissionPhase.adjustment);
      expect(MissionPhase.forDay(31), MissionPhase.midMission);
      expect(MissionPhase.forDay(150), MissionPhase.midMission);
      expect(MissionPhase.forDay(151), MissionPhase.lateMission);
    });

    test('after day 150 the drift limit tightens to 0.8 SD', () {
      expect(RiskEngine.driftSdFor(150), 1.0);
      expect(RiskEngine.driftSdFor(151), 0.8);
      final c = checkIns(mood: series(7, repeat(6.1, 3)));
      expect(
        run(c: c, missionDay: 100).reading(Indicator.mood).status,
        Status.onCourse,
      );
      expect(
        run(c: c, missionDay: 151).reading(Indicator.mood).status,
        Status.drifting,
      );
    });
  });

  group('sleep rules', () {
    test('7 to 8 hours is the healthy range and 6 or less is short sleep', () {
      expect(RiskConstants.healthySleepMinHours, 7);
      expect(RiskConstants.healthySleepMaxHours, 8);
      final a = run(m: metrics(sleep: series(7, [6.0, 5.5, 6.0])));
      expect(a.nightsUnder6, 3);
      expect(run(m: metrics(sleep: series(7, [6.0, 6.5]))).nightsUnder6, 0);
    });

    test('under 6 hours for 7 nights is off course', () {
      expect(RiskEngine.sleepRuleStatus(repeat(5.9, 7)), Status.offCourse);
      expect(RiskEngine.sleepRuleStatus(repeat(5.9, 6)), Status.onCourse);
      expect(RiskEngine.sleepRuleStatus(repeat(6.0, 7)), Status.onCourse);
    });

    test(
      'the fixed rule applies even when 6 hours is the personal baseline',
      () {
        final a = run(
          p: profile(sleepBaseline: 5.5),
          m: metrics(sleep: series(5.5)),
        );
        expect(a.reading(Indicator.sleep).status, Status.offCourse);
      },
    );

    test('under 5 hours for 3 nights is alert', () {
      expect(RiskEngine.sleepRuleStatus(repeat(4.9, 3)), Status.alert);
      expect(RiskEngine.sleepRuleStatus(repeat(4.9, 2)), Status.onCourse);
      final a = run(m: metrics(sleep: series(7, repeat(4.5, 3))));
      expect(a.reading(Indicator.sleep).status, Status.alert);
      expect(a.overall, Status.alert);
    });
  });

  group('reaction test', () {
    test('rested response is about 250 ms and a lapse is over 500 ms', () {
      expect(RiskConstants.restedReactionMs, 250);
      expect(RiskConstants.lapseMs, 500);
    });

    test(
      'rising lapses against the default baseline count as drift in Focus',
      () {
        final calm = run(r: [reaction(daysAgo: 1, lapses: 2)]);
        expect(calm.lapsesRising, isFalse);
        expect(calm.reading(Indicator.focus).status, Status.onCourse);

        final rising = run(r: [reaction(daysAgo: 1, lapses: 3)]);
        expect(rising.lapsesRising, isTrue);
        expect(rising.reading(Indicator.focus).status, Status.drifting);
      },
    );

    test(
      'lapses are measured against the personal baseline once 30 days exist',
      () {
        final history = [
          for (var d = 45; d >= 20; d -= 5) reaction(daysAgo: d, lapses: 0),
          reaction(daysAgo: 1, lapses: 2),
        ];
        expect(run(r: history).lapsesRising, isTrue);
      },
    );

    test('slow response times drift the reaction indicator', () {
      final a = run(r: [reaction(daysAgo: 8, ms: 330)]);
      expect(a.reading(Indicator.reaction).status, Status.offCourse);
    });
  });

  group('life event', () {
    test('active for 14 days after it is logged', () {
      expect(run(c: checkIns(lifeEvents: {0})).lifeEventActive, isTrue);
      expect(run(c: checkIns(n: 15, lifeEvents: {0})).lifeEventActive, isFalse);
      expect(run().lifeEventActive, isFalse);
    });

    test('mood is watched more closely while it is active', () {
      final tail = series(7, repeat(5.5, 2));
      final withEvent = run(
        c: checkIns(mood: tail, lifeEvents: {10}),
      );
      final without = run(c: checkIns(mood: tail));
      expect(withEvent.reading(Indicator.mood).status, Status.drifting);
      expect(without.reading(Indicator.mood).status, Status.onCourse);
    });
  });

  group('profile changes behaviour', () {
    test(
      'boredom proneness or excitement seeking flags low engagement sooner',
      () {
        final c = checkIns(engagement: series(7, repeat(5.5, 2)));
        Status s(PersonalityProfile p) =>
            run(p: p, c: c).reading(Indicator.motivation).status;
        expect(s(profile(boredom: 20)), Status.onCourse);
        expect(s(profile(boredom: 80)), Status.drifting);
        expect(
          s(
            profile(
              facets: const Facets(
                excitementSeeking: 85,
                gregariousness: 50,
                vulnerability: 50,
                selfDiscipline: 50,
              ),
            ),
          ),
          Status.drifting,
        );
      },
    );

    test('extraversion or gregariousness flags low connection sooner', () {
      final c = checkIns(connection: series(7, repeat(5.5, 2)));
      Status s(PersonalityProfile p) =>
          run(p: p, c: c).reading(Indicator.connection).status;
      expect(s(profile(extraversion: 20)), Status.onCourse);
      expect(s(profile(extraversion: 85)), Status.drifting);
      expect(
        s(
          profile(
            facets: const Facets(
              excitementSeeking: 50,
              gregariousness: 85,
              vulnerability: 50,
              selfDiscipline: 50,
            ),
          ),
        ),
        Status.drifting,
      );
    });

    test('low emotional stability or high vulnerability flags rising stress sooner', () {
      final c = checkIns(stress: series(4, repeat(5.5, 2)));
      Status s(PersonalityProfile p) =>
          run(p: p, c: c).reading(Indicator.stress).status;
      expect(s(profile(stability: 70)), Status.onCourse);
      expect(s(profile(stability: 20)), Status.drifting);
      expect(
        s(
          profile(
            facets: const Facets(
              excitementSeeking: 50,
              gregariousness: 50,
              vulnerability: 85,
              selfDiscipline: 50,
            ),
          ),
        ),
        Status.drifting,
      );
    });

    test('traits do not change unrelated indicators', () {
      final c = checkIns(focus: series(7, repeat(5.5, 2)));
      expect(
        run(
          p: profile(boredom: 95, extraversion: 95, stability: 5),
          c: c,
        ).reading(Indicator.focus).status,
        Status.onCourse,
      );
    });

    test('low conscientiousness or self-discipline means more reminders', () {
      expect(RiskEngine.needsMoreReminders(profile()), isFalse);
      expect(
        RiskEngine.needsMoreReminders(profile(conscientiousness: 20)),
        isTrue,
      );
      expect(
        RiskEngine.needsMoreReminders(
          profile(
            facets: const Facets(
              excitementSeeking: 50,
              gregariousness: 50,
              vulnerability: 50,
              selfDiscipline: 20,
            ),
          ),
        ),
        isTrue,
      );
      expect(RiskEngine.reactionPromptDays(profile()), 4);
      expect(RiskEngine.reactionPromptDays(profile(conscientiousness: 20)), 3);
      expect(
        RiskEngine.checkInNudgeHour(profile(conscientiousness: 20)),
        lessThan(RiskEngine.checkInNudgeHour(profile())),
      );
    });
  });

  group('overall status and degrees', () {
    test('everything at baseline is on course with zero degrees', () {
      final a = run();
      expect(a.overall, Status.onCourse);
      expect(a.degreesOffCourse, closeTo(0, 1e-9));
      expect(a.mismatch, isFalse);
    });

    test('three indicators off course together is alert', () {
      final bad = repeat(3.0, 3);
      final three = run(
        c: checkIns(
          mood: series(7, bad),
          connection: series(7, bad),
          stress: series(4, repeat(7.0, 3)),
        ),
      );
      expect(three.offCourseCount, 3);
      expect(three.overall, Status.alert);

      final two = run(
        c: checkIns(mood: series(7, bad), connection: series(7, bad)),
      );
      expect(two.offCourseCount, 2);
      expect(two.overall, Status.offCourse);
    });

    test('degrees grow with deviation and with more indicators', () {
      final small = run(c: checkIns(mood: series(7, repeat(5.5, 3))))
          .degreesOffCourse;
      final larger = run(c: checkIns(mood: series(7, repeat(4.0, 3))))
          .degreesOffCourse;
      final more = run(
        c: checkIns(
          mood: series(7, repeat(4.0, 3)),
          stress: series(4, repeat(6.5, 3)),
        ),
      ).degreesOffCourse;
      expect(small, greaterThan(0));
      expect(larger, greaterThan(small));
      expect(more, greaterThan(larger));
    });
  });

  group('mismatch flag', () {
    test('mood at baseline while sleep is below baseline for 7 days', () {
      final a = run(m: metrics(sleep: series(7, repeat(6.8, 7))));
      expect(a.sleepDaysBelowBaseline, 7);
      expect(a.mismatch, isTrue);
    });

    test('mood above baseline also counts', () {
      final a = run(
        m: metrics(sleep: series(7, repeat(6.8, 7))),
        c: checkIns(mood: series(9)),
      );
      expect(a.mismatch, isTrue);
    });

    test('reaction time off baseline for 7 days also raises it', () {
      final a = run(r: [reaction(daysAgo: 8, ms: 300)]);
      expect(a.reactionDaysOffBaseline, 9);
      expect(a.mismatch, isTrue);
    });

    test('six days is not enough', () {
      final a = run(m: metrics(sleep: series(7, repeat(6.8, 6))));
      expect(a.sleepDaysBelowBaseline, 6);
      expect(a.mismatch, isFalse);
    });

    test('a night at baseline breaks the run', () {
      final sleep = series(6.8, const [], 14)..[10] = 7.0;
      final a = run(m: metrics(sleep: sleep));
      expect(a.sleepDaysBelowBaseline, 3);
      expect(a.mismatch, isFalse);
    });

    test('no flag when self-rated mood is already below baseline', () {
      final a = run(
        m: metrics(sleep: series(6.8)),
        c: checkIns(mood: series(7, [6.5])),
      );
      expect(a.mismatch, isFalse);
    });

    test('no flag without a check-in', () {
      expect(
        run(
          m: metrics(sleep: series(6.8)),
          c: const [],
        ).mismatch,
        isFalse,
      );
    });
  });

  group('trend', () {
    test('slipping, steady and improving', () {
      TrendDirection trend(List<double> sleep) =>
          run(m: metrics(sleep: sleep)).reading(Indicator.sleep).trend;
      expect(trend(series(7, repeat(6.0, 3))), TrendDirection.slipping);
      expect(trend(series(7)), TrendDirection.steady);
      expect(trend(series(6.0, repeat(7.0, 3))), TrendDirection.improving);
    });
  });
}
