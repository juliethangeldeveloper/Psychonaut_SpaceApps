import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/l10n.dart';
import '../../models/health_models.dart';
import '../../models/risk_assessment.dart';
import '../../models/status.dart';
import '../../services/format.dart';
import '../../services/risk_engine.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

FlTitlesData _titles({
  required Widget Function(double value, TitleMeta meta) bottom,
  required double leftInterval,
  required String Function(double) leftLabel,
  double bottomReserved = 24,
}) => FlTitlesData(
  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: bottomReserved,
      interval: 1,
      getTitlesWidget: bottom,
    ),
  ),
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 36,
      interval: leftInterval,
      getTitlesWidget: (v, meta) => SideTitleWidget(
        meta: meta,
        child: Text(leftLabel(v), style: AppText.caption()),
      ),
    ),
  ),
);

FlGridData get _grid => FlGridData(
  drawVerticalLine: false,
  getDrawingHorizontalLine: (_) =>
      const FlLine(color: AppColors.border, strokeWidth: 0.5),
);

HorizontalLine _baselineLine(double y) => HorizontalLine(
  y: y,
  color: AppColors.textSecondary,
  strokeWidth: 1.5,
  dashArray: [6, 4],
);

class _Legend extends StatelessWidget {
  const _Legend({required this.statuses, this.baselineLabel});

  final Iterable<Status> statuses;
  final String? baselineLabel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: [
        for (final s in statuses) StatusBadge(s, fontSize: 12),
        if (baselineLabel != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 22,
                child: CustomPaint(
                  painter: _DashPainter(),
                  size: const Size(22, 2),
                ),
              ),
              const SizedBox(width: 6),
              Text(baselineLabel!, style: AppText.caption()),
            ],
          ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 1.5;
    for (var x = 0.0; x < size.width; x += 7) {
      canvas.drawLine(Offset(x, 1), Offset(x + 4, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// 14-night sleep bars with a dashed personal baseline. Bars are coloured by status
/// and the legend names each status, so colour is never the only cue.
class SleepBarChart extends StatelessWidget {
  const SleepBarChart({
    super.key,
    required this.metrics,
    required this.reading,
    this.height = 200,
  });

  final List<DayMetrics> metrics;
  final IndicatorReading reading;
  final double height;

  @override
  Widget build(BuildContext context) {
    final nights = metrics.length <= 14
        ? metrics
        : metrics.sublist(metrics.length - 14);
    if (nights.isEmpty) {
      return Text(context.l10n.chartNoSleep, style: AppText.caption());
    }
    final statuses = [
      for (final n in nights)
        RiskEngine.sleepNightStatus(n.sleepHours, reading.baseline, reading.sd),
    ];
    final maxY =
        (nights
                    .map((n) => n.sleepHours)
                    .followedBy([reading.baseline, 8.0])
                    .reduce((a, b) => a > b ? a : b) +
                1)
            .ceilToDouble();

    final chart = BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        gridData: _grid,
        borderData: FlBorderData(show: false),
        titlesData: _titles(
          leftInterval: 2,
          leftLabel: (v) => '${v.toInt()}',
          bottom: (v, meta) {
            final i = v.toInt();
            final show =
                i == nights.length - 1 || i % 3 == 0 && i < nights.length - 2;
            return SideTitleWidget(
              meta: meta,
              child: Text(
                show
                    ? (i == nights.length - 1
                          ? context.l10n.chartToday
                          : '${nights[i].date.day}')
                    : '',
                style: AppText.caption(),
              ),
            );
          },
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [_baselineLine(reading.baseline)],
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.surfaceSelected,
            getTooltipItem: (group, _, rod, _) => BarTooltipItem(
              context.l10n.chartTooltipSleep(
                formatValue(context.l10n, Indicator.sleep, rod.toY),
                statuses[group.x].label(context.l10n),
              ),
              AppText.body(size: 12, color: AppColors.textPrimary, weight: 600),
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < nights.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: nights[i].sleepHours,
                  width: 12,
                  color: AppColors.forStatus(statuses[i]),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            ),
        ],
      ),
    );

    return Semantics(
      label: context.l10n.chartSleepSemantics(
        nights.length,
        formatValue(context.l10n, Indicator.sleep, reading.baseline),
        formatValue(context.l10n, Indicator.sleep, nights.last.sleepHours),
        statuses.last.label(context.l10n),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            child: ExcludeSemantics(child: chart),
          ),
          const SizedBox(height: 10),
          _Legend(
            statuses: Status.values.where(statuses.contains),
            baselineLabel: context.l10n.chartBaselineValue(
              formatValue(context.l10n, Indicator.sleep, reading.baseline),
            ),
          ),
        ],
      ),
    );
  }
}

