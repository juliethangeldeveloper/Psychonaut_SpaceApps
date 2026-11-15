import 'package:material_ui/material_ui.dart';

import '../models/status.dart';

class AppColors {
  AppColors._(); // coverage:ignore-line

  static const background = Color(0xFF0E1320);
  static const surface = Color(0xFF171E2E);
  static const surfaceSelected = Color(0xFF1F2940);
  static const border = Color(0xFF2A3550);

  static const textPrimary = Color(0xFFE8ECF4);
  static const textSecondary = Color(0xFFC5CEDF);
  static const textMuted = Color(0xFF9AA6BD);

  static const onCourse = Color(0xFF6CB6FF);
  static const drifting = Color(0xFFF2B84B);
  static const offCourse = Color(0xFFF28B50);
  static const alert = Color(0xFFFF6B6B);

  static Color forStatus(Status status) => switch (status) {
    Status.onCourse => onCourse,
    Status.drifting => drifting,
    Status.offCourse => offCourse,
    Status.alert => alert,
  };
}

class AppRadii {
  AppRadii._(); // coverage:ignore-line

  static const card = 16.0;
  static const tile = 14.0;
}

class AppSpacing {
  AppSpacing._(); // coverage:ignore-line

  static const screenPadding = 16.0;
  static const cardPadding = 16.0;
  static const gap = 12.0;
  static const minTapTarget = 48.0;
  static const maxContentWidth = 430.0;

  /// Under [tablet]: phone. [tablet] to [console]: tablet. Over [console]: console.
  static const tablet = 600.0;
  static const console = 1000.0;
}
