import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../l10n/l10n.dart';
import '../../models/health_models.dart';
import '../../services/history.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

class _Question {
  const _Question(this.key, this.label, this.low, this.high);

  final String key;
  final String Function(AppLocalizations) label;
  final String Function(AppLocalizations) low;
  final String Function(AppLocalizations) high;
}

final _questions = [
  _Question(
    'mood',
    (l) => l.indicatorMood,
    (l) => l.scaleLow,
    (l) => l.scaleHigh,
  ),
  _Question(
    'stress',
    (l) => l.indicatorStress,
    (l) => l.scaleCalm,
    (l) => l.scaleVeryStressed,
  ),
  _Question(
    'workload',
    (l) => l.indicatorWorkload,
    (l) => l.scaleLight,
    (l) => l.scaleOverloaded,
  ),
  _Question(
    'engagement',
    (l) => l.qEngagement,
    (l) => l.scaleBored,
    (l) => l.scaleAbsorbed,
  ),
  _Question(
    'focus',
    (l) => l.indicatorFocus,
    (l) => l.scaleScattered,
    (l) => l.scaleSharp,
  ),
  _Question(
    'connection',
    (l) => l.qConnection,
    (l) => l.scaleDistant,
    (l) => l.scaleClose,
  ),
];

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  late final Map<String, double> _values;
  final _note = TextEditingController();
  bool _lifeEvent = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    final b = profile?.baseline;
    final today = ref
        .read(checkInsProvider)
        .where((c) => dateOnly(c.date) == dateOnly(ref.read(clockProvider)()))
        .firstOrNull;
    _values = {
      'mood': today?.mood ?? b?.mood ?? 7,
      'stress': today?.stress ?? b?.stress ?? 4,
      'workload': today?.workload ?? b?.workload ?? 5,
      'engagement': today?.engagement ?? b?.engagement ?? 7,
      'focus': today?.focus ?? b?.focus ?? 7,
      'connection': today?.connection ?? b?.connection ?? 7,
    }.map((k, v) => MapEntry(k, v.roundToDouble().clamp(1, 10)));
    _lifeEvent = today?.lifeEvent ?? false;
    _note.text = today?.note ?? '';
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _log() async {
    final now = ref.read(clockProvider)();
    final note = _note.text.trim();
    await ref
        .read(checkInsProvider.notifier)
        .log(
          CheckIn(
            date: dateOnly(now),
            mood: _values['mood']!,
            stress: _values['stress']!,
            workload: _values['workload']!,
            engagement: _values['engagement']!,
            focus: _values['focus']!,
            connection: _values['connection']!,
            lifeEvent: _lifeEvent,
            note: _lifeEvent && note.isNotEmpty ? note : null,
          ),
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.l10n.checkinLogged)));
  }

  @override
  Widget build(BuildContext context) {
    final mine = ref.watch(checkInsProvider);
    final now = ref.watch(clockProvider)();
    final streak = entryStreak(mine, now);
    final done = loggedToday(mine, now);
    final wide = !LayoutMode.of(context).isPhone;

    final content = ScreenScaffold(
      children: [
        ScreenHeader(
          title: context.l10n.checkinTitle,
          subtitle: context.l10n.checkinSubtitle,
        ),
        const SizedBox(height: AppSpacing.gap),
        _StreakCard(streak: streak),
        const SizedBox(height: AppSpacing.gap),
        for (final q in _questions) ...[
          _SliderCard(
            question: q,
            value: _values[q.key]!,
            onChanged: (v) => setState(() => _values[q.key] = v),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
        _LifeEventCard(
          enabled: _lifeEvent,
          note: _note,
          onChanged: (v) => setState(() => _lifeEvent = v),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _log,
          child: Text(
            done ? context.l10n.checkinUpdate : context.l10n.logEntry,
          ),
        ),
        const SizedBox(height: 16),
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

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.checkinStreakSemantics(streak),
      child: ExcludeSemantics(
        child: AppCard(
          child: Row(
            children: [
              const Icon(
                Icons.local_fire_department_outlined,
                color: AppColors.drifting,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.checkinStreak(streak),
                      style: AppText.section(),
                    ),
                    Text(
                      context.l10n.checkinStreakNote,
                      style: AppText.caption(),
                    ),
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

class _SliderCard extends StatelessWidget {
  const _SliderCard({
    required this.question,
    required this.value,
    required this.onChanged,
  });

  final _Question question;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question.label(context.l10n),
                  style: AppText.section(),
                ),
              ),
              Text(
                '${value.round()}',
                style: AppText.section(color: AppColors.onCourse),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 1,
            max: 10,
            divisions: 9,
            label: '${value.round()}',
            semanticFormatterCallback: (v) => context.l10n.sliderSemantics(
              question.label(context.l10n),
              v.round(),
            ),
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(question.low(context.l10n), style: AppText.caption()),
              Text(question.high(context.l10n), style: AppText.caption()),
            ],
          ),
        ],
      ),
    );
  }
}

class _LifeEventCard extends StatelessWidget {
  const _LifeEventCard({
    required this.enabled,
    required this.note,
    required this.onChanged,
  });

  final bool enabled;
  final TextEditingController note;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MergeSemantics(
            child: InkWell(
              onTap: () => onChanged(!enabled),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: AppSpacing.minTapTarget,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.lifeEventTitle,
                        style: AppText.section(),
                      ),
                    ),
                    Switch(value: enabled, onChanged: onChanged),
                  ],
                ),
              ),
            ),
          ),
          Text(context.l10n.checkinOptional, style: AppText.caption()),
          if (enabled) ...[
            const SizedBox(height: 12),
            TextField(
              controller: note,
              maxLines: 3,
              maxLength: 500,
              style: AppText.body(color: AppColors.textPrimary),
              decoration: InputDecoration(
                labelText: context.l10n.checkinNoteLabel,
                helperText: context.l10n.checkinNoteHelper,
                filled: true,
                fillColor: AppColors.surfaceSelected,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.tile),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
