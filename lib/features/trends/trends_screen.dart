import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../data/reference_content.dart';
import '../../l10n/l10n.dart';
import '../../models/action_id.dart';
import '../../models/health_models.dart';
import '../../models/personality_profile.dart';
import '../../models/risk_assessment.dart';
import '../../services/action_planner.dart';
import '../../services/format.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';
import 'charts.dart';

const _gap = SizedBox(height: AppSpacing.gap);

const _actionIcons = {
  ActionId.exercise: Icons.fitness_center,
  ActionId.journal: Icons.edit_note,
  ActionId.familyCall: Icons.call_outlined,
  ActionId.garden: Icons.local_florist_outlined,
  ActionId.windowTime: Icons.public,
  ActionId.newProject: Icons.lightbulb_outline,
  ActionId.sleepReset: Icons.bedtime_outlined,
};

class TrendsScreen extends ConsumerStatefulWidget {
  const TrendsScreen({super.key});

  @override
  ConsumerState<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends ConsumerState<TrendsScreen> {
  ActionId? _selected;

  @override
  Widget build(BuildContext context) {
    final assessment = ref.watch(assessmentProvider);
    final snapshot = ref.watch(snapshotProvider);
    final tests = ref.watch(reactionHistoryProvider).value ?? const [];
    final profile = ref.watch(profileProvider);
    final sample = ref.watch(healthDataSourceProvider).isSample;
    final mode = LayoutMode.of(context);

    final a = assessment.value;
    final metrics = snapshot.value?.metrics;
    if (profile == null || a == null || metrics == null) {
      if (assessment.hasError || snapshot.hasError) {
        return Center(
          child: Text(
            context.l10n.loadError('${assessment.error ?? snapshot.error}'),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    }

    final l = context.l10n;
    final header = ScreenHeader(
      title: l.trendsTitle,
      subtitle: l.trendsSubtitle,
      trailing: sample ? const SampleDataChip() : null,
    );

    final charts = [
      _SleepCard(metrics: metrics, assessment: a),
      _ReactionCard(tests: tests, assessment: a),
    ];
    final guidance = [
      _WhyCard(assessment: a),
      _Corrections(
        profile: profile,
        assessment: a,
        selected: _selected,
        onSelect: (id) => setState(() => _selected = id),
      ),
    ];

    final Widget body = mode.isPhone
        ? Column(children: _spaced([...charts, ...guidance]))
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: _spaced(charts))),
              const SizedBox(width: AppSpacing.screenPadding),
              Expanded(child: Column(children: _spaced(guidance))),
            ],
          );

    return ScreenScaffold(
      children: [
        header,
        _gap,
        body,
        const SizedBox(height: 20),
        const DisclaimerLine(),
      ],
    );
  }
}

List<Widget> _spaced(List<Widget> items) => [
  for (var i = 0; i < items.length; i++) ...[if (i > 0) _gap, items[i]],
];

class _SleepCard extends StatelessWidget {
  const _SleepCard({required this.metrics, required this.assessment});

  final List<DayMetrics> metrics;
  final RiskAssessment assessment;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final r = assessment.reading(Indicator.sleep);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l.trendsSleepTitle, style: AppText.section()),
              ),
              StatusBadge(r.status),
            ],
          ),
          const SizedBox(height: 4),
          Text(trendText(l, r), style: AppText.caption()),
          const SizedBox(height: 14),
          SleepBarChart(metrics: metrics, reading: r),
          if (assessment.nightsUnder6 > 0) ...[
            const SizedBox(height: 10),
            Text(
              l.insNights(assessment.nightsUnder6),
              style: AppText.caption(),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReactionCard extends StatelessWidget {
  const _ReactionCard({required this.tests, required this.assessment});

  final List<ReactionResult> tests;
  final RiskAssessment assessment;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final r = assessment.reading(Indicator.reaction);
    final last = assessment.latestReaction;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l.indicatorReaction, style: AppText.section()),
              ),
              if (r.hasData) StatusBadge(r.status),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            last == null
                ? l.trendsNoTests
                : l.trendsLatestReaction(
                    formatValue(l, Indicator.reaction, last.meanMs),
                    last.lapses,
                  ),
            style: AppText.caption(),
          ),
          const SizedBox(height: 14),
          ReactionLineChart(tests: tests, baselineMs: r.baseline),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.push('/reaction'),
            icon: const Icon(Icons.bolt_outlined),
            label: Text(l.reactionPromptButton),
          ),
        ],
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  const _WhyCard({required this.assessment});

  final RiskAssessment assessment;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final sleep = ReferenceContent.of(Indicator.sleep);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.detailWhy, style: AppText.section()),
          const SizedBox(height: 6),
          Text(l.why(Indicator.sleep), style: AppText.body()),
          const SizedBox(height: 8),
          Text(l.why(Indicator.reaction), style: AppText.body()),
          const SizedBox(height: 12),
          Text(
            l.trendsNasaLine(
              sleep.risk.label(l),
              sleep.hazards.map((h) => h.label(l)).join(', '),
            ),
            style: AppText.caption(),
          ),
        ],
      ),
    );
  }
}

class _Corrections extends StatelessWidget {
  const _Corrections({
    required this.profile,
    required this.assessment,
    required this.selected,
    required this.onSelect,
  });

  final PersonalityProfile profile;
  final RiskAssessment assessment;
  final ActionId? selected;
  final ValueChanged<ActionId?> onSelect;

  @override
  Widget build(BuildContext context) {
    final actions = orderedActions(
      profile,
      lifeEventActive: assessment.lifeEventActive,
    ).take(3).toList();
    final suggested = suggestAction(profile, assessment);
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.correctionsTitle, style: AppText.section()),
        const SizedBox(height: 4),
        Text(l.correctionsHint, style: AppText.caption()),
        _gap,
        for (final a in actions) ...[
          _ActionCard(
            action: a,
            selected: a == selected,
            suggested: a == suggested,
            onTap: () => onSelect(a == selected ? null : a),
          ),
          _gap,
        ],
        if (selected != null)
          AppCard(
            borderColor: AppColors.onCourse,
            child: Row(
              children: [
                const Icon(Icons.flag_outlined, color: AppColors.onCourse),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l.correctionsPlan(
                      selected!.title(l),
                      selected!.description(l),
                    ),
                    style: AppText.body(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.action,
    required this.selected,
    required this.suggested,
    required this.onTap,
  });

  final ActionId action;
  final bool selected;
  final bool suggested;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Semantics(
      button: true,
      selected: selected,
      label: suggested
          ? l.actionSemanticsSuggested(action.title(l), action.description(l))
          : l.actionSemantics(action.title(l), action.description(l)),
      child: ExcludeSemantics(
        child: AppCard(
          selected: selected,
          borderColor: selected ? AppColors.onCourse : null,
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                _actionIcons[action],
                color: selected ? AppColors.onCourse : AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            action.title(l),
                            style: AppText.body(
                              size: 15,
                              weight: 600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (suggested) ...[
                          const SizedBox(width: 8),
                          Text(
                            l.correctionsSuggested,
                            style: AppText.caption(color: AppColors.onCourse),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(action.description(l), style: AppText.caption()),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? AppColors.onCourse : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
