import 'package:material_ui/material_ui.dart';

import '../theme/tokens.dart';

enum LayoutMode {
  /// Under 600 wide: one column, bottom navigation.
  phone,

  /// 600 to 1000: two columns, navigation rail.
  tablet,

  /// Over 1000: navigation rail and a three-panel dashboard.
  console;

  static LayoutMode forWidth(double width) {
    if (width > AppSpacing.console) return LayoutMode.console;
    if (width >= AppSpacing.tablet) return LayoutMode.tablet;
    return LayoutMode.phone;
  }

  static LayoutMode of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LayoutModeScope>()?.mode ??
      LayoutMode.phone;

  bool get isPhone => this == LayoutMode.phone;
}

/// Computed once from the window width so every screen agrees on the layout.
class LayoutModeScope extends InheritedWidget {
  const LayoutModeScope({super.key, required this.mode, required super.child});

  final LayoutMode mode;

  @override
  bool updateShouldNotify(LayoutModeScope old) => old.mode != mode;
}