/// Mean reaction time per test with the personal baseline.
class ReactionLineChart extends StatelessWidget {
  const ReactionLineChart({
    super.key,
    required this.tests,
    required this.baselineMs,
    this.height = 180,
  });

  final List<ReactionResult> tests;
  final double baselineMs;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (tests.length < 2) {
      return Text(context.l10n.chartNeedTests, style: AppText.caption());
    }
    final recent = tests.length <= 10
        ? tests
        : tests.sublist(tests.length - 10);
    final values = recent.map((t) => t.meanMs);
    final lo = values.followedBy([baselineMs]).reduce((a, b) => a < b ? a : b);
    final hi = values.followedBy([baselineMs]).reduce((a, b) => a > b ? a : b);
    final minY = ((lo - 30) / 50).floorToDouble() * 50;
    final maxY = ((hi + 30) / 50).ceilToDouble() * 50;

    return Semantics(
      label: context.l10n.chartReactionSemantics(
        recent.length,
        formatValue(context.l10n, Indicator.reaction, baselineMs),
        formatValue(context.l10n, Indicator.reaction, recent.last.meanMs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            child: ExcludeSemantics(
              child: LineChart(
                LineChartData(
                  minY: minY,
                  maxY: maxY,
                  minX: 0,
                  maxX: (recent.length - 1).toDouble(),
                  gridData: _grid,
                  borderData: FlBorderData(show: false),
                  titlesData: _titles(
                    leftInterval: 50,
                    leftLabel: (v) => '${v.toInt()}',
                    bottom: (v, meta) {
                      final i = v.toInt();
                      final ok =
                          v == i.toDouble() && i >= 0 && i < recent.length;
                      final d = ok ? recent[i].date : null;
                      final show = ok && (i == recent.length - 1 || i % 2 == 0);
                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          show ? '${d!.day}/${d.month}' : '',
                          style: AppText.caption(),
                        ),
                      );
                    },
                  ),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [_baselineLine(baselineMs)],
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => AppColors.surfaceSelected,
                      getTooltipItems: (spots) => [
                        for (final s in spots)
                          LineTooltipItem(
                            formatValue(context.l10n, Indicator.reaction, s.y),
                            AppText.body(
                              size: 12,
                              color: AppColors.textPrimary,
                              weight: 600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (var i = 0; i < recent.length; i++)
                          FlSpot(i.toDouble(), recent[i].meanMs),
                      ],
                      isCurved: false,
                      color: AppColors.onCourse,
                      barWidth: 2.5,
                      dotData: FlDotData(
                        getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
                          radius: 4,
                          color: AppColors.onCourse,
                          strokeWidth: 1.5,
                          strokeColor: AppColors.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _Legend(
            statuses: const [],
            baselineLabel: context.l10n.chartBaselineValue(
              formatValue(context.l10n, Indicator.reaction, baselineMs),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small line of the last 14 values for any indicator, used in the console trends panel.
class IndicatorLineChart extends StatelessWidget {
  const IndicatorLineChart({
    super.key,
    required this.reading,
    this.height = 160,
  });

  final IndicatorReading reading;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (reading.series.length < 2) {
      return Text(context.l10n.chartNotEnough, style: AppText.caption());
    }
    final s = reading.series;
    final isScale =
        reading.indicator != Indicator.sleep &&
        reading.indicator != Indicator.reaction;
    final lo = isScale
        ? 1.0
        : s.followedBy([reading.baseline]).reduce((a, b) => a < b ? a : b) - 1;
    final hi = isScale
        ? 10.0
        : s.followedBy([reading.baseline]).reduce((a, b) => a > b ? a : b) + 1;
    final color = AppColors.forStatus(reading.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          child: LineChart(
            LineChartData(
              minY: lo.floorToDouble(),
              maxY: hi.ceilToDouble(),
              minX: 0,
              maxX: (s.length - 1).toDouble(),
              gridData: _grid,
              borderData: FlBorderData(show: false),
              titlesData: _titles(
                leftInterval: isScale
                    ? 3
                    : ((hi - lo) / 3).ceilToDouble().clamp(1, 1000),
                leftLabel: (v) => v.toInt().toString(),
                bottom: (v, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(
                    v.toInt() == s.length - 1
                        ? context.l10n.chartToday
                        : v.toInt() == 0
                        ? context.l10n.chartDaysAgo(s.length - 1)
                        : '',
                    style: AppText.caption(),
                  ),
                ),
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: [_baselineLine(reading.baseline)],
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (var i = 0; i < s.length; i++)
                      FlSpot(i.toDouble(), s[i]),
                  ],
                  color: color,
                  barWidth: 2.5,
                  isCurved: false,
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _Legend(
          statuses: [reading.status],
          baselineLabel: context.l10n.chartBaseline,
        ),
      ],
    );
  }
}
