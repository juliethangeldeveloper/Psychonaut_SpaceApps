import 'action_id.dart';

enum LocusOfControl {
  internal,
  mixed,
  external;

  static LocusOfControl parse(Object? v) =>
      _byName(values, v, 'locusOfControl');
}

enum CopingStyle {
  problemFocused('problem_focused'),
  emotionFocused('emotion_focused'),
  avoidant('avoidant');

  const CopingStyle(this.id);
  final String id;

  static CopingStyle parse(Object? v) {
    for (final c in values) {
      if (c.id == v) return c;
    }
    throw FormatException('Invalid copingStyle: $v');
  }
}

enum Tone {
  direct,
  gentle;

  static Tone parse(Object? v) => _byName(values, v, 'tone');
}

enum ProfileSource {
  miniIpip('mini-ipip'),
  ipipNeo120('ipip-neo-120'),
  imported('imported');

  const ProfileSource(this.id);
  final String id;

  static ProfileSource parse(Object? v) {
    if (v == null) return ProfileSource.imported;
    for (final s in values) {
      if (s.id == v) return s;
    }
    throw FormatException('Invalid source: $v');
  }
}

T _byName<T extends Enum>(List<T> values, Object? v, String field) {
  for (final e in values) {
    if (e.name == v) return e;
  }
  throw FormatException('Invalid $field: $v');
}

double _number(
  Map<String, dynamic> json,
  String key, {
  required num min,
  required num max,
  String? path,
}) {
  final v = json[key];
  final label = path == null ? key : '$path.$key';
  if (v is! num) throw FormatException('$label must be a number');
  if (v < min || v > max) {
    throw FormatException('$label must be between $min and $max');
  }
  return v.toDouble();
}

Map<String, dynamic> _map(Object? v, String name) {
  if (v is Map<String, dynamic>) return v;
  throw FormatException('$name must be an object');
}

String _string(Map<String, dynamic> json, String key) {
  final v = json[key];
  if (v is! String || v.trim().isEmpty) {
    throw FormatException('$key must be a non-empty string');
  }
  return v;
}

class BigFive {
  const BigFive({
    required this.openness,
    required this.conscientiousness,
    required this.extraversion,
    required this.agreeableness,
    required this.emotionalStability,
  });

  final double openness;
  final double conscientiousness;
  final double extraversion;
  final double agreeableness;
  final double emotionalStability;

  factory BigFive.fromJson(Map<String, dynamic> json) {
    double n(String k) => _number(json, k, min: 0, max: 100, path: 'bigFive');
    return BigFive(
      openness: n('openness'),
      conscientiousness: n('conscientiousness'),
      extraversion: n('extraversion'),
      agreeableness: n('agreeableness'),
      emotionalStability: n('emotionalStability'),
    );
  }

  Map<String, dynamic> toJson() => {
    'openness': openness,
    'conscientiousness': conscientiousness,
    'extraversion': extraversion,
    'agreeableness': agreeableness,
    'emotionalStability': emotionalStability,
  };
}

/// Lower-level facets. Only the full IPIP-NEO-120 can produce these.
class Facets {
  const Facets({
    required this.excitementSeeking,
    required this.gregariousness,
    required this.vulnerability,
    required this.selfDiscipline,
  });

  final double excitementSeeking;
  final double gregariousness;
  final double vulnerability;
  final double selfDiscipline;

  factory Facets.fromJson(Map<String, dynamic> json) {
    double n(String k) => _number(json, k, min: 0, max: 100, path: 'facets');
    return Facets(
      excitementSeeking: n('excitementSeeking'),
      gregariousness: n('gregariousness'),
      vulnerability: n('vulnerability'),
      selfDiscipline: n('selfDiscipline'),
    );
  }

  Map<String, dynamic> toJson() => {
    'excitementSeeking': excitementSeeking,
    'gregariousness': gregariousness,
    'vulnerability': vulnerability,
    'selfDiscipline': selfDiscipline,
  };
}

class Baseline {
  const Baseline({
    required this.sleepHours,
    required this.mood,
    required this.stress,
    required this.workload,
    required this.engagement,
    required this.focus,
    required this.connection,
    required this.reactionMs,
    required this.restingHeartRate,
    required this.hrv,
  });

