import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart';

import '../l10n/l10n.dart';
import '../theme/app_theme.dart';
import '../theme/tokens.dart';
import 'layout.dart';
import 'providers.dart';
import 'router.dart';

class PsychonautApp extends ConsumerWidget {
  const PsychonautApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Psychonaut',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      darkTheme: buildAppTheme(),
      themeMode: ThemeMode.dark,
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => LayoutBuilder(
        builder: (context, box) {
          final mode = LayoutMode.forWidth(box.maxWidth);
          Widget content = child ?? const SizedBox.shrink();
          if (mode.isPhone) {
            // Phones are narrow already; this only matters for small desktop windows.
            content = Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.maxContentWidth,
                ),
                child: content,
              ),
            );
          }
          return ColoredBox(
            color: AppColors.background,
            child: LayoutModeScope(mode: mode, child: content),
          );
        },
      ),
    );
  }
}
