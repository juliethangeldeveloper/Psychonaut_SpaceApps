// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navCheckIn => 'Check in';

  @override
  String get navTrends => 'Trends';

  @override
  String get navCrew => 'Crew';

  @override
  String get profileAndSettings => 'Profile and settings';

  @override
  String get back => 'Back';

  @override
  String get sampleData => 'Sample data';

  @override
  String get disclaimer =>
      'Psychonaut does not diagnose or replace a clinician.';

  @override
  String get statusOnCourse => 'On course';

  @override
  String get statusDrifting => 'Drifting';

  @override
  String get statusOffCourse => 'Off course';

  @override
  String get statusAlert => 'Alert';

  @override
  String traitSemantics(String label, int valueNum) {
    return '$label $valueNum out of 100';
  }

  @override
  String get indicatorMood => 'Mood';

  @override
  String get indicatorStress => 'Stress';

  @override
  String get indicatorSleep => 'Sleep';

  @override
  String get indicatorFocus => 'Focus';

  @override
  String get indicatorMotivation => 'Motivation';

  @override
  String get indicatorConnection => 'Connection';

  @override
  String get indicatorWorkload => 'Workload';

  @override
  String get indicatorReaction => 'Reaction time';

  @override
  String get trendImproving => 'improving';

  @override
  String get trendSteady => 'steady';

  @override
  String get trendSlipping => 'slipping';

  @override
  String get homeTitle => 'Your heading';

  @override
  String missionLine(int dayNum, String phase) {
    return 'Mission day $dayNum · $phase';
  }

  @override
  String headingSemantics(int degreesNum, String status) {
    return '$degreesNum degrees off course. Overall $status.';
  }

  @override
  String get headingOffCourse => 'off course';

  @override
  String get headingMeasured => 'Measured against your own baseline.';

  @override
  String get mismatchTitle => 'What you say and what your body shows differ';

  @override
  String mismatchBody(String mood, String details) {
    return 'You rated mood $mood, at or above your baseline, but $details. Both can be true. It is worth a closer look.';
  }

  @override
  String mismatchDetailSleep(int daysNum) {
    return 'sleep has been below your baseline for $daysNum days';
  }

  @override
  String mismatchDetailReaction(int daysNum) {
    return 'reaction time has been slower than your baseline for $daysNum days';
  }

  @override
  String mismatchJoin(String first, String second) {
    return '$first and $second';
  }

  @override
  String get lifeEventTitle => 'Something happened at home';

  @override
  String get lifeEventCardBody =>
      'That is hard to carry from so far away. You don\'t have to handle it alone. Mood is watched more closely for the next 14 days, and Message home is offered first.';

  @override
  String get reactionPromptTitle => 'Time for your reaction test';

  @override
  String get reactionPromptText =>
      'Three minutes. It shows fatigue before you feel it.';

  @override
  String get reactionPromptButton => 'Start test';

  @override
  String get logOpenTitle => 'Captain\'s log is open';

  @override
  String get logOpenText => 'You haven\'t logged today.';

  @override
  String get logEntry => 'Log entry';

  @override
  String get readingPreparing => 'Preparing your reading';

  @override
  String get readingUnavailable => 'Your reading is not available right now.';

  @override
  String get readingTitle => 'Today\'s reading';

  @override
  String get readingFixedAlertNote => 'Fixed safety message, not AI-generated.';

  @override
  String get aiGenerated => 'AI-generated';

  @override
  String get suggestedAction => 'Suggested action';

  @override
  String readingSource(String source) {
    return 'Source: $source';
  }

  @override
  String get sourceRuleBased => 'Rule-based · on this device';

  @override
  String get sourceOnBoard => 'On-board model';

  @override
  String get sourceCloud => 'Cloud model';

  @override
  String loadError(String error) {
    return 'Could not load your data.\n$error';
  }

  @override
  String get indicatorsTitle => 'Indicators';

  @override
  String get panelMindMap => 'Mind map';

  @override
  String get panelSelected => 'Selected indicator';

  @override
  String chartLast14(String indicator) {
    return '$indicator, last 14 days';
  }

  @override
  String get chartSleep14 => 'Sleep, 14 nights';

  @override
  String tileSemantics(String indicator, String status, String trend) {
    return '$indicator, $status, $trend';
  }

  @override
  String get trendNoData => 'No data yet';

  @override
  String get trendAtBaseline => 'At your baseline';

  @override
  String trendAbove(String amount) {
    return '$amount above baseline';
  }

  @override
  String trendBelow(String amount) {
    return '$amount below baseline';
  }

  @override
  String trendJoin(String where, String trend) {
    return '$where, $trend';
  }

  @override
  String detailNow(String now, String baseline, String trend) {
    return 'Now $now · your baseline $baseline · $trend';
  }

  @override
  String get flaggedSooner =>
      'Watched a day sooner for you, based on your profile.';

  @override
  String get detailHowMeasured => 'How it\'s measured';

  @override
  String get detailWhy => 'Why it matters';

  @override
  String get detailWhatToDo => 'What to do now';

  @override
  String whatToDoOptions(String text, String options) {
    return '$text Options: $options.';
  }

  @override
  String whatToDoRecommended(String text, String action) {
    return '$text Recommended: $action.';
  }

  @override
  String whatToDoOneStep(String action, String description) {
    return 'One step: $action. $description';
  }

  @override
  String get nasaRiskLabel => 'NASA risk';

  @override
  String get nasaHazardLabel => 'Hazard';

  @override
  String labelValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String unitHours(String value) {
    return '$value h';
  }

  @override
  String unitMs(String value) {
    return '$value ms';
  }

  @override
  String get refMeasuredMood =>
      'Your daily self-rating from 1 to 10 in the Captain\'s log, compared with your own baseline.';

  @override
  String get refWhyMood =>
      'Small, steady dips in mood are easier to fix early. Watching mood against your baseline is more useful than any single day.';

  @override
  String get refTodoMood =>
      'Log honestly, then pick one small action. Tell a crewmate if low days keep adding up.';

  @override
  String get refMeasuredStress =>
      'Your daily stress rating from 1 to 10, compared with your own baseline. Higher is less favourable.';

  @override
  String get refWhyStress =>
      'Long confinement keeps stress levels raised. Rising stress also tends to cut into sleep and focus.';

  @override
  String get refTodoStress =>
      'Slow your breathing for two minutes, move your body, or hand off one task for today.';

  @override
  String get refMeasuredSleep =>
      'Hours slept each night, from the sleep tracker or sample data. 7 to 8 hours is the healthy range; 6 hours or less is short sleep.';

  @override
  String get refWhySleep =>
      'Sleep loss and irregular schedules slow reactions, lower mood and make small problems feel bigger.';

  @override
  String get refTodoSleep =>
      'Keep a fixed lights-out time, dim screens an hour before and cool the cabin for a sleep reset.';

  @override
  String get refMeasuredFocus =>
      'Your focus rating from 1 to 10, together with the lapse count from the reaction test.';

  @override
  String get refWhyFocus =>
      'Attention is the first thing to slip when sleep or workload goes wrong, and errors cost the most in flight.';

  @override
  String get refTodoFocus =>
      'Take a real break away from screens, then do one task at a time. Check your sleep first.';

  @override
  String get refMeasuredMotivation =>
      'Your engagement rating from 1 to 10, compared with your own baseline.';

  @override
  String get refWhyMotivation =>
      'Long, repetitive missions invite boredom. Falling engagement can come before low mood.';

  @override
  String get refTodoMotivation =>
      'Start a small new project or change the order of your day for variety.';

  @override
  String get refMeasuredConnection =>
      'Your crew connection rating from 1 to 10, compared with your own baseline.';

  @override
  String get refWhyConnection =>
      'Good teamwork depends on feeling connected. Distance from Earth also makes contact with family slower and rarer.';

  @override
  String get refTodoConnection =>
      'Share a meal with the crew or send a message home. Small contact counts.';

  @override
  String get refMeasuredWorkload =>
      'Your workload rating from 1 to 10, compared with your own baseline. Higher is less favourable.';

  @override
  String get refWhyWorkload =>
      'Work overload eats into sleep. With delays to Earth, crews must manage their own pace.';

  @override
  String get refTodoWorkload =>
      'Move one task to tomorrow, or ask the crew to share it. Protect your sleep window.';

  @override
  String get refMeasuredReaction =>
      'A 3-minute reaction test. You tap as fast as you can when a stimulus appears. We record your mean response time, lapses (slower than 500 ms) and false starts.';

  @override
  String get refWhyReaction =>
      'Slow or lapsing responses are one of the earliest signs of fatigue and drifting attention, often before you feel it yourself.';

  @override
  String get refTodoReaction =>
      'Repeat the test every few days at a similar time of day, and compare with your own baseline.';

  @override
  String get actionExerciseTitle => 'Exercise';

  @override
  String get actionExerciseDesc => 'A short workout on the treadmill or bike.';

  @override
  String get actionJournalTitle => 'Journal';

  @override
  String get actionJournalDesc =>
      'Ten minutes of private writing about your day.';

  @override
  String get actionFamilyCallTitle => 'Message home';

  @override
  String get actionFamilyCallDesc =>
      'Send a message or schedule a call with someone on Earth.';

  @override
  String get actionGardenTitle => 'Window and garden time';

  @override
  String get actionGardenDesc => 'Spend time at the window or with the plants.';

  @override
  String get actionWindowTimeTitle => 'Window time';

  @override
  String get actionWindowTimeDesc =>
      'Spend ten minutes at the window looking at Earth or the stars.';

  @override
  String get actionNewProjectTitle => 'Start a small project';

  @override
  String get actionNewProjectDesc =>
      'Pick a short, new task to break the routine.';

  @override
  String get actionSleepResetTitle => 'Sleep reset';

  @override
  String get actionSleepResetDesc =>
      'Fixed lights-out, dim screens and a cooler cabin for one night.';

  @override
  String get aiRuleBasedLabel => 'Rule-based';

  @override
  String get aiRuleBasedDesc =>
      'Templates on this device. No network. Default.';

  @override
  String get aiOnBoardLabel => 'On-board model';

  @override
  String get aiOnBoardDesc =>
      'A model running on this computer or the ship\'s network. Nothing leaves the vehicle. Falls back to rule-based if it is not running.';

  @override
  String get aiCloudLabel => 'Cloud model';

  @override
  String get aiCloudDesc =>
      'A large language model over the internet. For use on Earth only. Sends your scores and personality profile, never your name or notes.';

  @override
  String get phaseAdjustment => 'Adjustment';

  @override
  String get phaseAdjustmentNote => 'Settling in. Routines are still forming.';

  @override
  String get phaseMid => 'Mid-mission';

  @override
  String get phaseMidNote => 'Steady state. Watch for slow drift.';

  @override
  String get phaseLate => 'Late mission';

  @override
  String get phaseLateNote =>
      'Past day 150 the watch is tighter. Behavioural symptoms rise after 5 to 6 months in analog studies.';

  @override
  String get riskBehavioral => 'Behavioral conditions';

  @override
  String get riskTeamwork => 'Inadequate teamwork';

  @override
  String get riskSleep => 'Inadequate sleep and irregular schedules';

  @override
  String get hazardIsolation => 'Isolation and confinement';

  @override
  String get hazardDistance => 'Distance from Earth';

  @override
  String get toneDirect => 'Direct';

  @override
  String get toneGentle => 'Gentle';

  @override
  String get framingInternal => 'Internal: data and options';

  @override
  String get framingMixed => 'Mixed: data and one recommendation';

  @override
  String get framingExternal => 'External: one clear step';

  @override
  String get copingProblem => 'Problem-focused';

  @override
  String get copingEmotion => 'Emotion-focused';

  @override
  String get copingAvoidant => 'Avoidant';

  @override
  String get sourceMiniIpip => 'Mini-IPIP questionnaire';

  @override
  String get sourceIpipNeo120 => 'IPIP-NEO-120 questionnaire';

  @override
  String get sourceImported => 'Imported file';

  @override
  String get alertMessage =>
      'Tell your crew medical officer and prepare a summary for Earth';

  @override
  String sourceUnavailableNote(String source) {
    return '$source unavailable, so this reading came from the rule-based source.';
  }

  @override
  String insOnCourseDirect(int degreesNum) {
    return 'You are on course at $degreesNum° off, and every reading sits close to your own baseline.';
  }

  @override
  String insOnCourseGentle(int degreesNum) {
    return 'You\'re on course, just $degreesNum° off, and your readings sit close to your own normal.';
  }

  @override
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator has moved a little: $current now against your usual $baseline, and it is $trend.';
  }

  @override
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator is $status at $current against your baseline of $baseline, and it is $trend.';
  }

  @override
  String insMismatchGentle(int daysNum) {
    return 'You said you feel fine, and that counts, but your body data has been off baseline for $daysNum days.';
  }

  @override
  String insMismatchDirect(int daysNum) {
    return 'You rated mood at or above baseline, but your body data has been off baseline for $daysNum days.';
  }

  @override
  String get insLifeGentle =>
      'You noted something from home, so mood is being watched a little more closely for now.';

  @override
  String get insLifeDirect =>
      'You logged something from home, so mood is watched more closely for 14 days.';

  @override
  String insActionGentle(String action) {
    return 'One small step could help today: $action.';
  }

  @override
  String insActionDirect(String action) {
    return 'One small action today: $action.';
  }

  @override
  String get insEvidenceAllOk =>
      'All readings are within one standard deviation of your own baseline.';

  @override
  String insEvidence(String indicator, String current, String baseline) {
    return '$indicator: $current against a baseline of $baseline.';
  }

  @override
  String insEvidenceBeyond(
    String indicator,
    String current,
    String baseline,
    String sd,
    int count,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$indicator: $current against a baseline of $baseline, beyond $sd SD for $_temp0.';
  }

  @override
  String insNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recent nights of 6 hours or less.',
      one: '1 recent night of 6 hours or less.',
    );
    return '$_temp0';
  }

  @override
  String get insLapses => 'Lapses in the reaction test are above your usual.';

  @override
  String insOptions(String options) {
    return 'Options: $options';
  }

  @override
  String insRecommended(String action, String description) {
    return 'Recommended: $action. $description';
  }

  @override
  String insRecommendedStep(String action, String description) {
    return 'Recommended step: $action. $description Just this one step today.';
  }

  @override
  String get insLatePhase =>
      'After mission day 150 the watch is tighter, so smaller changes are flagged.';

  @override
  String get insLifeSupport =>
      'Hearing from home can be heavy. Reaching out to someone you trust may help.';

  @override
  String get trendsTitle => 'Course deviation';

  @override
  String get trendsSubtitle => 'How you are drifting from your own baseline';

  @override
  String get trendsSleepTitle => 'Sleep, last 14 nights';

  @override
  String get trendsNoTests => 'No tests yet';

  @override
  String trendsLatestReaction(String ms, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lapses',
      one: '1 lapse',
    );
    return 'Latest $ms · $_temp0';
  }

  @override
  String trendsNasaLine(String risk, String hazards) {
    return 'NASA risk: $risk. Hazard: $hazards.';
  }

  @override
  String get correctionsTitle => 'Course corrections';

  @override
  String get correctionsHint =>
      'Pick one small action. Your preferred ones come first.';

  @override
  String correctionsPlan(String title, String description) {
    return 'Your plan: $title. $description';
  }

  @override
  String get correctionsSuggested => 'Suggested';

  @override
  String actionSemantics(String title, String description) {
    return '$title. $description';
  }

  @override
  String actionSemanticsSuggested(String title, String description) {
    return '$title. $description Suggested for today.';
  }

  @override
  String get chartNoSleep => 'No sleep data yet.';

  @override
  String chartBaselineValue(String value) {
    return 'Your baseline $value';
  }

  @override
  String get chartBaseline => 'Your baseline';

  @override
  String chartTooltipSleep(String value, String status) {
    return '$value\n$status';
  }

  @override
  String chartSleepSemantics(
    int count,
    String baseline,
    String latest,
    String status,
  ) {
    return 'Sleep over the last $count nights. Baseline $baseline. Latest night $latest, $status.';
  }

  @override
  String get chartToday => 'Today';

  @override
  String get chartNeedTests =>
      'Take the reaction test a few times to see your trend.';

  @override
  String chartReactionSemantics(int count, String baseline, String latest) {
    return 'Reaction time over the last $count tests. Baseline $baseline. Latest $latest.';
  }

  @override
  String get chartNotEnough => 'Not enough data yet.';

  @override
  String chartDaysAgo(int daysNum) {
    return '-${daysNum}d';
  }

  @override
  String get checkinTitle => 'Captain\'s log';

  @override
  String get checkinSubtitle =>
      'How are you today? Be honest. There are no wrong answers.';

  @override
  String get qEngagement => 'Engagement';

  @override
  String get qConnection => 'Crew connection';

  @override
  String get scaleLow => 'Low';

  @override
  String get scaleHigh => 'High';

  @override
  String get scaleCalm => 'Calm';

  @override
  String get scaleVeryStressed => 'Very stressed';

  @override
  String get scaleLight => 'Light';

  @override
  String get scaleOverloaded => 'Overloaded';

  @override
  String get scaleBored => 'Bored';

  @override
  String get scaleAbsorbed => 'Absorbed';

  @override
  String get scaleScattered => 'Scattered';

  @override
  String get scaleSharp => 'Sharp';

  @override
  String get scaleDistant => 'Distant';

  @override
  String get scaleClose => 'Close';

  @override
  String checkinStreak(int count) {
    return '$count-day streak';
  }

  @override
  String checkinStreakSemantics(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return 'Logging streak: $_temp0';
  }

  @override
  String get checkinStreakNote =>
      'Counts days you logged, never how the scores look.';

  @override
  String get checkinOptional => 'Optional.';

  @override
  String get checkinNoteLabel => 'Private note';

  @override
  String get checkinNoteHelper => 'Stays on this device. Never sent anywhere.';

  @override
  String get checkinUpdate => 'Update today\'s entry';

  @override
  String get checkinLogged => 'Entry logged. Thank you.';

  @override
  String sliderSemantics(String label, int valueNum) {
    return '$label $valueNum out of 10';
  }

  @override
  String get crewTitle => 'Ship morale';

  @override
  String get crewSubtitle => 'How the crew is doing, as one anonymous number';

  @override
  String get moraleHigh => 'High';

  @override
  String get moraleSteady => 'Steady';

  @override
  String get moraleStrained => 'Strained';

  @override
  String get moraleLow => 'Low';

  @override
  String get crewOutOf100 => '/ 100';

  @override
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  ) {
    return 'Crew morale $level, $scoreNum out of 100. $contributedNum of $crewNum crew checked in today.';
  }

  @override
  String crewCheckedIn(int contributedNum, int crewNum) {
    return '$contributedNum of $crewNum crew checked in today. Names are never shown.';
  }

  @override
  String get crewGoalLabel => 'Shared weekly goal';

  @override
  String get crewGoalTitle => 'Share an evening meal together';

  @override
  String get crewGoalDesc =>
      'Eat one evening meal with the crew on 6 evenings this week. Short and unhurried is fine.';

  @override
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum) {
    return '$doneNum of $segmentsNum evenings done · $peopleNum crew joined';
  }

  @override
  String crewGoalSemantics(int doneNum, int segmentsNum) {
    return '$doneNum of $segmentsNum evenings done';
  }

  @override
  String get crewJoin => 'Join this goal';

  @override
  String get crewLeave => 'You\'ve joined. Tap to leave';

  @override
  String get crewPrivacyTitle => 'Your privacy';

  @override
  String get crewPrivacyBody =>
      'Only a group average is shown. Your own scores, notes and profile stay on this device. There are no names, no rankings and no comparisons between people.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSubtitle =>
      'Everything stays on this device unless you choose the cloud model.';

  @override
  String get profileRetake => 'Retake the questionnaire';

  @override
  String get profileSamples => 'Sample profiles';

  @override
  String get profileSamplesHint =>
      'Switch to a bundled sample to see how the app adapts to a different person.';

  @override
  String get scienceTitle => 'About the science';

  @override
  String profileLoaded(String name) {
    return 'Loaded $name.';
  }

  @override
  String get profileCurrent => 'Current';

  @override
  String profileCurrentSemantics(String label) {
    return '$label, current';
  }

  @override
  String get traitOpenness => 'Openness';

  @override
  String get traitConscientiousness => 'Conscientiousness';

  @override
  String get traitExtraversion => 'Extraversion';

  @override
  String get traitAgreeableness => 'Agreeableness';

  @override
  String get traitEmotionalStability => 'Emotional stability';

  @override
  String get traitBoredom => 'Boredom proneness';

  @override
  String get facetsTitle => 'Facets';

  @override
  String get facetExcitement => 'Excitement-seeking';

  @override
  String get facetGregariousness => 'Gregariousness';

  @override
  String get facetVulnerability => 'Vulnerability';

  @override
  String get facetSelfDiscipline => 'Self-discipline';

  @override
  String get profileAdviceFraming => 'Advice framing';

  @override
  String get profileCoping => 'Coping style';

  @override
  String get profileTone => 'Tone';

  @override
  String get profilePreferred => 'Preferred actions';

  @override
  String get profileBaseline => 'Baseline';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get restingHeartRate => 'Resting heart rate';

  @override
  String get hrvLabel => 'HRV';

  @override
  String unitBpm(String value) {
    return '$value bpm';
  }

  @override
  String get settingsMissionDay => 'Mission day';

  @override
  String get settingsPrevDay => 'Previous day';

  @override
  String get settingsNextDay => 'Next day';

  @override
  String settingsDay(int dayNum) {
    return 'Day $dayNum';
  }

  @override
  String settingsMissionDaySemantics(int dayNum, String phase) {
    return 'Mission day $dayNum, $phase';
  }

  @override
  String get settingsAiSource => 'AI source';

  @override
  String get settingsAiHint =>
      'Where the written reading on Home comes from. At alert level the message is always fixed.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageHint =>
      'Choose the language of the app. The written reading follows it.';

  @override
  String get languageDevice => 'Device language';

  @override
  String get importTitle => 'Import a profile';

  @override
  String get importHint =>
      'Load another person from a JSON file with the same fields as the bundled samples. Nothing is uploaded.';

  @override
  String get importButton => 'Import profile JSON';

  @override
  String importFailed(String error) {
    return 'Couldn\'t import this file. $error';
  }

  @override
  String get importNotJson => 'That file is not valid JSON.';

  @override
  String get importUnreadable => 'That file could not be read.';

  @override
  String importDone(String name) {
    return 'Imported $name.';
  }

  @override
  String get scienceSubtitle => 'Where the ideas in Psychonaut come from.';

  @override
  String get scienceAssumptionsTitle => 'Design assumptions';

  @override
  String get sciHrpTitle => 'NASA Human Research Program: Hazards and Risks';

  @override
  String get sciHrpBody =>
      'The list of spaceflight hazards, including isolation and confinement and distance from Earth, and the human health risks linked to them.';

  @override
  String get sciBhrTitle => 'NASA Behavioral Health Risk Record';

  @override
  String get sciBhrBody =>
      'The behavioural health and performance risks for long missions: behavioural conditions, teamwork and sleep.';

  @override
  String get sciReactionTitle => 'Reaction Self-Test research';

  @override
  String get sciReactionBody =>
      'Basner, Mollicone and Dinges (2011), a brief psychomotor vigilance test (PVT-B), and the NASA Reaction Self-Test used by astronauts to track fatigue.';

  @override
  String get sciIpipTitle => 'International Personality Item Pool (IPIP)';

  @override
  String get sciIpipBody =>
      'Public domain items from ipip.ori.org. The 20-item Mini-IPIP is by Donnellan, Oswald, Baird and Lucas (2006). The full product would use the 120-item IPIP-NEO-120 for 30 facets.';

  @override
  String get sciAssume1 =>
      'Thresholds in standard deviations, and the days needed to flag a change, are design choices for a prototype.';

  @override
  String get sciAssume2 =>
      'The tighter limit after mission day 150 follows analog studies that report behavioural symptoms rising after 5 to 6 months.';

  @override
  String get sciAssume3 =>
      'Personality traits only shift how soon a change is flagged. They never label a person.';

  @override
  String get reactionTitle => 'Reaction test';

  @override
  String get ipipItem1 => 'I am the life of the party';

  @override
  String get ipipItem2 => 'I sympathize with others\' feelings';

  @override
  String get ipipItem3 => 'I get chores done right away';

  @override
  String get ipipItem4 => 'I have frequent mood swings';

  @override
  String get ipipItem5 => 'I have a vivid imagination';

  @override
  String get ipipItem6 => 'I don\'t talk a lot';

  @override
  String get ipipItem7 => 'I am not interested in other people\'s problems';

  @override
  String get ipipItem8 =>
      'I often forget to put things back in their proper place';

  @override
  String get ipipItem9 => 'I am relaxed most of the time';

  @override
  String get ipipItem10 => 'I am not interested in abstract ideas';

  @override
  String get ipipItem11 => 'I talk to a lot of different people at parties';

  @override
  String get ipipItem12 => 'I feel others\' emotions';

  @override
  String get ipipItem13 => 'I like order';

  @override
  String get ipipItem14 => 'I get upset easily';

  @override
  String get ipipItem15 => 'I have difficulty understanding abstract ideas';

  @override
  String get ipipItem16 => 'I keep in the background';

  @override
  String get ipipItem17 => 'I am not really interested in others';

  @override
  String get ipipItem18 => 'I make a mess of things';

  @override
  String get ipipItem19 => 'I seldom feel blue';

  @override
  String get ipipItem20 => 'I do not have a good imagination';

  @override
  String get ipipAnswer1 => 'Very inaccurate';

  @override
  String get ipipAnswer2 => 'Moderately inaccurate';

  @override
  String get ipipAnswer3 => 'Neither inaccurate nor accurate';

  @override
  String get ipipAnswer4 => 'Moderately accurate';

  @override
  String get ipipAnswer5 => 'Very accurate';

  @override
  String ipipAnswerSemantics(String n, String label) {
    return '$n, $label';
  }

  @override
  String onbStep(int stepNum, int totalNum) {
    return 'Step $stepNum of $totalNum';
  }

  @override
  String get onbNext => 'Next';

  @override
  String get onbCreate => 'Create profile';

  @override
  String get onbWelcome => 'Welcome aboard';

  @override
  String get onbWelcomeSub => 'Psychonaut, your daily companion';

  @override
  String get onbIntro =>
      'Psychonaut compares you with your own baseline and suggests one small action a day. A short questionnaire of 20 statements tunes how soon it flags changes and how it speaks to you. Your answers stay on this device.';

  @override
  String get onbName => 'Your name';

  @override
  String get onbRole => 'Your role, for example Commander';

  @override
  String get onbExploring => 'Just exploring?';

  @override
  String get onbSampleHint => 'Load a sample profile instead.';

  @override
  String get onbCancel => 'Cancel and keep my current profile';

  @override
  String get onbAboutYou => 'About you';

  @override
  String onbItemsHint(int pageNum, int pagesNum) {
    return 'Describe yourself as you generally are now, not as you wish to be. Page $pageNum of $pagesNum.';
  }

  @override
  String get onbLocusTitle => 'When things go well or badly';

  @override
  String get onbLocusSub =>
      'Which sounds most like you? This shapes how advice is framed.';

  @override
  String get onbLocusInternalTitle => 'Mostly my own choices and effort';

  @override
  String get onbLocusInternalText =>
      'What happens to me is mostly down to what I do.';

  @override
  String get onbLocusMixedTitle => 'A mix of both';

  @override
  String get onbLocusMixedText =>
      'My effort matters, and so do circumstances I can\'t control.';

  @override
  String get onbLocusExternalTitle => 'Mostly circumstances and other people';

  @override
  String get onbLocusExternalText =>
      'Much of what happens is outside my control.';

  @override
  String get onbToneTitle => 'How should Psychonaut talk to you?';

  @override
  String get onbToneSub => 'You can change this later.';

  @override
  String get onbToneDirectEx =>
      '\"Sleep is down 0.8 h. Try a sleep reset tonight.\"';

  @override
  String get onbToneGentleEx =>
      '\"Sleep has moved a little. A calm evening might help.\"';

  @override
  String get onbActionsTitle => 'What helps you reset?';

  @override
  String get onbActionsSub =>
      'Pick the actions you like. The order you tap is the order they are offered.';

  @override
  String get onbYourProfile => 'Your profile';

  @override
  String get onbTraits => 'Personality traits';

  @override
  String get onbTraitsNote =>
      'From a 20-item short form. Traits only change how soon a shift is flagged. They never label you.';

  @override
  String get onbPrefs => 'Your preferences';

  @override
  String get onbActionsLabel => 'Actions';

  @override
  String get roleDefault => 'Crew member';

  @override
  String get importPickerTitle => 'Choose a profile JSON file';

  @override
  String get reactionIntro =>
      'This 3-minute test checks how alert you are. When the screen says \"Tap now\", tap as fast as you can. Do not tap before it appears.';

  @override
  String get reactionKeyboardHint => 'On a keyboard, press Space.';

  @override
  String get reactionWait => 'Wait…';

  @override
  String get reactionTapNow => 'Tap now';

  @override
  String get reactionTooSoon => 'Too soon. Wait for the signal.';

  @override
  String reactionTimeLeft(String time) {
    return '$time left';
  }

  @override
  String get reactionDiscardHint => 'Going back now discards this test.';

  @override
  String get reactionDoneTitle => 'Test complete';

  @override
  String get reactionMean => 'Mean reaction time';

  @override
  String get reactionResponses => 'Responses';

  @override
  String get reactionLapses => 'Lapses (slower than 500 ms)';

  @override
  String get reactionFalseStarts => 'False starts';

  @override
  String get reactionSaved => 'Saved. You can see it in Trends.';

  @override
  String get reactionNoResponses =>
      'No responses were recorded, so nothing was saved.';

  @override
  String get reactionDone => 'Done';
}
