import '../l10n/l10n.dart';
import '../models/action_id.dart';
import '../models/app_settings.dart';
import '../models/health_models.dart';
import '../models/insight.dart';
import '../models/mission.dart';
import '../models/personality_profile.dart';
import '../models/risk_assessment.dart';
import 'action_planner.dart';
import 'format.dart';
import 'insight_service.dart';

/// Fully offline, template based. Never needs a network.
class RuleBasedInsightService implements InsightService {
  const RuleBasedInsightService();

  @override
  AiSource get source => AiSource.ruleBased;

  @override
  Future<Insight> generate(InsightContext context) async => build(context);

  Insight build(InsightContext context) {
    final l = context.l10n;
    final p = context.profile;
    final a = context.assessment;
    final tone = p.preferences.tone;
    final gentle = tone == Tone.gentle;
    final action = suggestAction(p, a);
    final worst = worstReading(a);
    final degrees = a.degreesOffCourse.round();

    final String first;
    if (worst == null) {
      first = gentle
          ? l.insOnCourseGentle(degrees)
          : l.insOnCourseDirect(degrees);
    } else {
      final name = worst.indicator.label(l);
      final cur = formatValue(l, worst.indicator, worst.current);
      final base = formatValue(l, worst.indicator, worst.baseline);
      final trend = worst.trend.label(l);
      first = gentle
          ? l.insWorstGentle(name, cur, base, trend)
          : l.insWorstDirect(
              name,
              worst.status.label(l).toLowerCase(),
              cur,
              base,
              trend,
            );
    }

    final String second;
    if (a.mismatch) {
      final days = a.sleepDaysBelowBaseline >= a.reactionDaysOffBaseline
          ? a.sleepDaysBelowBaseline
          : a.reactionDaysOffBaseline;
      second = gentle ? l.insMismatchGentle(days) : l.insMismatchDirect(days);
    } else if (a.lifeEventActive) {
      second = gentle ? l.insLifeGentle : l.insLifeDirect;
    } else {
      second = gentle
          ? l.insActionGentle(action.title(l))
          : l.insActionDirect(action.title(l));
    }

    return Insight(
      summary: '$first $second',
      explanation: _explanation(context, worst, action),
      suggestedAction: action,
      tone: tone,
      source: AiSource.ruleBased,
    );
  }

  String _explanation(
    InsightContext c,
    IndicatorReading? worst,
    ActionId action,
  ) {
    final l = c.l10n;
    final p = c.profile;
    final a = c.assessment;
    final parts = <String>[];

    String evidence() {
      if (worst == null) return l.insEvidenceAllOk;
      final days = worst.daysBeyondDrift;
      final sd = MissionPhase.forDay(a.missionDay) == MissionPhase.lateMission
          ? '0.8'
          : '1';
      final name = worst.indicator.label(l);
      final cur = formatValue(l, worst.indicator, worst.current);
      final base = formatValue(l, worst.indicator, worst.baseline);
      final buf = StringBuffer(
        days > 0
            ? l.insEvidenceBeyond(name, cur, base, sd, days)
            : l.insEvidence(name, cur, base),
      );
      if (worst.indicator == Indicator.sleep && a.nightsUnder6 > 0) {
        buf.write(' ${l.insNights(a.nightsUnder6)}');
      }
      if (a.lapsesRising) buf.write(' ${l.insLapses}');
      return buf.toString();
    }

    switch (p.locusOfControl) {
      case LocusOfControl.internal:
        parts.add(evidence());
        final options = orderedActions(
          p,
          lifeEventActive: a.lifeEventActive,
        ).take(3);
        parts.add(
          l.insOptions(
            options
                .map((o) => '${o.title(l)} (${o.description(l)})')
                .join('; '),
          ),
        );
      case LocusOfControl.mixed:
        parts.add(evidence());
        parts.add(l.insRecommended(action.title(l), action.description(l)));
      case LocusOfControl.external:
        parts.add(l.insRecommendedStep(action.title(l), action.description(l)));
    }

    if (a.phase == MissionPhase.lateMission) parts.add(l.insLatePhase);
    if (a.lifeEventActive) parts.add(l.insLifeSupport);
    return parts.join(' ');
  }
}
