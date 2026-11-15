import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';
import '../models/health_models.dart';
import '../models/personality_profile.dart';

/// Everything stays on the device in shared_preferences.
class LocalStore {
  LocalStore(this._prefs);

  final SharedPreferences _prefs;

  static const _profileKey = 'profile';
  static const _settingsKey = 'settings';
  static const _crewKey = 'crew_joined';

  PersonalityProfile? loadProfile() {
    final raw = _prefs.getString(_profileKey);
    if (raw == null) return null;
    try {
      return PersonalityProfile.fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  Future<void> saveProfile(PersonalityProfile p) =>
      _prefs.setString(_profileKey, jsonEncode(p.toJson()));

  AppSettings loadSettings() {
    final raw = _prefs.getString(_settingsKey);
    if (raw == null) return const AppSettings();
    try {
      return AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings s) =>
      _prefs.setString(_settingsKey, jsonEncode(s.toJson()));

  List<CheckIn> loadCheckIns(String profileId) =>
      _loadList('checkins_$profileId', CheckIn.fromJson);

  Future<void> saveCheckIns(String profileId, List<CheckIn> items) =>
      _prefs.setString(
        'checkins_$profileId',
        jsonEncode(items.map((e) => e.toJson()).toList()),
      );

  List<ReactionResult> loadReactions(String profileId) =>
      _loadList('reactions_$profileId', ReactionResult.fromJson);

  Future<void> saveReactions(String profileId, List<ReactionResult> items) =>
      _prefs.setString(
        'reactions_$profileId',
        jsonEncode(items.map((e) => e.toJson()).toList()),
      );

  bool get crewJoined => _prefs.getBool(_crewKey) ?? false;

  Future<void> setCrewJoined(bool v) => _prefs.setBool(_crewKey, v);

  List<T> _loadList<T>(String key, T Function(Map<String, dynamic>) parse) {
    final raw = _prefs.getString(key);
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List)
          .map((e) => parse(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
