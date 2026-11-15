import 'action_id.dart';
import 'app_settings.dart';
import 'personality_profile.dart';

class Insight {
  const Insight({
    required this.summary,
    required this.explanation,
    required this.suggestedAction,
    required this.tone,
    required this.source,
    this.fixedAlert = false,
    this.note,
  });

  /// [message] is the fixed alert text in the reader's language. It is never generated.
  factory Insight.alert(String message, Tone tone) => Insight(
    summary: message,
    explanation: '',
    suggestedAction: null,
    tone: tone,
    source: AiSource.ruleBased,
    fixedAlert: true,
  );

  /// Two sentences.
  final String summary;
  final String explanation;
  final ActionId? suggestedAction;
  final Tone tone;

  /// What actually produced this text, even after a fallback.
  final AiSource source;

  /// True for the fixed safety message. Never AI-generated.
  final bool fixedAlert;

  /// For example "Cloud model unavailable, used rule-based."
  final String? note;

  bool get isAiGenerated =>
      !fixedAlert && (source == AiSource.cloud || source == AiSource.onBoard);

  Insight withNote(String note) => Insight(
    summary: summary,
    explanation: explanation,
    suggestedAction: suggestedAction,
    tone: tone,
    source: source,
    fixedAlert: fixedAlert,
    note: note,
  );
}
