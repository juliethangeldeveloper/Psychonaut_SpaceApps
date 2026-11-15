/// Every threshold the risk engine uses, in one place.
///
/// Values marked "brief" come from the project brief and are design choices, not
/// clinical cut-offs. Psychonaut detects drift from a personal baseline; it does not diagnose.
abstract final class RiskConstants {
  // Baseline ---------------------------------------------------------------

  /// Days of history used to compute each person's own mean and SD (brief).
  static const baselineDays = 30;

  // Standard-deviation rules (brief) ----------------------------------------

  /// "Drifting": worse than this many SD on the unfavourable side...
  static const driftSd = 1.0;

  /// ...after this mission day the drift limit tightens (brief; analog studies
  /// report behavioural symptoms rising after 5 to 6 months).
  static const lateMissionAfterDay = 150;
  static const lateMissionDriftSd = 0.8;

  /// "Off course": worse than this many SD...
  static const offCourseSd = 2.0;

  /// ...for this many days in a row, or beyond [driftSd] for [offCourseDaysAtDriftSd].
  static const driftDays = 3;
  static const offCourseDaysAtOffCourseSd = 3;
  static const offCourseDaysAtDriftSd = 7;

  /// Design assumption: a trait "flags one step sooner" by needing one day less.
  static const soonerDaysReduction = 1;

  /// Overall status is alert when this many indicators are off course together (brief).
  static const alertOffCourseCount = 3;

  // Sleep (brief) -------------------------------------------------------------

  static const healthySleepMinHours = 7.0;
  static const healthySleepMaxHours = 8.0;

  /// 6 hours or less is short sleep.
  static const shortSleepHours = 6.0;

  /// Under 6 hours for 7 nights is off course.
  static const sleepOffCourseHours = 6.0;
  static const sleepOffCourseNights = 7;

  /// Under 5 hours for 3 nights is alert.
  static const sleepAlertHours = 5.0;
  static const sleepAlertNights = 3;

  // Reaction test (brief) ------------------------------------------------------

  /// Rested mean response is about 250 ms.
  static const restedReactionMs = 250.0;

  /// A response slower than this is a lapse (classic PVT definition).
  static const lapseMs = 500.0;

  /// Rising lapses: latest test is this many above the personal baseline.
  static const lapseRiseMargin = 2.0;

  /// Used until 30 days of tests exist. Design assumption.
  static const defaultBaselineLapses = 1.0;

  /// Test length and prompt cadence (brief).
  static const testSeconds = 180;
  static const minStimulusGapMs = 2000;
  static const maxStimulusGapMs = 5000;
  static const reactionPromptDays = 4;

  // Mismatch (brief) -------------------------------------------------------------

  static const mismatchDays = 7;

  /// Design assumption: reaction time counts as "off baseline" beyond this many SD.
  static const mismatchReactionSd = 0.5;

  // Life events (brief) ------------------------------------------------------------

  static const lifeEventWatchDays = 14;

  // Profile modifiers (design assumptions) ---------------------------------------

  static const traitHigh = 70.0;
  static const traitLow = 30.0;

  /// Low conscientiousness or self-discipline: remind more often.
  static const reactionPromptDaysLowDiscipline = 3;
  static const checkInNudgeHour = 20;
  static const checkInNudgeHourLowDiscipline = 17;

  // Default SD, used until a person has 30 days of their own data. Design assumptions.
  static const defaultSd = {
    'sleep': 0.6, // hours
    'mood': 1.0,
    'stress': 1.0,
    'workload': 1.2,
    'engagement': 1.0,
    'focus': 1.0,
    'connection': 1.0,
    'reaction': 30.0, // ms
  };

  // Degrees off course (design assumption) -----------------------------------------

  /// An indicator at this many SD counts as fully off course for the degrees number.
  static const degreesFullSd = 3.0;
  static const degreesMax = 90.0;
  static const degreesMeanWeight = 0.6;
  static const degreesPeakWeight = 0.4;

  /// Floor so that a flagged status never contributes less than this severity.
  static const statusSeverityFloor = {
    'drifting': 0.3,
    'offCourse': 0.6,
    'alert': 1.0,
  };
}
