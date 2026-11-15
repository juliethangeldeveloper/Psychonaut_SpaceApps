import '../models/action_id.dart';
import '../models/health_models.dart';
import '../models/personality_profile.dart';
import '../models/risk_assessment.dart';
import '../models/status.dart';

/// All actions in the default order, used to fill gaps after the profile's preferences.
const defaultActionOrder = ActionId.values;

/// Which actions fit each indicator best. Design assumption.
const _candidates = <Indicator, List<ActionId>>{
  Indicator.sleep: [ActionId.sleepReset, ActionId.windowTime],
  Indicator.mood: [ActionId.familyCall, ActionId.garden, ActionId.journal],
  Indicator.stress: [ActionId.exercise, ActionId.journal, ActionId.garden],
  Indicator.focus: [
    ActionId.sleepReset,
    ActionId.exercise,
    ActionId.windowTime,
  ],
  Indicator.motivation: [ActionId.newProject, ActionId.exercise],
  Indicator.connection: [ActionId.familyCall, ActionId.journal],
  Indicator.workload: [ActionId.sleepReset, ActionId.journal],
  Indicator.reaction: [ActionId.sleepReset, ActionId.exercise],
};

/// Profile preferences decide the order. A logged life event puts "Message home" first.
List<ActionId> orderedActions(
  PersonalityProfile profile, {
  bool lifeEventActive = false,
}) {
  final out = <ActionId>[];
  void add(ActionId a) {
    if (!out.contains(a)) out.add(a);
  }

  if (lifeEventActive) add(ActionId.familyCall);
  profile.preferences.preferredActions.forEach(add);
  defaultActionOrder.forEach(add);
  return out;
}

/// The reading furthest off course, or null when everything is on course.
IndicatorReading? worstReading(RiskAssessment a) {
  IndicatorReading? worst;
  for (final r in a.readings.values) {
    if (r.status == Status.onCourse || !r.hasData) continue;
    if (worst == null ||
        r.status.index > worst.status.index ||
        (r.status == worst.status && r.z > worst.z)) {
      worst = r;
    }
  }
  return worst;
}

/// One suggested action: the best fit for the worst reading that the person prefers.
ActionId suggestAction(PersonalityProfile profile, RiskAssessment a) {
  if (a.lifeEventActive) return ActionId.familyCall;
  final worst = worstReading(a);
  if (worst == null) {
    final preferred = profile.preferences.preferredActions;
    return preferred.isNotEmpty ? preferred.first : ActionId.journal;
  }
  return suggestActionForIndicator(profile, worst.indicator);
}

/// Best fit for one indicator, favouring what the person prefers.
ActionId suggestActionForIndicator(
  PersonalityProfile profile,
  Indicator indicator,
) {
  final options = _candidates[indicator]!;
  for (final o in options) {
    if (profile.preferences.preferredActions.contains(o)) return o;
  }
  return options.first;
}
