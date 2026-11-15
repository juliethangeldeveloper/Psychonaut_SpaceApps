import 'package:flutter_test/flutter_test.dart';
import 'package:psychonaut_application/data/mock_health_data_source.dart';
import 'package:psychonaut_application/models/action_id.dart';
import 'package:psychonaut_application/models/personality_profile.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

Map<String, dynamic> valid() => {
  'id': 'maya-reyes',
  'displayName': 'Maya Reyes',
  'role': 'Commander',
  'source': 'ipip-neo-120',
  'bigFive': {
    'openness': 72,
    'conscientiousness': 88,
    'extraversion': 55,
    'agreeableness': 64,
    'emotionalStability': 78,
  },
  'facets': {
    'excitementSeeking': 40,
    'gregariousness': 50,
    'vulnerability': 30,
    'selfDiscipline': 90,
  },
  'locusOfControl': 'internal',
  'copingStyle': 'problem_focused',
  'boredomProneness': 35,
  'baseline': {
    'sleepHours': 7.2,
    'mood': 7,
    'stress': 4,
    'workload': 5,
    'engagement': 7,
    'focus': 7,
    'connection': 7,
    'reactionMs': 250,
    'restingHeartRate': 58,
    'hrv': 62,
  },
  'preferences': {
    'tone': 'direct',
    'preferredActions': ['sleep_reset', 'window_time'],
  },
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('parses a valid profile and round-trips', () {
    final p = PersonalityProfile.fromJson(valid());
    expect(p.displayName, 'Maya Reyes');
    expect(p.source, ProfileSource.ipipNeo120);
    expect(p.facets!.selfDiscipline, 90);
    expect(p.baseline.reactionMs, 250);
    expect(p.preferences.preferredActions, [
      ActionId.sleepReset,
      ActionId.windowTime,
    ]);
    final again = PersonalityProfile.fromJson(p.toJson());
    expect(again.baseline.workload, 5);
    expect(again.facets!.vulnerability, 30);
  });

  test('facets are optional and source defaults to imported', () {
    final json = valid()
      ..remove('facets')
      ..remove('source');
    final p = PersonalityProfile.fromJson(json);
    expect(p.facets, isNull);
    expect(p.source, ProfileSource.imported);
    expect(p.toJson().containsKey('facets'), isFalse);
  });

  test('rejects bad values with a FormatException', () {
    final cases = <void Function(Map<String, dynamic>)>[
      (j) => j['id'] = '',
      (j) => (j['bigFive'] as Map)['openness'] = 120,
      (j) => (j['facets'] as Map)['gregariousness'] = -1,
      (j) => j['source'] = 'horoscope',
      (j) => j['locusOfControl'] = 'sideways',
      (j) => j['copingStyle'] = 'panic',
      (j) => j['boredomProneness'] = 'high',
      (j) => (j['baseline'] as Map).remove('hrv'),
      (j) => (j['baseline'] as Map).remove('reactionMs'),
      (j) => (j['preferences'] as Map)['preferredActions'] = ['skydiving'],
      (j) => (j['preferences'] as Map)['tone'] = 'sarcastic',
    ];
    for (final mutate in cases) {
      final json = valid();
      mutate(json);
      expect(
        () => PersonalityProfile.fromJson(json),
        throwsA(isA<FormatException>()),
      );
    }
  });

  test('rejects non-object JSON', () {
    expect(
      () => PersonalityProfile.fromJson([1, 2]),
      throwsA(isA<FormatException>()),
    );
  });

  test('all bundled profiles parse and have matching sample data', () async {
    for (final id in ['maya-reyes', 'idris-okafor', 'lena-voss']) {
      final raw = await rootBundle.loadString('assets/profiles/$id.json');
      final profile = PersonalityProfile.fromJson(jsonDecode(raw));
      expect(profile.id, id);
      final snap = await MockHealthDataSource(
        clock: () => DateTime(2026, 1, 20),
      ).fetch(profile);
      expect(snap.metrics, hasLength(14));
      expect(snap.checkIns, hasLength(14));
      expect(snap.reactions, isNotEmpty);
      expect(snap.metrics.last.date, DateTime(2026, 1, 20));
    }
  });

  test(
    'unknown profiles get generated sample data from their baseline',
    () async {
      final p = PersonalityProfile.fromJson(valid()..['id'] = 'someone-new');
      final snap = await MockHealthDataSource().fetch(p);
      expect(snap.metrics, hasLength(14));
      expect(snap.checkIns, hasLength(14));
      expect(snap.checkIns.every((c) => c.mood >= 1 && c.mood <= 10), isTrue);
    },
  );
}
