import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../l10n/l10n.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';
import 'crew_data.dart';

class CrewScreen extends ConsumerWidget {
  const CrewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joined = ref.watch(crewJoinedProvider);
    final sample = ref.watch(healthDataSourceProvider).isSample;
    final wide = !LayoutMode.of(context).isPhone;

    final content = ScreenScaffold(
      children: [
        ScreenHeader(
          title: context.l10n.crewTitle,
          subtitle: context.l10n.crewSubtitle,
          trailing: sample ? const SampleDataChip() : null,
        ),
        const SizedBox(height: AppSpacing.gap),
        const _MoraleMeter(morale: sampleCrewMorale),
        const SizedBox(height: AppSpacing.gap),
        _GoalCard(
          goal: sampleWeeklyGoal,
          joined: joined,
          onToggle: () => ref.read(crewJoinedProvider.notifier).set(!joined),
        ),
        const SizedBox(height: AppSpacing.gap),
        const _PrivacyCard(),
        const SizedBox(height: 20),
        const DisclaimerLine(),
      ],
    );

    if (!wide) return content;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: content,
      ),
    );
  }
}

class _MoraleMeter extends StatelessWidget {
  const _MoraleMeter({required this.morale});

  final CrewMorale morale;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final score = morale.score.round();
    final level = morale.level.label(l);
    return Semantics(
      label: l.crewMeterSemantics(
        level,
        score,
        morale.contributed,
        morale.crewSize,
      ),
      child: ExcludeSemantics(
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$score',
                    style: AppText.heading().copyWith(fontSize: 48),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(l.crewOutOf100, style: AppText.caption()),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      level,
                      style: AppText.section(color: AppColors.onCourse),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: morale.score / 100,
                  minHeight: 12,
                  backgroundColor: AppColors.border,
                  color: AppColors.onCourse,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l.scaleLow, style: AppText.caption()),
                  Text(l.scaleHigh, style: AppText.caption()),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                l.crewCheckedIn(morale.contributed, morale.crewSize),
                style: AppText.caption(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.joined,
    required this.onToggle,
  });

  final WeeklyGoal goal;
  final bool joined;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final people = goal.participants + (joined ? 1 : 0);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.crewGoalLabel, style: AppText.caption()),
          const SizedBox(height: 2),
          Text(context.l10n.crewGoalTitle, style: AppText.section()),
          const SizedBox(height: 6),
          Text(context.l10n.crewGoalDesc, style: AppText.body()),
          const SizedBox(height: 14),
          Semantics(
            label: context.l10n.crewGoalSemantics(goal.done, goal.segments),
            child: ExcludeSemantics(
              child: Row(
                children: [
                  for (var i = 0; i < goal.segments; i++) ...[
                    if (i > 0) const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: i < goal.done
                              ? AppColors.onCourse
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.crewGoalProgress(goal.done, goal.segments, people),
            style: AppText.caption(),
          ),
          const SizedBox(height: 14),
          joined
              ? OutlinedButton.icon(
                  onPressed: onToggle,
                  icon: const Icon(Icons.check),
                  label: Text(context.l10n.crewLeave),
                )
              : FilledButton(
                  onPressed: onToggle,
                  child: Text(context.l10n.crewJoin),
                ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lock_outline, color: AppColors.onCourse),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.crewPrivacyTitle, style: AppText.section()),
                const SizedBox(height: 4),
                Text(context.l10n.crewPrivacyBody, style: AppText.body()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
