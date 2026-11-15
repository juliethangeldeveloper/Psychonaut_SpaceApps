import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../l10n/l10n.dart';
import '../../models/insight.dart';
import '../../models/risk_assessment.dart';
import '../../models/status.dart';
import '../../services/history.dart';
import '../../services/risk_engine.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';
import 'indicator_widgets.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({
    super.key,
    required this.assessment,
    this.showProfile = true,
  });

  final RiskAssessment assessment;
  final bool showProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sample = ref.watch(healthDataSourceProvider).isSample;
    final l = context.l10n;
    return ScreenHeader(
      title: l.homeTitle,
      subtitle: missionLine(l, assessment),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (sample) const SampleDataChip(),
          if (showProfile)
            IconButton(
              tooltip: l.profileAndSettings,
              constraints: const BoxConstraints(
                minWidth: AppSpacing.minTapTarget,
                minHeight: AppSpacing.minTapTarget,
              ),
              onPressed: () => context.push('/profile'),
              icon: const Icon(Icons.account_circle_outlined, size: 28),
            ),
        ],
      ),
    );
  }
}

/// Degrees off course and the overall status.
class HeadingCard extends StatelessWidget {
  const HeadingCard({super.key, required this.assessment});

  final RiskAssessment assessment;

  @override
  Widget build(BuildContext context) {
    final a = assessment;
    final l = context.l10n;
    return Semantics(
      label: l.headingSemantics(a.degreesOffCourse.round(), a.overall.label(l)),
      child: ExcludeSemantics(
        child: AppCard(
          borderColor: AppColors.forStatus(a.overall),
          child: Row(
            children: [
              Text(
                '${a.degreesOffCourse.round()}°',
                style: AppText.heading().copyWith(fontSize: 48),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.headingOffCourse, style: AppText.section()),
                    const SizedBox(height: 4),
                    StatusBadge(a.overall, fontSize: 15),
                    const SizedBox(height: 4),
                    Text(l.headingMeasured, style: AppText.caption()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shown when self-report and body data disagree.
class MismatchAlertCard extends StatelessWidget {
  const MismatchAlertCard({super.key, required this.assessment});

  final RiskAssessment assessment;

  @override
  Widget build(BuildContext context) {
    final a = assessment;
    final l = context.l10n;
    final bodyParts = [
      if (a.sleepDaysBelowBaseline >= 7)
        l.mismatchDetailSleep(a.sleepDaysBelowBaseline),
      if (a.reactionDaysOffBaseline >= 7)
        l.mismatchDetailReaction(a.reactionDaysOffBaseline),
    ];
    final details = bodyParts.length == 2
        ? l.mismatchJoin(bodyParts[0], bodyParts[1])
        : bodyParts.join();
    return AppCard(
      borderColor: AppColors.drifting,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.compare_arrows, color: AppColors.drifting),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.mismatchTitle, style: AppText.section()),
                const SizedBox(height: 4),
                Text(
                  l.mismatchBody(
                    a.latestMood?.toStringAsFixed(0) ?? '',
                    details,
                  ),
                  style: AppText.body(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Supportive message while a logged life event is being watched.
class LifeEventCard extends StatelessWidget {
  const LifeEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.favorite_border, color: AppColors.onCourse),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.lifeEventTitle, style: AppText.section()),
                const SizedBox(height: 4),
                Text(context.l10n.lifeEventCardBody, style: AppText.body()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Gentle prompts for the reaction test and the daily log.
class RemindersSection extends ConsumerWidget {
  const RemindersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final now = ref.watch(clockProvider)();
    final tests = ref.watch(reactionHistoryProvider).value;
    final mine = ref.watch(checkInsProvider);
    if (profile == null) return const SizedBox.shrink();

    final dueTest =
        tests != null &&
        reactionTestDue(tests, now, RiskEngine.reactionPromptDays(profile));
    final l = context.l10n;
    final dueLog =
        !loggedToday(mine, now) &&
        now.hour >= RiskEngine.checkInNudgeHour(profile);

    return Column(
      children: [
        if (dueTest) ...[
          _PromptCard(
            icon: Icons.bolt_outlined,
            title: l.reactionPromptTitle,
            text: l.reactionPromptText,
            button: l.reactionPromptButton,
            onPressed: () => context.push('/reaction'),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
        if (dueLog) ...[
          _PromptCard(
            icon: Icons.edit_note,
            title: l.logOpenTitle,
            text: l.logOpenText,
            button: l.logEntry,
            onPressed: () => context.go('/checkin'),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
      ],
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.button,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String text;
  final String button;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.onCourse),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.section()),
                const SizedBox(height: 2),
                Text(text, style: AppText.caption()),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(onPressed: onPressed, child: Text(button)),
        ],
      ),
    );
  }
}

/// The written insight. Always says which source produced it.
class TodaysReadingCard extends ConsumerWidget {
  const TodaysReadingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insight = ref.watch(insightProvider);
    return insight.when(
      loading: () => AppCard(
        child: Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(context.l10n.readingPreparing)),
          ],
        ),
      ),
      error: (_, _) => AppCard(
        child: Text(context.l10n.readingUnavailable, style: AppText.body()),
      ),
      data: (i) =>
          i.fixedAlert ? _AlertReading(insight: i) : _Reading(insight: i),
    );
  }
}

class _AlertReading extends StatelessWidget {
  const _AlertReading({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: AppColors.alert,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.alert),
              const SizedBox(width: 8),
              Text(context.l10n.readingTitle, style: AppText.section()),
              const Spacer(),
              const StatusBadge(Status.alert),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            insight.summary,
            style: AppText.body(
              size: 15,
              weight: 600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(context.l10n.readingFixedAlertNote, style: AppText.caption()),
        ],
      ),
    );
  }
}

class _Reading extends StatelessWidget {
  const _Reading({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final action = insight.suggestedAction;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(l.readingTitle, style: AppText.section())),
              if (insight.isAiGenerated)
                _Chip(icon: Icons.auto_awesome, text: l.aiGenerated),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            insight.summary,
            style: AppText.body(size: 15, color: AppColors.textPrimary),
          ),
          if (insight.explanation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(insight.explanation, style: AppText.body()),
          ],
          if (action != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceSelected,
                borderRadius: BorderRadius.circular(AppRadii.tile),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.suggestedAction,
                    style: AppText.caption(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    action.title(l),
                    style: AppText.body(
                      size: 15,
                      weight: 600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(action.description(l), style: AppText.caption()),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            l.readingSource(insight.source.sourceLine(l)),
            style: AppText.caption(),
          ),
          if (insight.note != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(insight.note!, style: AppText.caption()),
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.onCourse),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.onCourse),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppText.body(
              size: 12,
              weight: 600,
              color: AppColors.onCourse,
            ),
          ),
        ],
      ),
    );
  }
}
