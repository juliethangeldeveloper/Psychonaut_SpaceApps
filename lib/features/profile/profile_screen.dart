import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../data/profile_repository.dart';
import '../../l10n/l10n.dart';
import '../../models/personality_profile.dart';
import '../../services/format.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';
import 'import_section.dart';
import 'settings_section.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: l.back,
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ScreenScaffold(
            children: [
              ScreenHeader(title: l.profileTitle, subtitle: l.profileSubtitle),
              const SizedBox(height: AppSpacing.gap),
              if (profile != null) ...[
                ProfileCard(profile: profile),
                const SizedBox(height: AppSpacing.gap),
                OutlinedButton.icon(
                  onPressed: () => context.push('/onboarding'),
                  icon: const Icon(Icons.quiz_outlined),
                  label: Text(l.profileRetake),
                ),
                const SizedBox(height: 20),
              ],
              Text(l.profileSamples, style: AppText.section()),
              const SizedBox(height: 4),
              Text(l.profileSamplesHint, style: AppText.caption()),
              const SizedBox(height: AppSpacing.gap),
              SampleSwitcher(currentId: profile?.id),
              const SizedBox(height: 20),
              const SettingsSection(),
              const SizedBox(height: 8),
              const ImportSection(),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => context.push('/science'),
                icon: const Icon(Icons.science_outlined),
                label: Text(l.scienceTitle),
              ),
              const SizedBox(height: 16),
              const DisclaimerLine(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});

  final PersonalityProfile profile;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = profile;
    final b = p.bigFive;
    final f = p.facets;
    final bl = p.baseline;
    String n(double v) =>
        formatNumber(l, v, decimals: v == v.roundToDouble() ? 0 : 1);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(p.displayName, style: AppText.heading()),
          const SizedBox(height: 2),
          Text(l.dotJoin2(p.role, p.source.label(l)), style: AppText.caption()),
          const SizedBox(height: 14),
          TraitBar(label: l.traitOpenness, value: b.openness),
          TraitBar(label: l.traitConscientiousness, value: b.conscientiousness),
          TraitBar(label: l.traitExtraversion, value: b.extraversion),
          TraitBar(label: l.traitAgreeableness, value: b.agreeableness),
          TraitBar(
            label: l.traitEmotionalStability,
            value: b.emotionalStability,
          ),
          TraitBar(label: l.traitBoredom, value: p.boredomProneness),
          if (f != null) ...[
            const SizedBox(height: 4),
            Text(l.facetsTitle, style: AppText.section()),
            const SizedBox(height: 8),
            TraitBar(label: l.facetExcitement, value: f.excitementSeeking),
            TraitBar(label: l.facetGregariousness, value: f.gregariousness),
            TraitBar(label: l.facetVulnerability, value: f.vulnerability),
            TraitBar(label: l.facetSelfDiscipline, value: f.selfDiscipline),
          ],
          const Divider(height: 24),
          _Fact(l.profileAdviceFraming, p.locusOfControl.framing(l)),
          _Fact(l.profileCoping, p.copingStyle.label(l)),
          _Fact(l.profileTone, p.preferences.tone.label(l)),
          _Fact(
            l.profilePreferred,
            p.preferences.preferredActions.map((a) => a.title(l)).join(', '),
          ),
          const Divider(height: 24),
          Text(l.profileBaseline, style: AppText.section()),
          const SizedBox(height: 6),
          _Fact(l.indicatorSleep, l.unitHours(n(bl.sleepHours))),
          _Fact(
            l.dotJoin3(l.indicatorMood, l.indicatorStress, l.indicatorWorkload),
            l.dotJoin3(n(bl.mood), n(bl.stress), n(bl.workload)),
          ),
          _Fact(
            l.dotJoin3(l.qEngagement, l.indicatorFocus, l.indicatorConnection),
            l.dotJoin3(n(bl.engagement), n(bl.focus), n(bl.connection)),
          ),
          _Fact(l.indicatorReaction, l.unitMs(n(bl.reactionMs))),
          _Fact(
            l.dotJoin2(l.restingHeartRate, l.hrvLabel),
            l.dotJoin2(l.unitBpm(n(bl.restingHeartRate)), l.unitMs(n(bl.hrv))),
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: AppText.caption())),
          Expanded(flex: 5, child: Text(value, style: AppText.body())),
        ],
      ),
    );
  }
}

class SampleSwitcher extends ConsumerWidget {
  const SampleSwitcher({super.key, required this.currentId});

  final String? currentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> load(BundledProfile p) async {
      final profile = await loadBundledProfile(p.id);
      await ref.read(profileProvider.notifier).set(profile);
      ref.read(selectedIndicatorProvider.notifier).select(null);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.profileLoaded(profile.displayName)),
          ),
        );
      }
    }

    return Column(
      children: [
        for (final p in bundledProfiles) ...[
          Semantics(
            button: true,
            selected: p.id == currentId,
            label: p.id == currentId
                ? context.l10n.profileCurrentSemantics(p.label)
                : p.label,
            child: ExcludeSemantics(
              child: AppCard(
                selected: p.id == currentId,
                borderColor: p.id == currentId ? AppColors.onCourse : null,
                onTap: () => load(p),
                child: Row(
                  children: [
                    Icon(
                      p.id == currentId
                          ? Icons.check_circle
                          : Icons.person_outline,
                      color: p.id == currentId
                          ? AppColors.onCourse
                          : AppColors.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        p.label,
                        style: AppText.body(
                          size: 15,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (p.id == currentId)
                      Text(
                        context.l10n.profileCurrent,
                        style: AppText.caption(color: AppColors.onCourse),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
      ],
    );
  }
}
