import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:psychonaut_application/app/app.dart';
import 'package:psychonaut_application/app/providers.dart';
import 'package:psychonaut_application/data/health_data_source.dart';
import 'package:psychonaut_application/data/mock_health_data_source.dart';
import 'package:psychonaut_application/models/personality_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serves a snapshot loaded up front, because asset IO cannot finish inside fake async.
class FixedSource implements HealthDataSource {
  FixedSource(this.snapshot);

  final HealthSnapshot snapshot;

  @override
  bool get isSample => true;

  @override
  Future<HealthSnapshot> fetch(PersonalityProfile profile) async => snapshot;
}

/// Tests use the real bundled fonts so text widths match the app, not the Ahem test font.
Future<void> loadAppFonts() async {
  for (final (family, path) in [
    ('Inter', 'assets/fonts/Inter.ttf'),
    ('SpaceGrotesk', 'assets/fonts/SpaceGrotesk.ttf'),
    ('NotoSansArabic', 'assets/fonts/NotoSansArabic.ttf'),
    ('NotoSansJP', 'assets/fonts/NotoSansJP.ttf'),
  ]) {
    final bytes = File(path).readAsBytesSync();
    final loader = FontLoader(family)
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
  }
}

class TestApp {
  TestApp(this.tester);

  final WidgetTester tester;

  /// Fails on layout overflows and other framework errors raised while pumping.
  void expectNoErrors() {
    final e = tester.takeException();
    if (e != null) fail('$e');
  }
}

Future<TestApp> pumpApp(
  WidgetTester tester, {
  required Size size,
  String profileId = 'maya-reyes',
  bool withProfile = true,
  Map<String, Object> extraPrefs = const {},
  List<Override> overrides = const [],
  HealthSnapshot Function(HealthSnapshot)? transform,
}) async {
  final profileJson = File('assets/profiles/$profileId.json')
      .readAsStringSync();
  SharedPreferences.setMockInitialValues({
    if (withProfile) 'profile': jsonEncode(jsonDecode(profileJson)),
    ...extraPrefs,
  });
  final prefs = await SharedPreferences.getInstance();
  final profile = PersonalityProfile.fromJson(jsonDecode(profileJson));
  var snapshot = (await tester.runAsync(
    () => MockHealthDataSource().fetch(profile),
  ))!;
  if (transform != null) snapshot = transform(snapshot);

  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        healthDataSourceProvider.overrideWithValue(FixedSource(snapshot)),
        ...overrides,
      ],
      child: const PsychonautApp(),
    ),
  );
  await tester.pumpAndSettle();
  return TestApp(tester);
}

Future<void> scrollTo(WidgetTester tester, Finder target) async {
  await tester.scrollUntilVisible(
    target,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
}
