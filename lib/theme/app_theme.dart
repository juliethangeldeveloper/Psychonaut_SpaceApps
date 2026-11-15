import 'package:material_ui/material_ui.dart';

import 'tokens.dart';

/// Bundled variable fonts: Space Grotesk for headings, Inter for body. No network needed.
class AppText {
  AppText._(); // coverage:ignore-line

  static const headingFamily = 'SpaceGrotesk';
  static const bodyFamily = 'Inter';
  // Inter first so Cyrillic headings, which Space Grotesk lacks, stay in the brand family.
  static const fallbackFamilies = ['Inter', 'NotoSansArabic', 'NotoSansJP'];

  static TextStyle _style(
    String family,
    double size,
    int weight,
    Color color,
    double height,
  ) => TextStyle(
    fontFamily: family,
    fontFamilyFallback: fallbackFamilies,
    fontSize: size,
    fontWeight: FontWeight.values[(weight ~/ 100) - 1],
    fontVariations: [FontVariation('wght', weight.toDouble())],
    color: color,
    height: height,
  );

  static TextStyle heading({Color color = AppColors.textPrimary}) =>
      _style(headingFamily, 26, 600, color, 1.2);

  static TextStyle section({Color color = AppColors.textPrimary}) =>
      _style(headingFamily, 17, 600, color, 1.3);

  static TextStyle body({
    double size = 14,
    Color color = AppColors.textSecondary,
    int weight = 400,
  }) => _style(bodyFamily, size, weight, color, 1.4);

  static TextStyle caption({Color color = AppColors.textMuted}) =>
      body(size: 13, color: color);
}

ThemeData buildAppTheme() {
  const scheme = ColorScheme.dark(
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    primary: AppColors.onCourse,
    onPrimary: AppColors.background,
    secondary: AppColors.onCourse,
    outline: AppColors.border,
    error: AppColors.alert,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppText.bodyFamily,
  );

  final textTheme = base.textTheme
      .apply(
        fontFamily: AppText.bodyFamily,
        fontFamilyFallback: AppText.fallbackFamilies,
        bodyColor: AppColors.textSecondary,
        displayColor: AppColors.textPrimary,
      )
      .copyWith(
        headlineMedium: AppText.heading(),
        titleMedium: AppText.section(),
        bodyMedium: AppText.body(),
        bodySmall: AppText.caption(),
      );

  const minSize = Size(AppSpacing.minTapTarget, AppSpacing.minTapTarget);
  final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadii.tile),
  );

  return base.copyWith(
    textTheme: textTheme,
    canvasColor: AppColors.background,
    dividerColor: AppColors.border,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.surfaceSelected,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => AppText.body(
          size: 12,
          weight: 500,
          color: states.contains(WidgetState.selected)
              ? AppColors.textPrimary
              : AppColors.textMuted,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.onCourse
              : AppColors.textMuted,
        ),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.surfaceSelected,
      selectedIconTheme: const IconThemeData(color: AppColors.onCourse),
      unselectedIconTheme: const IconThemeData(color: AppColors.textMuted),
      selectedLabelTextStyle: AppText.body(
        size: 12,
        weight: 500,
        color: AppColors.textPrimary,
      ),
      unselectedLabelTextStyle: AppText.body(
        size: 12,
        weight: 500,
        color: AppColors.textMuted,
      ),
      minWidth: 80,
    ),
    sliderTheme: base.sliderTheme.copyWith(
      activeTrackColor: AppColors.onCourse,
      inactiveTrackColor: AppColors.border,
      thumbColor: AppColors.onCourse,
      overlayColor: AppColors.onCourse.withValues(alpha: 0.15),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: minSize,
        backgroundColor: AppColors.onCourse,
        foregroundColor: AppColors.background,
        textStyle: AppText.body(size: 15, weight: 600),
        shape: buttonShape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: minSize,
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        textStyle: AppText.body(size: 15, weight: 600),
        shape: buttonShape,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: minSize,
        foregroundColor: AppColors.onCourse,
        textStyle: AppText.body(size: 14, weight: 600),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceSelected,
      contentTextStyle: AppText.body(color: AppColors.textPrimary),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
