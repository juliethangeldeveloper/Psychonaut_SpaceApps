import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../data/profile_repository.dart';
import '../../l10n/l10n.dart';
import '../../models/action_id.dart';
import '../../models/personality_profile.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';
import 'mini_ipip.dart';

const _itemsPerPage = 5;
const _itemPages = 4;
const _lastStep =
    1 + _itemPages + 3; // intro, items, locus, tone, actions, review

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _step = 0;
  final _name = TextEditingController();
  final _role = TextEditingController();
  final List<int?> _answers = List.filled(miniIpipItems.length, null);
  LocusOfControl? _locus;
  Tone? _tone;
  List<ActionId> _actions = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(profileProvider);
    if (existing != null) {
      _name.text = existing.displayName;
      _role.text = existing.role;
      _locus = existing.locusOfControl;
      _tone = existing.preferences.tone;
      _actions = [...existing.preferences.preferredActions];
    }
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _role.dispose();
    super.dispose();
  }

  int get _firstItemStep => 1;
  int get _locusStep => 1 + _itemPages;
  int get _toneStep => _locusStep + 1;
  int get _actionsStep => _toneStep + 1;
  int get _reviewStep => _actionsStep + 1;

  bool get _canContinue {
    if (_step == 0) return _name.text.trim().isNotEmpty;
    if (_step >= _firstItemStep && _step < _locusStep) {
      final start = (_step - _firstItemStep) * _itemsPerPage;
      return _answers
          .sublist(start, start + _itemsPerPage)
          .every((a) => a != null);
    }
    if (_step == _locusStep) return _locus != null;
    if (_step == _toneStep) return _tone != null;
    if (_step == _actionsStep) return _actions.isNotEmpty;
    return true;
  }

  Future<void> _finish() async {
    setState(() => _saving = true);
    final profile = buildProfile(
      displayName: _name.text,
      role: _role.text,
      defaultRole: context.l10n.roleDefault,
      answers: _answers.cast<int>(),
      locus: _locus!,
      tone: _tone!,
      preferredActions: _actions,
    );
    await ref.read(profileProvider.notifier).set(profile);
    if (mounted) context.go('/home');
  }

  Future<void> _useSample(String id) async {
    final profile = await loadBundledProfile(id);
    await ref.read(profileProvider.notifier).set(profile);
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = ref.watch(profileProvider) != null;
    final last = _step == _reviewStep;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        label: context.l10n.onbStep(_step + 1, _lastStep + 1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: (_step + 1) / (_lastStep + 1),
                            minHeight: 6,
                            backgroundColor: AppColors.border,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.onbStep(_step + 1, _lastStep + 1),
                        style: AppText.caption(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.screenPadding),
                    child: _body(hasProfile),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: [
                      if (_step > 0) ...[
                        OutlinedButton(
                          onPressed: () => setState(() => _step--),
                          child: Text(context.l10n.back),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: FilledButton(
                          onPressed: !_canContinue || _saving
                              ? null
                              : last
                              ? _finish
                              : () => setState(() => _step++),
                          child: Text(
                            last
                                ? context.l10n.onbCreate
                                : context.l10n.onbNext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(bool hasProfile) {
    if (_step == 0) return _intro(hasProfile);
    if (_step < _locusStep) return _items();
    if (_step == _locusStep) return _locusPage();
    if (_step == _toneStep) return _tonePage();
    if (_step == _actionsStep) return _actionsPage();
    return _review();
  }

  Widget _intro(bool hasProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenHeader(
          title: context.l10n.onbWelcome,
          subtitle: context.l10n.onbWelcomeSub,
        ),
        const SizedBox(height: 12),
        Text(context.l10n.onbIntro, style: AppText.body()),
        const SizedBox(height: 16),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: _decoration(context.l10n.onbName),
          style: AppText.body(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _role,
          textCapitalization: TextCapitalization.words,
          decoration: _decoration(context.l10n.onbRole),
          style: AppText.body(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
        const DisclaimerLine(),
        const SizedBox(height: 20),
        Text(context.l10n.onbExploring, style: AppText.section()),
        const SizedBox(height: 4),
        Text(context.l10n.onbSampleHint, style: AppText.caption()),
        const SizedBox(height: 4),
        for (final p in bundledProfiles)
          TextButton(
            onPressed: () => _useSample(p.id),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(p.label),
            ),
          ),
        if (hasProfile)
          TextButton(
            onPressed: () => context.go('/home'),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(context.l10n.onbCancel),
            ),
          ),
      ],
    );
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      borderSide: const BorderSide(color: AppColors.border),
    ),
  );

  Widget _items() {
    final page = _step - _firstItemStep;
    final start = page * _itemsPerPage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.onbAboutYou, style: AppText.heading()),
        const SizedBox(height: 4),
        Text(
          context.l10n.onbItemsHint(page + 1, _itemPages),
          style: AppText.caption(),
        ),
        const SizedBox(height: 12),
        for (var i = start; i < start + _itemsPerPage; i++) ...[
          AppCard(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.ipipItem(i),
                  style: AppText.body(
                    size: 15,
                    weight: 600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                _Likert(
                  value: _answers[i],
                  onChanged: (v) => setState(() => _answers[i] = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gap),
        ],
      ],
    );
  }

  Widget _locusPage() {
    final l = context.l10n;
    final choices = [
      (
        LocusOfControl.internal,
        l.onbLocusInternalTitle,
        l.onbLocusInternalText,
      ),
      (LocusOfControl.mixed, l.onbLocusMixedTitle, l.onbLocusMixedText),
      (
        LocusOfControl.external,
        l.onbLocusExternalTitle,
        l.onbLocusExternalText,
      ),
    ];
    return _choicePage(
      title: context.l10n.onbLocusTitle,
      subtitle: context.l10n.onbLocusSub,
      children: [
        for (final c in choices)
          _ChoiceCard(
            title: c.$2,
            text: c.$3,
            selected: _locus == c.$1,
            onTap: () => setState(() => _locus = c.$1),
          ),
      ],
    );
  }

  Widget _tonePage() {
    return _choicePage(
      title: context.l10n.onbToneTitle,
      subtitle: context.l10n.onbToneSub,
      children: [
        _ChoiceCard(
          title: context.l10n.toneDirect,
          text: context.l10n.onbToneDirectEx,
          selected: _tone == Tone.direct,
          onTap: () => setState(() => _tone = Tone.direct),
        ),
        _ChoiceCard(
          title: context.l10n.toneGentle,
          text: context.l10n.onbToneGentleEx,
          selected: _tone == Tone.gentle,
          onTap: () => setState(() => _tone = Tone.gentle),
        ),
      ],
    );
  }

  Widget _actionsPage() {
    return _choicePage(
      title: context.l10n.onbActionsTitle,
      subtitle: context.l10n.onbActionsSub,
      children: [
        for (final a in ActionId.values)
          _ChoiceCard(
            title: a.title(context.l10n),
            text: a.description(context.l10n),
            selected: _actions.contains(a),
            badge: _actions.contains(a) ? '${_actions.indexOf(a) + 1}' : null,
            onTap: () => setState(() {
              _actions = _actions.contains(a)
                  ? (List.of(_actions)..remove(a))
                  : [..._actions, a];
            }),
          ),
      ],
    );
  }

  Widget _choicePage({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppText.heading()),
        const SizedBox(height: 4),
        Text(subtitle, style: AppText.caption()),
        const SizedBox(height: 12),
        for (final c in children) ...[
          c,
          const SizedBox(height: AppSpacing.gap),
        ],
      ],
    );
  }

  Widget _review() {
    final big = scoreMiniIpip(_answers.cast<int>());
    final l = context.l10n;
    final traits = [
      (l.traitOpenness, big.openness),
      (l.traitConscientiousness, big.conscientiousness),
      (l.traitExtraversion, big.extraversion),
      (l.traitAgreeableness, big.agreeableness),
      (l.traitEmotionalStability, big.emotionalStability),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.onbYourProfile, style: AppText.heading()),
        const SizedBox(height: 4),
        Text(
          l.dotJoin2(
            _name.text.trim(),
            _role.text.trim().isEmpty ? l.roleDefault : _role.text.trim(),
          ),
          style: AppText.caption(),
        ),
        const SizedBox(height: 12),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.onbTraits, style: AppText.section()),
              const SizedBox(height: 10),
              for (final t in traits) TraitBar(label: t.$1, value: t.$2),
              const SizedBox(height: 4),
              Text(l.onbTraitsNote, style: AppText.caption()),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.gap),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.onbPrefs, style: AppText.section()),
              const SizedBox(height: 6),
              Text(
                l.labelValue(l.profileAdviceFraming, _locus!.framing(l)),
                style: AppText.body(),
              ),
              Text(
                l.labelValue(l.profileTone, _tone!.label(l)),
                style: AppText.body(),
              ),
              Text(
                l.labelValue(
                  l.onbActionsLabel,
                  _actions.map((a) => a.title(l)).join(', '),
                ),
                style: AppText.body(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.gap),
        const DisclaimerLine(),
      ],
    );
  }
}

