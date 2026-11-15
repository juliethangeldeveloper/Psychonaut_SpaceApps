import '../models/health_models.dart';
import '../models/personality_profile.dart';

/// 14 days ending today, oldest first. Check-ins here are seed history only;
/// entries the user logs on the device are stored separately.
class HealthSnapshot {
  const HealthSnapshot({
    required this.metrics,
    required this.reactions,
    required this.checkIns,
  });

  final List<DayMetrics> metrics;
  final List<ReactionResult> reactions;
  final List<CheckIn> checkIns;
}

/// Source of body data (sleep, HRV, resting heart rate, activity) and history.
abstract class HealthDataSource {
  /// True when the numbers are bundled demo data, not a real device.
  bool get isSample;

  Future<HealthSnapshot> fetch(PersonalityProfile profile);
}
