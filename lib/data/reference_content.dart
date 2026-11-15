import '../models/health_models.dart';

enum NasaRisk { behavioral, teamwork, sleep }

enum NasaHazard { isolation, distance }

/// Which NASA risk and hazard each indicator maps to. The wording lives in the ARB files.
class IndicatorReference {
  const IndicatorReference({required this.risk, required this.hazards});

  final NasaRisk risk;
  final List<NasaHazard> hazards;
}

abstract final class ReferenceContent {
  static const _byIndicator = <Indicator, IndicatorReference>{
    Indicator.mood: IndicatorReference(
      risk: NasaRisk.behavioral,
      hazards: [NasaHazard.isolation],
    ),
    Indicator.stress: IndicatorReference(
      risk: NasaRisk.behavioral,
      hazards: [NasaHazard.isolation],
    ),
    Indicator.sleep: IndicatorReference(
      risk: NasaRisk.sleep,
      hazards: [NasaHazard.isolation],
    ),
    Indicator.focus: IndicatorReference(
      risk: NasaRisk.sleep,
      hazards: [NasaHazard.isolation],
    ),
    Indicator.motivation: IndicatorReference(
      risk: NasaRisk.behavioral,
      hazards: [NasaHazard.isolation, NasaHazard.distance],
    ),
    Indicator.connection: IndicatorReference(
      risk: NasaRisk.teamwork,
      hazards: [NasaHazard.isolation, NasaHazard.distance],
    ),
    Indicator.workload: IndicatorReference(
      risk: NasaRisk.sleep,
      hazards: [NasaHazard.distance],
    ),
    Indicator.reaction: IndicatorReference(
      risk: NasaRisk.sleep,
      hazards: [NasaHazard.isolation],
    ),
  };

  static IndicatorReference of(Indicator i) => _byIndicator[i]!;
}
