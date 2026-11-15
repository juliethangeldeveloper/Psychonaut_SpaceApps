import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../l10n/l10n.dart';
import '../../models/health_models.dart';
import '../../services/format.dart';
import '../../services/history.dart';
import '../../services/risk_constants.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

enum _Phase { intro, waiting, stimulus, done }

/// 3-minute psychomotor vigilance test. Leaving before the end discards the run.
class ReactionScreen extends ConsumerStatefulWidget {
  const ReactionScreen({super.key});

  @override
  ConsumerState<ReactionScreen> createState() => _ReactionScreenState();
}

class _ReactionScreenState extends ConsumerState<ReactionScreen> {
  final _random = Random();
  final _areaFocus = FocusNode();
  var _phase = _Phase.intro;
  var _recorder = PvtRecorder();
  late Stopwatch _testWatch;
  late Stopwatch _reactionWatch;
  Timer? _stimulusTimer;
  Timer? _endTimer;
  Timer? _ticker;
  double? _lastMs;
  bool _tooSoon = false;
  ReactionResult? _result;

  @override
  void dispose() {
    _cancelTimers();
    _areaFocus.dispose();
    super.dispose();
  }

  void _cancelTimers() {
    _stimulusTimer?.cancel();
    _endTimer?.cancel();
    _ticker?.cancel();
  }

  void _start() {
    _recorder = PvtRecorder();
    _lastMs = null;
    _tooSoon = false;
    _testWatch = ref.read(stopwatchProvider)()..start();
    _endTimer = Timer(
      const Duration(seconds: RiskConstants.testSeconds),
      _finish,
    );
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
    _scheduleStimulus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _areaFocus.requestFocus();
    });
  }

  /// The next stimulus appears after a random gap of 2 to 5 seconds.
  void _scheduleStimulus() {
    _stimulusTimer?.cancel();
    const min = RiskConstants.minStimulusGapMs;
    const max = RiskConstants.maxStimulusGapMs;
    _stimulusTimer = Timer(
      Duration(milliseconds: min + _random.nextInt(max - min + 1)),
      () {
        _reactionWatch = ref.read(stopwatchProvider)()..start();
        setState(() {
          _phase = _Phase.stimulus;
          _tooSoon = false;
        });
      },
    );
    setState(() => _phase = _Phase.waiting);
  }

  void _tap() {
    if (_phase == _Phase.stimulus) {
      _lastMs = _reactionWatch.elapsedMicroseconds / 1000;
      _recorder.recordReaction(_lastMs!);
      _tooSoon = false;
      _scheduleStimulus();
    } else if (_phase == _Phase.waiting) {
      _recorder.recordFalseStart();
      _tooSoon = true;
      _scheduleStimulus();
    }
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    final isTapKey =
        event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.enter;
    if (event is! KeyDownEvent || !isTapKey) return KeyEventResult.ignored;
    _tap();
    return KeyEventResult.handled;
  }

  Future<void> _finish() async {
    _cancelTimers();
    // A run with no responses has no mean, so it is not saved.
    final result = _recorder.trials == 0
        ? null
        : _recorder.toResult(ref.read(clockProvider)());
    setState(() {
      _phase = _Phase.done;
      _result = result;
    });
    if (result != null) {
      await ref.read(reactionsProvider.notifier).add(result);
    }
  }

  void _close() => context.canPop() ? context.pop() : context.go('/home');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: context.l10n.back,
          icon: const Icon(Icons.arrow_back),
          onPressed: _close,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: switch (_phase) {
            _Phase.intro => _intro(context),
            _Phase.done => _done(context),
            _ => _running(context),
          },
        ),
      ),
    );
  }

  Widget _intro(BuildContext context) {
    final l = context.l10n;
    return ScreenScaffold(
      children: [
        ScreenHeader(title: l.reactionTitle),
        const SizedBox(height: AppSpacing.gap),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.reactionIntro, style: AppText.body(size: 15)),
              const SizedBox(height: 8),
              Text(l.reactionKeyboardHint, style: AppText.caption()),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(onPressed: _start, child: Text(l.reactionPromptButton)),
        const SizedBox(height: 16),
        const DisclaimerLine(),
      ],
    );
  }

  Widget _running(BuildContext context) {
    final l = context.l10n;
    final stimulus = _phase == _Phase.stimulus;
    const total = RiskConstants.testSeconds;
    final left = (total - _testWatch.elapsed.inSeconds).clamp(0, total);
    final time = '${left ~/ 60}:${(left % 60).toString().padLeft(2, '0')}';
    final signal = stimulus ? l.reactionTapNow : l.reactionWait;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.reactionTimeLeft(time), style: AppText.caption()),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 1 - left / total,
                minHeight: 6,
                backgroundColor: AppColors.border,
              ),
            ),
            const SizedBox(height: AppSpacing.gap),
            Expanded(
              child: Focus(
                focusNode: _areaFocus,
                onKeyEvent: _onKey,
                child: Semantics(
                  button: true,
                  liveRegion: true,
                  label: signal,
                  onTap: _tap,
                  child: ExcludeSemantics(
                    // Pointer down, not tap up, so the time is not inflated.
                    child: Listener(
                      behavior: HitTestBehavior.opaque,
                      onPointerDown: (_) => _tap(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: stimulus
                              ? AppColors.surfaceSelected
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadii.card),
                          border: Border.all(
                            color: stimulus
                                ? AppColors.onCourse
                                : AppColors.border,
                            width: stimulus ? 3 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              signal,
                              textAlign: TextAlign.center,
                              style: AppText.heading().copyWith(fontSize: 40),
                            ),
                            const SizedBox(height: 12),
                            if (_tooSoon)
                              Text(
                                l.reactionTooSoon,
                                style: AppText.body(color: AppColors.drifting),
                              )
                            else if (_lastMs != null && !stimulus)
                              Text(
                                formatValue(l, Indicator.reaction, _lastMs!),
                                style: AppText.section(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.gap),
            Text(l.reactionDiscardHint, style: AppText.caption()),
          ],
        ),
      ),
    );
  }

  Widget _done(BuildContext context) {
    final l = context.l10n;
    final r = _result;
    return ScreenScaffold(
      children: [
        ScreenHeader(title: l.reactionDoneTitle),
        const SizedBox(height: AppSpacing.gap),
        AppCard(
          child: r == null
              ? Text(l.reactionNoResponses, style: AppText.body())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ResultRow(
                      l.reactionMean,
                      formatValue(l, Indicator.reaction, r.meanMs),
                    ),
                    _ResultRow(l.reactionResponses, '${r.trials}'),
                    _ResultRow(l.reactionLapses, '${r.lapses}'),
                    _ResultRow(l.reactionFalseStarts, '${r.falseStarts}'),
                    const SizedBox(height: 6),
                    Text(l.reactionSaved, style: AppText.caption()),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        FilledButton(onPressed: _close, child: Text(l.reactionDone)),
        const SizedBox(height: 16),
        const DisclaimerLine(),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.body())),
          Text(value, style: AppText.section()),
        ],
      ),
    );
  }
}
