/// Where the written insight on Home comes from.
enum AiSource {
  ruleBased('rule_based'),
  onBoard('on_board'),
  cloud('cloud');

  const AiSource(this.id);

  final String id;

  static AiSource parse(Object? id) {
    for (final s in values) {
      if (s.id == id) return s;
    }
    return AiSource.ruleBased;
  }
}

class AppSettings {
  const AppSettings({
    this.aiSource = AiSource.ruleBased,
    this.missionStart,
    this.languageCode,
  });

  final AiSource aiSource;

  /// Day 1 of the mission. Null until the user or the app sets it.
  final DateTime? missionStart;

  /// Language chosen by the user. Null follows the device language.
  final String? languageCode;

  AppSettings copyWith({
    AiSource? aiSource,
    DateTime? missionStart,
    String? languageCode,
    bool followDeviceLanguage = false,
  }) => AppSettings(
    aiSource: aiSource ?? this.aiSource,
    missionStart: missionStart ?? this.missionStart,
    languageCode: followDeviceLanguage
        ? null
        : languageCode ?? this.languageCode,
  );

  Map<String, dynamic> toJson() => {
    'aiSource': aiSource.id,
    'missionStart': ?missionStart?.toIso8601String(),
    'languageCode': ?languageCode,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    aiSource: AiSource.parse(json['aiSource']),
    missionStart: json['missionStart'] == null
        ? null
        : DateTime.tryParse(json['missionStart'] as String),
    languageCode: json['languageCode'] as String?,
  );
}
