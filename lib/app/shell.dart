import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../l10n/l10n.dart';
import 'layout.dart';

class _Destination {
  const _Destination(this.label, this.icon, this.selectedIcon);

  final String Function(AppLocalizations) label;
  final IconData icon;
  final IconData selectedIcon;
}

final _destinations = [
  _Destination((l) => l.navHome, Icons.explore_outlined, Icons.explore),
  _Destination((l) => l.navCheckIn, Icons.edit_note_outlined, Icons.edit_note),
  _Destination((l) => l.navTrends, Icons.show_chart, Icons.show_chart),
  _Destination((l) => l.navCrew, Icons.groups_outlined, Icons.groups),
];

/// Cmd or Ctrl plus 1 to 4 jumps between tabs.
final _digitKeys = [
  LogicalKeyboardKey.digit1,
  LogicalKeyboardKey.digit2,
  LogicalKeyboardKey.digit3,
  LogicalKeyboardKey.digit4,
];

/// Bottom bar on phones, navigation rail on tablet and console.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _go(int i) =>
      shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final mode = LayoutMode.of(context);
    final body = CallbackShortcuts(
      bindings: {
        for (var i = 0; i < _digitKeys.length; i++) ...{
          SingleActivator(_digitKeys[i], meta: true): () => _go(i),
          SingleActivator(_digitKeys[i], control: true): () => _go(i),
        },
      },
      child: Focus(autofocus: true, child: shell),
    );

    if (mode.isPhone) {
      return Scaffold(
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: _go,
          destinations: [
            for (final d in _destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label(context.l10n),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: _go,
            labelType: NavigationRailLabelType.all,
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: IconButton(
                    tooltip: context.l10n.profileAndSettings,
                    iconSize: 28,
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                    onPressed: () => context.push('/profile'),
                    icon: const Icon(Icons.account_circle_outlined),
                  ),
                ),
              ),
            ),
            destinations: [
              for (final d in _destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label(context.l10n)),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}
