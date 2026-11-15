import 'package:intl/intl.dart';

import '../l10n/l10n.dart';
import '../models/health_models.dart';
import '../models/risk_assessment.dart';

/// Number in the reader's locale, for example 6,4 in French.
String formatNumber(AppLocalizations l, double v, {int decimals = 1}) =>
    NumberFormat.decimalPatternDigits(
      locale: l.localeName,
      decimalDigits: decimals,
    ).format(v);

String formatValue(AppLocalizations l, Indicator i, double v) => switch (i) {
  Indicator.sleep => l.unitHours(formatNumber(l, v)),
  Indicator.reaction => l.unitMs(formatNumber(l, v, decimals: 0)),
  _ => formatNumber(l, v),
};

/// Plain trend text for tiles, such as "0.8 h below baseline, slipping".
String trendText(AppLocalizations l, IndicatorReading r) {
  if (!r.hasData) return l.trendNoData;
  final gap = r.delta;
  final String where;
  if (gap.abs() < r.sd * 0.25) {
    where = l.trendAtBaseline;
  } else {
    final amount = switch (r.indicator) {
      Indicator.sleep => l.unitHours(formatNumber(l, gap.abs())),
      Indicator.reaction => l.unitMs(formatNumber(l, gap.abs(), decimals: 0)),
      _ => formatNumber(l, gap.abs()),
    };
    where = gap > 0 ? l.trendAbove(amount) : l.trendBelow(amount);
  }
  return l.trendJoin(where, r.trend.label(l));
}
