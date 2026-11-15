import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/insight.dart';
import 'insight_service.dart';

/// Picks the service, enforces the safety rules, and falls back to rule-based on any failure.
class InsightCoordinator {
  const InsightCoordinator({
    required this.ruleBased,
    this.onBoard,
    this.cloud,
    this.timeout = const Duration(seconds: 8),
    this.onBoardTimeout = const Duration(seconds: 60),
  });

  final InsightService ruleBased;
  final InsightService? onBoard;
  final InsightService? cloud;
  final Duration timeout;

  /// Design assumption: a small local model is slower than a cloud one.
  final Duration onBoardTimeout;

  Future<Insight> resolve(InsightContext context, AiSource selected) async {
    // At alert level the text is fixed and never generated.
    if (context.assessment.overall.isAlert) {
      return Insight.alert(
        context.l10n.alertMessage,
        context.profile.preferences.tone,
      );
    }
    if (selected == AiSource.ruleBased) return ruleBased.generate(context);

    final local = selected == AiSource.onBoard;
    final service = local ? onBoard : cloud;
    try {
      if (service == null) throw StateError('${selected.name} is not set up');
      final insight = await service
          .generate(context)
          .timeout(local ? onBoardTimeout : timeout);
      _check(insight);
      return insight;
    } catch (_) {
      final fallback = await ruleBased.generate(context);
      return fallback.withNote(
        context.l10n.sourceUnavailableNote(selected.label(context.l10n)),
      );
    }
  }

  void _check(Insight insight) {
    if (insight.fixedAlert) throw const FormatException('Unexpected alert');
    if (insight.suggestedAction == null) {
      throw const FormatException('Missing action');
    }
    if (!InsightSafety.isSafe(insight.summary) ||
        !InsightSafety.isSafe(insight.explanation)) {
      throw const FormatException('Unsafe text');
    }
  }
}
