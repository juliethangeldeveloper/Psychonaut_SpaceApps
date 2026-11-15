import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/l10n.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final sources = [
      (l.sciHrpTitle, l.sciHrpBody),
      (l.sciBhrTitle, l.sciBhrBody),
      (l.sciReactionTitle, l.sciReactionBody),
      (l.sciIpipTitle, l.sciIpipBody),
    ];
    final assumptions = [l.sciAssume1, l.sciAssume2, l.sciAssume3];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: l.back,
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: ScreenScaffold(
        children: [
          ScreenHeader(title: l.scienceTitle, subtitle: l.scienceSubtitle),
          const SizedBox(height: AppSpacing.gap),
          for (final s in sources) ...[
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.$1, style: AppText.section()),
                  const SizedBox(height: 6),
                  Text(s.$2, style: AppText.body()),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.gap),
          ],
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.scienceAssumptionsTitle, style: AppText.section()),
                const SizedBox(height: 6),
                for (final a in assumptions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('• $a', style: AppText.body()),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.gap),
          const DisclaimerLine(),
        ],
      ),
    );
  }
}