class _Likert extends StatelessWidget {
  const _Likert({required this.value, required this.onChanged});

  final int? value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (var n = 1; n <= 5; n++)
              Expanded(
                child: Semantics(
                  button: true,
                  selected: value == n,
                  label: context.l10n.ipipAnswerSemantics(
                    '$n',
                    context.l10n.ipipAnswer(n),
                  ),
                  child: ExcludeSemantics(
                    child: InkResponse(
                      onTap: () => onChanged(n),
                      radius: 28,
                      child: SizedBox(
                        height: AppSpacing.minTapTarget,
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: value == n
                                  ? AppColors.onCourse
                                  : AppColors.surfaceSelected,
                              border: Border.all(
                                color: value == n
                                    ? AppColors.onCourse
                                    : AppColors.border,
                              ),
                            ),
                            child: Text(
                              '$n',
                              style: AppText.body(
                                size: 15,
                                weight: 600,
                                color: value == n
                                    ? AppColors.background
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.l10n.ipipAnswer1, style: AppText.caption()),
            Text(context.l10n.ipipAnswer5, style: AppText.caption()),
          ],
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.title,
    required this.text,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String text;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: context.l10n.actionSemantics(title, text),
      child: ExcludeSemantics(
        child: AppCard(
          selected: selected,
          borderColor: selected ? AppColors.onCourse : null,
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? AppColors.onCourse : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppText.body(
                        size: 15,
                        weight: 600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(text, style: AppText.caption()),
                  ],
                ),
              ),
              if (badge != null)
                Text(badge!, style: AppText.section(color: AppColors.onCourse)),
            ],
          ),
        ),
      ),
    );
  }
}
