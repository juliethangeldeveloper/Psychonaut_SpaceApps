enum MissionPhase {
  adjustment,
  midMission,
  lateMission;

  // Design assumption: day 30 and day 150 boundaries.
  static const adjustmentEndsDay = 30;
  static const lateMissionAfterDay = 150;

  static MissionPhase forDay(int day) {
    if (day > lateMissionAfterDay) return MissionPhase.lateMission;
    if (day <= adjustmentEndsDay) return MissionPhase.adjustment;
    return MissionPhase.midMission;
  }
}
