import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../l10n/l10n.dart';
import '../../models/health_models.dart';
import '../../models/personality_profile.dart';
import '../../models/risk_assessment.dart';
import '../../services/action_planner.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';
import '../trends/charts.dart';
import 'home_widgets.dart';
import 'indicator_widgets.dart';

const _gap = SizedBox(height: AppSpacing.gap);

List<Widget> _spaced(List<Widget> items) => [
  for (var i = 0; i < items.length; i++) ...[if (i > 0) _gap, items[i]],
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = LayoutMode.of(context);
    final assessment = ref.watch(assessmentProvider);
    final profile = ref.watch(profileProvider);

    return assessment.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            context.l10n.loadError('$e'),
            textAlign: TextAlign.center,
            style: AppText.body(),
          ),
        ),
      ),
      data: (a) {
        if (profile == null) return const SizedBox.shrink();
        final selected = ref.watch(selectedIndicatorProvider);
        void select(Indicator i) =>
            ref.read(selectedIndicatorProvider.notifier).select(i);
        return switch (mode) {
          LayoutMode.phone => _PhoneHome(
            assessment: a,
            profile: profile,
            selected: selected,
            onSelect: select,
          ),
          LayoutMode.tablet => _TabletHome(
            assessment: a,
            profile: profile,
            selected: selected,
            onSelect: select,
          ),
          LayoutMode.console => _ConsoleHome(
            assessment: a,
            profile: profile,
            selected: selected ?? worstReading(a)?.indicator ?? Indicator.sleep,
            onSelect: select,
          ),
        };
      },
    );
  }
}

/// Cards that depend on what is happening right now, spaced by the caller.
List<Widget> _alerts(RiskAssessment a) => [
  const RemindersSection(),
  if (a.mismatch) MismatchAlertCard(assessment: a),
  if (a.lifeEventActive) const LifeEventCard(),
];

class _PhoneHome extends StatelessWidget {
  const _PhoneHome({
    required this.assessment,
    required this.profile,
    required this.selected,
    required this.onSelect,
  });

  final RiskAssessment assessment;
  final PersonalityProfile profile;
  final Indicator? selected;
  final ValueChanged<Indicator> onSelect;

  @override
  Widget build(BuildContext context) {
    final a = assessment;
    return ScreenScaffold(
      children: [
        ..._spaced([
          HomeHeader(assessment: a),
          HeadingCard(assessment: a),
          ..._alerts(a),
          const TodaysReadingCard(),
          Text(context.l10n.indicatorsTitle, style: AppText.section()),
          IndicatorGrid(assessment: a, selected: selected, onSelect: onSelect),
          if (selected != null)
            IndicatorDetailCard(
              reading: a.reading(selected!),
              profile: profile,
            ),
        ]),
        const SizedBox(height: 20),
        const DisclaimerLine(),
      ],
    );
  }
}

class _TabletHome extends StatelessWidget {
  const _TabletHome({
    required this.assessment,
    required this.profile,
    required this.selected,
    required this.onSelect,
  });

  final RiskAssessment assessment;
  final PersonalityProfile profile;
  final Indicator? selected;
  final ValueChanged<Indicator> onSelect;

  @override
  Widget build(BuildContext context) {
    final a = assessment;
    return ScreenScaffold(
      children: [
        HomeHeader(assessment: a),
        _gap,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: _spaced([
                  HeadingCard(assessment: a),
                  ..._alerts(a),
                  const TodaysReadingCard(),
                ]),
              ),
            ),
            const SizedBox(width: AppSpacing.screenPadding),
            Expanded(
              flex: 6,
              child: Column(
                children: _spaced([
                  IndicatorGrid(
                    assessment: a,
                    selected: selected,
                    onSelect: onSelect,
                  ),
                  if (selected != null)
                    IndicatorDetailCard(
                      reading: a.reading(selected!),
                      profile: profile,
                    ),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const DisclaimerLine(),
      ],
    );
  }
}

/// Mind map, selected indicator detail and trends, all visible together.
class _ConsoleHome extends ConsumerWidget {
  const _ConsoleHome({
    required this.assessment,
    required this.profile,
    required this.selected,
    required this.onSelect,
  });

  final RiskAssessment assessment;
  final PersonalityProfile profile;
  final Indicator selected;
  final ValueChanged<Indicator> onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = assessment;
    final metrics = ref.watch(snapshotProvider).value?.metrics ?? const [];
    final tests = ref.watch(reactionHistoryProvider).value ?? const [];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(assessment: a, showProfile: false),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _Panel(
                      title: context.l10n.panelMindMap,
                      children: [
                        HeadingCard(assessment: a),
                        ..._alerts(a),
                        MindMap(
                          assessment: a,
                          selected: selected,
                          onSelect: onSelect,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _Panel(
                      title: context.l10n.panelSelected,
                      children: [
                        IndicatorDetailCard(
                          reading: a.reading(selected),
                          profile: profile,
                        ),
                        const TodaysReadingCard(),
                        const DisclaimerLine(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _Panel(
                      title: context.l10n.navTrends,
                      children: [
                        _ChartCard(
                          title: context.l10n.chartLast14(
                            selected.label(context.l10n),
                          ),
                          child: IndicatorLineChart(
                            reading: a.reading(selected),
                          ),
                        ),
                        _ChartCard(
                          title: context.l10n.chartSleep14,
                          child: SleepBarChart(
                            metrics: metrics,
                            reading: a.reading(Indicator.sleep),
                          ),
                        ),
                        _ChartCard(
                          title: context.l10n.indicatorReaction,
                          child: ReactionLineChart(
                            tests: tests,
                            baselineMs: a.reading(Indicator.reaction).baseline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.section()),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: title,
      child: ListView(
        padding: const EdgeInsetsDirectional.only(end: 4, bottom: 8),
        children: _spaced(children),
      ),
    );
  }
}
