import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../l10n/l10n.dart';
import '../../models/app_settings.dart';
import '../../models/mission.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

class SettingsSection extends ConsumerWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(missionDayProvider);
    final source = ref.watch(settingsProvider.select((s) => s.aiSource));
    final notifier = ref.read(settingsProvider.notifier);
    final phase = MissionPhase.forDay(day);
    final l = context.l10n;
    final language = ref.watch(settingsProvider.select((s) => s.languageCode));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.settingsMissionDay, style: AppText.section()),
        const SizedBox(height: AppSpacing.gap),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton.outlined(
                    tooltip: l.settingsPrevDay,
                    constraints: const BoxConstraints(
                      minWidth: AppSpacing.minTapTarget,
                      minHeight: AppSpacing.minTapTarget,
                    ),
                    onPressed: day > 1
                        ? () => notifier.setMissionDay(day - 1)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Semantics(
                      liveRegion: true,
                      label: l.settingsMissionDaySemantics(day, phase.label(l)),
                      child: ExcludeSemantics(
                        child: Column(
                          children: [
                            Text(l.settingsDay(day), style: AppText.heading()),
                            Text(phase.label(l), style: AppText.caption()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton.outlined(
                    tooltip: l.settingsNextDay,
                    constraints: const BoxConstraints(
                      minWidth: AppSpacing.minTapTarget,
                      minHeight: AppSpacing.minTapTarget,
                    ),
                    onPressed: () => notifier.setMissionDay(day + 1),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(phase.note(l), style: AppText.caption()),
              const SizedBox(height: 6),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (final d in const [1, 60, 150, 151])
                      ActionChip(
                        label: Text(l.settingsDay(d)),
                        onPressed: () => notifier.setMissionDay(d),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(l.settingsAiSource, style: AppText.section()),
        const SizedBox(height: 4),
        Text(l.settingsAiHint, style: AppText.caption()),
        const SizedBox(height: AppSpacing.gap),
        for (final s in AiSource.values) ...[
          Semantics(
            button: true,
            selected: s == source,
            label: l.actionSemantics(s.label(l), s.description(l)),
            child: ExcludeSemantics(
              child: AppCard(
                selected: s == source,
                borderColor: s == source ? AppColors.onCourse : null,
                onTap: () => notifier.setAiSource(s),
                child: Row(
                  children: [
                    Icon(
                      s == source
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: s == source
                          ? AppColors.onCourse
                          : AppColors.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.label(l),
                            style: AppText.body(
                              size: 15,
                              weight: 600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(s.description(l), style: AppText.caption()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
        const SizedBox(height: 8),
        Text(l.settingsLanguage, style: AppText.section()),
        const SizedBox(height: 4),
        Text(l.settingsLanguageHint, style: AppText.caption()),
        const SizedBox(height: AppSpacing.gap),
        for (final option in _languages) ...[
          _LanguageCard(
            title: option.$2 ?? l.languageDevice,
            selected: option.$1 == language,
            onTap: () => notifier.setLanguage(option.$1),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
      ],
    );
  }
}

/// Language names are shown in their own language so anyone can find theirs.
const _languages = <(String?, String?)>[
  (null, null),
  ('en', 'English'),
  ('es', 'Español'),
  ('fr', 'Français'),
  ('ja', '日本語'),
  ('ar', 'العربية'),
];

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: title,
      child: ExcludeSemantics(
        child: AppCard(
          selected: selected,
          borderColor: selected ? AppColors.onCourse : null,
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? AppColors.onCourse : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppText.body(
                    size: 15,
                    weight: 600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
