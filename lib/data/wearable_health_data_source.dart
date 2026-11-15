// coverage:ignore-file
import '../models/health_models.dart';
import '../models/personality_profile.dart';
import 'health_data_source.dart';

/// FUTURE WORK, NOT WIRED IN: real wearable data via the `health` package.
///
/// To enable it:
///  1. `flutter pub add health`.
///  2. iOS: add the HealthKit capability and NSHealthShareUsageDescription to Info.plist.
///  3. Android: add Health Connect permissions and the intent filter to the manifest.
///  4. Request sleep, heart rate variability, resting heart rate and active minutes,
///     then map one record per day into [DayMetrics].
///  5. Return this class from `healthDataSourceProvider` in lib/app/providers.dart.
///
/// macOS has no supported health store, so the mock source stays the default there.
class WearableHealthDataSource implements HealthDataSource {
  @override
  bool get isSample => false;

  @override
  Future<HealthSnapshot> fetch(PersonalityProfile profile) {
    throw UnimplementedError(
      'Wearable source is a stub. See the class comment.',
    );
  }
}
