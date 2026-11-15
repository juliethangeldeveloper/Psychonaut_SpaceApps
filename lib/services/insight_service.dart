import '../l10n/l10n.dart';
import '../models/health_models.dart';
import '../models/insight.dart';
import '../models/personality_profile.dart';
import '../models/risk_assessment.dart';
import '../models/app_settings.dart';

/// Everything an insight service may look at. Private notes are never included.
class InsightContext {
  const InsightContext({
    required this.profile,
    required this.assessment,
    required this.metrics,
    required this.checkIns,
    required this.missionDay,
    required this.l10n,
  });

  final PersonalityProfile profile;
  final RiskAssessment assessment;

  /// Last 14 days.
  final List<DayMetrics> metrics;
  final List<CheckIn> checkIns;
  final int missionDay;

  /// Language of the generated text.
  final AppLocalizations l10n;
}

abstract class InsightService {
  AiSource get source;

  /// Throws if it cannot produce a valid insight, so the caller can fall back.
  Future<Insight> generate(InsightContext context);
}

/// Text rules shared by every service. Generated text that trips them is rejected.
abstract final class InsightSafety {
  /// Words that name a condition or give medication advice. Design assumption: a small
  /// deny list is a backstop; the system prompt is the main control.
  static final _banned = RegExp(
    r'\b(depress\w*|anxiety|anxious disorder|bipolar|schizo\w*|ptsd|post-traumatic|'
    r'disorder|diagnos\w*|clinical|psychosis|psychotic|insomnia|burnout|mental illness|'
    r'medicat\w*|medicine|prescri\w*|dose|dosage|\d+\s?mg|antidepress\w*|'
    r'sedative\w*|melatonin|ssri|benzodiazepine\w*|ibuprofen|caffeine pill\w*)\b',
    caseSensitive: false,
  );

  /// The same idea for Spanish, French, Japanese and Arabic. Machine-drafted; needs native review.
  static final _bannedOther = RegExp(
    'depresi|ansiedad|trastorno|diagn[oó]stic|medicament|medicaci|dosis|'
    'dépression|anxiété|médicament|posologie|'
    'うつ|障害|診断|服用|投薬|処方|'
    'اكتئاب|اضطراب|تشخيص|دواء|أدوية|جرعة',
    caseSensitive: false,
  );

  static bool isSafe(String text) =>
      !_banned.hasMatch(text) && !_bannedOther.hasMatch(text);
}
