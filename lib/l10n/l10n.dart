import 'package:material_ui/material_ui.dart';

import '../data/reference_content.dart';
import '../models/action_id.dart';
import '../models/app_settings.dart';
import '../models/health_models.dart';
import '../models/mission.dart';
import '../models/personality_profile.dart';
import '../models/risk_assessment.dart';
import '../models/status.dart';
import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension StatusLabel on Status {
  String label(AppLocalizations l) => switch (this) {
    Status.onCourse => l.statusOnCourse,
    Status.drifting => l.statusDrifting,
    Status.offCourse => l.statusOffCourse,
    Status.alert => l.statusAlert,
  };
}

extension IndicatorLabel on Indicator {
  String label(AppLocalizations l) => switch (this) {
    Indicator.mood => l.indicatorMood,
    Indicator.stress => l.indicatorStress,
    Indicator.sleep => l.indicatorSleep,
    Indicator.focus => l.indicatorFocus,
    Indicator.motivation => l.indicatorMotivation,
    Indicator.connection => l.indicatorConnection,
    Indicator.workload => l.indicatorWorkload,
    Indicator.reaction => l.indicatorReaction,
  };
}

extension TrendLabel on TrendDirection {
  String label(AppLocalizations l) => switch (this) {
    TrendDirection.improving => l.trendImproving,
    TrendDirection.steady => l.trendSteady,
    TrendDirection.slipping => l.trendSlipping,
  };
}

extension ActionText on ActionId {
  String title(AppLocalizations l) => switch (this) {
    ActionId.exercise => l.actionExerciseTitle,
    ActionId.journal => l.actionJournalTitle,
    ActionId.familyCall => l.actionFamilyCallTitle,
    ActionId.garden => l.actionGardenTitle,
    ActionId.windowTime => l.actionWindowTimeTitle,
    ActionId.newProject => l.actionNewProjectTitle,
    ActionId.sleepReset => l.actionSleepResetTitle,
  };

  String description(AppLocalizations l) => switch (this) {
    ActionId.exercise => l.actionExerciseDesc,
    ActionId.journal => l.actionJournalDesc,
    ActionId.familyCall => l.actionFamilyCallDesc,
    ActionId.garden => l.actionGardenDesc,
    ActionId.windowTime => l.actionWindowTimeDesc,
    ActionId.newProject => l.actionNewProjectDesc,
    ActionId.sleepReset => l.actionSleepResetDesc,
  };
}

extension AiSourceText on AiSource {
  String label(AppLocalizations l) => switch (this) {
    AiSource.ruleBased => l.aiRuleBasedLabel,
    AiSource.onBoard => l.aiOnBoardLabel,
    AiSource.cloud => l.aiCloudLabel,
  };

  String description(AppLocalizations l) => switch (this) {
    AiSource.ruleBased => l.aiRuleBasedDesc,
    AiSource.onBoard => l.aiOnBoardDesc,
    AiSource.cloud => l.aiCloudDesc,
  };

  /// Short label used on the Home reading card.
  String sourceLine(AppLocalizations l) => switch (this) {
    AiSource.ruleBased => l.sourceRuleBased,
    AiSource.onBoard => l.sourceOnBoard,
    AiSource.cloud => l.sourceCloud,
  };
}

extension PhaseText on MissionPhase {
  String label(AppLocalizations l) => switch (this) {
    MissionPhase.adjustment => l.phaseAdjustment,
    MissionPhase.midMission => l.phaseMid,
    MissionPhase.lateMission => l.phaseLate,
  };

  String note(AppLocalizations l) => switch (this) {
    MissionPhase.adjustment => l.phaseAdjustmentNote,
    MissionPhase.midMission => l.phaseMidNote,
    MissionPhase.lateMission => l.phaseLateNote,
  };
}

extension NasaText on NasaRisk {
  String label(AppLocalizations l) => switch (this) {
    NasaRisk.behavioral => l.riskBehavioral,
    NasaRisk.teamwork => l.riskTeamwork,
    NasaRisk.sleep => l.riskSleep,
  };
}