  final double sleepHours;
  final double mood;
  final double stress;
  final double workload;
  final double engagement;
  final double focus;
  final double connection;
  final double reactionMs;
  final double restingHeartRate;
  final double hrv;

  /// Population starting point for people who have not collected 30 days yet.
  static const defaults = Baseline(
    sleepHours: 7.5,
    mood: 7,
    stress: 4,
    workload: 5,
    engagement: 7,
    focus: 7,
    connection: 7,
    reactionMs: 250,
    restingHeartRate: 62,
    hrv: 55,
  );

  factory Baseline.fromJson(Map<String, dynamic> json) {
    double n(String k, double min, double max) =>
        _number(json, k, min: min, max: max, path: 'baseline');
    return Baseline(
      sleepHours: n('sleepHours', 0, 24),
      mood: n('mood', 1, 10),
      stress: n('stress', 1, 10),
      workload: n('workload', 1, 10),
      engagement: n('engagement', 1, 10),
      focus: n('focus', 1, 10),
      connection: n('connection', 1, 10),
      reactionMs: n('reactionMs', 100, 1000),
      restingHeartRate: n('restingHeartRate', 25, 220),
      hrv: n('hrv', 1, 300),
    );
  }

  Map<String, dynamic> toJson() => {
    'sleepHours': sleepHours,
    'mood': mood,
    'stress': stress,
    'workload': workload,
    'engagement': engagement,
    'focus': focus,
    'connection': connection,
    'reactionMs': reactionMs,
    'restingHeartRate': restingHeartRate,
    'hrv': hrv,
  };
}

class Preferences {
  const Preferences({required this.tone, required this.preferredActions});

  final Tone tone;
  final List<ActionId> preferredActions;

  factory Preferences.fromJson(Map<String, dynamic> json) {
    final raw = json['preferredActions'];
    if (raw is! List) {
      throw const FormatException(
        'preferences.preferredActions must be a list',
      );
    }
    return Preferences(
      tone: Tone.parse(json['tone']),
      preferredActions: raw.map(ActionId.parse).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tone': tone.name,
    'preferredActions': preferredActions.map((a) => a.id).toList(),
  };
}

class PersonalityProfile {
  const PersonalityProfile({
    required this.id,
    required this.displayName,
    required this.role,
    required this.source,
    required this.bigFive,
    this.facets,
    required this.locusOfControl,
    required this.copingStyle,
    required this.boredomProneness,
    required this.baseline,
    required this.preferences,
  });

  final String id;
  final String displayName;
  final String role;
  final ProfileSource source;
  final BigFive bigFive;
  final Facets? facets;
  final LocusOfControl locusOfControl;
  final CopingStyle copingStyle;
  final double boredomProneness;
  final Baseline baseline;
  final Preferences preferences;

  /// Throws [FormatException] with a readable message when the JSON is invalid.
  factory PersonalityProfile.fromJson(Object? raw) {
    final json = _map(raw, 'Profile');
    final facets = json['facets'];
    return PersonalityProfile(
      id: _string(json, 'id'),
      displayName: _string(json, 'displayName'),
      role: _string(json, 'role'),
      source: ProfileSource.parse(json['source']),
      bigFive: BigFive.fromJson(_map(json['bigFive'], 'bigFive')),
      facets: facets == null ? null : Facets.fromJson(_map(facets, 'facets')),
      locusOfControl: LocusOfControl.parse(json['locusOfControl']),
      copingStyle: CopingStyle.parse(json['copingStyle']),
      boredomProneness: _number(json, 'boredomProneness', min: 0, max: 100),
      baseline: Baseline.fromJson(_map(json['baseline'], 'baseline')),
      preferences: Preferences.fromJson(
        _map(json['preferences'], 'preferences'),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'displayName': displayName,
    'role': role,
    'source': source.id,
    'bigFive': bigFive.toJson(),
    'facets': ?facets?.toJson(),
    'locusOfControl': locusOfControl.name,
    'copingStyle': copingStyle.id,
    'boredomProneness': boredomProneness,
    'baseline': baseline.toJson(),
    'preferences': preferences.toJson(),
  };
}
