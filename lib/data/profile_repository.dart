import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/personality_profile.dart';

class BundledProfile {
  const BundledProfile(this.id, this.label);
  final String id;
  final String label;
}

/// Bundled samples. Add a JSON file in assets/profiles and list it here.
const bundledProfiles = [
  BundledProfile('maya-reyes', 'Maya Reyes, Commander'),
  BundledProfile('idris-okafor', 'Idris Okafor, Flight Engineer'),
  BundledProfile('lena-voss', 'Lena Voss, Mission Specialist'),
];

Future<PersonalityProfile> loadBundledProfile(String id) async {
  final raw = await rootBundle.loadString('assets/profiles/$id.json');
  return PersonalityProfile.fromJson(jsonDecode(raw));
}

/// Marker the UI replaces with a translated message.
const notJsonMessage = 'not_json';

/// Parses an imported file. Throws [FormatException] with a readable message.
PersonalityProfile parseProfileFile(String text) {
  final Object? json;
  try {
    json = jsonDecode(text);
  } on FormatException {
    throw const FormatException(notJsonMessage);
  }
  final p = PersonalityProfile.fromJson(json);
  return p;
}

/// Opens the system file picker and returns the text of a chosen .json file, or null if cancelled.
Future<String?> pickProfileJsonText(String dialogTitle) async {
  final file = await FilePicker.pickFile(
    dialogTitle: dialogTitle,
    type: FileType.custom,
    allowedExtensions: const ['json'],
  );
  if (file == null) return null;
  return utf8.decode(await file.readAsBytes());
}