extension HazardText on NasaHazard {
  String label(AppLocalizations l) => switch (this) {
    NasaHazard.isolation => l.hazardIsolation,
    NasaHazard.distance => l.hazardDistance,
  };
}

extension ProfileText on Tone {
  String label(AppLocalizations l) =>
      this == Tone.direct ? l.toneDirect : l.toneGentle;
}

extension LocusText on LocusOfControl {
  String framing(AppLocalizations l) => switch (this) {
    LocusOfControl.internal => l.framingInternal,
    LocusOfControl.mixed => l.framingMixed,
    LocusOfControl.external => l.framingExternal,
  };
}

extension CopingText on CopingStyle {
  String label(AppLocalizations l) => switch (this) {
    CopingStyle.problemFocused => l.copingProblem,
    CopingStyle.emotionFocused => l.copingEmotion,
    CopingStyle.avoidant => l.copingAvoidant,
  };
}

extension SourceText on ProfileSource {
  String label(AppLocalizations l) => switch (this) {
    ProfileSource.miniIpip => l.sourceMiniIpip,
    ProfileSource.ipipNeo120 => l.sourceIpipNeo120,
    ProfileSource.imported => l.sourceImported,
  };
}

/// Reference text for each indicator: how it is measured, why it matters, what to do.
extension ReferenceText on AppLocalizations {
  String measured(Indicator i) => switch (i) {
    Indicator.mood => refMeasuredMood,
    Indicator.stress => refMeasuredStress,
    Indicator.sleep => refMeasuredSleep,
    Indicator.focus => refMeasuredFocus,
    Indicator.motivation => refMeasuredMotivation,
    Indicator.connection => refMeasuredConnection,
    Indicator.workload => refMeasuredWorkload,
    Indicator.reaction => refMeasuredReaction,
  };

  String why(Indicator i) => switch (i) {
    Indicator.mood => refWhyMood,
    Indicator.stress => refWhyStress,
    Indicator.sleep => refWhySleep,
    Indicator.focus => refWhyFocus,
    Indicator.motivation => refWhyMotivation,
    Indicator.connection => refWhyConnection,
    Indicator.workload => refWhyWorkload,
    Indicator.reaction => refWhyReaction,
  };

  String todo(Indicator i) => switch (i) {
    Indicator.mood => refTodoMood,
    Indicator.stress => refTodoStress,
    Indicator.sleep => refTodoSleep,
    Indicator.focus => refTodoFocus,
    Indicator.motivation => refTodoMotivation,
    Indicator.connection => refTodoConnection,
    Indicator.workload => refTodoWorkload,
    Indicator.reaction => refTodoReaction,
  };
}

/// The language to show: the user's choice, else the device language, else English.
Locale resolveAppLocale(String? chosenCode, Locale device) {
  final wanted = chosenCode ?? device.languageCode;
  return AppLocalizations.supportedLocales.firstWhere(
    (l) => l.languageCode == wanted,
    orElse: () => const Locale('en'),
  );
}

extension IpipText on AppLocalizations {
  /// Full first-person sentence for Mini-IPIP item [index] (0 to 19).
  String ipipItem(int index) => [
    ipipItem1,
    ipipItem2,
    ipipItem3,
    ipipItem4,
    ipipItem5,
    ipipItem6,
    ipipItem7,
    ipipItem8,
    ipipItem9,
    ipipItem10,
    ipipItem11,
    ipipItem12,
    ipipItem13,
    ipipItem14,
    ipipItem15,
    ipipItem16,
    ipipItem17,
    ipipItem18,
    ipipItem19,
    ipipItem20,
  ][index];

  /// Label for 5-point answer [n] (1 to 5).
  String ipipAnswer(int n) =>
      [ipipAnswer1, ipipAnswer2, ipipAnswer3, ipipAnswer4, ipipAnswer5][n - 1];
}
