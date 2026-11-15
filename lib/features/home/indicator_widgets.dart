import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../data/reference_content.dart';
import '../../l10n/l10n.dart';
import '../../models/health_models.dart';
import '../../models/personality_profile.dart';
import '../../models/risk_assessment.dart';
import '../../services/action_planner.dart';
import '../../services/format.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

String _semanticsFor(BuildContext context, IndicatorReading r) {
  final l = context.l10n;
  return l.tileSemantics(
    r.indicator.label(l),
    r.status.label(l),
    trendText(l, r),
  );
}

/// One of the six indicator tiles.
class IndicatorTile extends StatelessWidget {
  const IndicatorTile({
    super.key,
    required this.reading,
    required this.selected,
    required this.onTap,
  });

  final IndicatorReading reading;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: _semanticsFor(context, reading),
      child: ExcludeSemantics(
        child: AppCard(
          radius: AppRadii.tile,
          padding: const EdgeInsets.all(14),
          selected: selected,
          borderColor: selected ? AppColors.forStatus(reading.status) : null,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 72),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  reading.indicator.label(context.l10n),
                  style: AppText.body(
                    size: 15,
                    weight: 600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                StatusBadge(reading.status),
                const SizedBox(height: 4),
                Text(
                  trendText(context.l10n, reading),
                  style: AppText.caption(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Two-column grid of the six tiles. Rows, not a scroll view, so it nests anywhere.
class IndicatorGrid extends StatelessWidget {
  const IndicatorGrid({
    super.key,
    required this.assessment,
    required this.selected,
    required this.onSelect,
  });

  final RiskAssessment assessment;
  final Indicator? selected;
  final ValueChanged<Indicator> onSelect;

  @override
  Widget build(BuildContext context) {
    final items = Indicator.tiles;
    Widget tile(Indicator i) => IndicatorTile(
      reading: assessment.reading(i),
      selected: selected == i,
      onTap: () => onSelect(i),
    );
    return Column(
      children: [
        for (var i = 0; i < items.length; i += 2) ...[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: tile(items[i])),
                const SizedBox(width: AppSpacing.gap),
                Expanded(child: tile(items[i + 1])),
              ],
            ),
          ),
          if (i + 2 < items.length) const SizedBox(height: AppSpacing.gap),
        ],
      ],
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection(this.title, this.text);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.section()),
          const SizedBox(height: 4),
          Text(text, style: AppText.body()),
        ],
      ),
    );
  }
}

/// "How it's measured", "Why it matters", "What to do now" and the NASA link for one indicator.
class IndicatorDetailCard extends StatelessWidget {
  const IndicatorDetailCard({
    super.key,
    required this.reading,
    required this.profile,
  });

  final IndicatorReading reading;
  final PersonalityProfile profile;

  /// Framing follows locus of control: internal gets options, external gets one step.
  String _whatToDo(AppLocalizations l) {
    final text = l.todo(reading.indicator);
    final best = suggestActionForIndicator(profile, reading.indicator);
    switch (profile.locusOfControl) {
      case LocusOfControl.internal:
        final options = orderedActions(profile).take(3).map((a) => a.title(l));
        return l.whatToDoOptions(text, options.join(', '));
      case LocusOfControl.mixed:
        return l.whatToDoRecommended(text, best.title(l));
      case LocusOfControl.external:
        return l.whatToDoOneStep(best.title(l), best.description(l));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final ref = ReferenceContent.of(reading.indicator);
    final i = reading.indicator;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(i.label(l), style: AppText.heading())),
              StatusBadge(reading.status),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            reading.hasData
                ? l.detailNow(
                    formatValue(l, i, reading.current),
                    formatValue(l, i, reading.baseline),
                    reading.trend.label(l),
                  )
                : l.trendNoData,
            style: AppText.caption(),
          ),
          if (reading.flaggedSooner)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(l.flaggedSooner, style: AppText.caption()),
            ),
          _DetailSection(l.detailHowMeasured, l.measured(i)),
          _DetailSection(l.detailWhy, l.why(i)),
          _DetailSection(l.detailWhatToDo, _whatToDo(l)),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _NasaRow(
            icon: Icons.rocket_launch_outlined,
            label: l.nasaRiskLabel,
            value: ref.risk.label(l),
          ),
          const SizedBox(height: 6),
          _NasaRow(
            icon: Icons.public,
            label: l.nasaHazardLabel,
            value: ref.hazards.map((h) => h.label(l)).join(', '),
          ),
        ],
      ),
    );
  }
}

class _NasaRow extends StatelessWidget {
  const _NasaRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context.l10n.labelValue(label, ''),
                  style: AppText.body(
                    size: 13,
                    weight: 600,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextSpan(text: value, style: AppText.body(size: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// You in the centre, the six indicators around you, joined by lines in their status colour.
class MindMap extends StatelessWidget {
  const MindMap({
    super.key,
    required this.assessment,
    required this.selected,
    required this.onSelect,
  });

  final RiskAssessment assessment;
  final Indicator? selected;
  final ValueChanged<Indicator> onSelect;

  static const _nodeW = 112.0;
  static const _nodeH = 60.0;

  @override
  Widget build(BuildContext context) {
    final items = Indicator.tiles;
    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth.isFinite ? box.maxWidth : 340.0;
        final h = math.max(w * 1.1, 360.0);
        final center = Offset(w / 2, h / 2);
        final rx = w / 2 - _nodeW / 2 - 2;
        final ry = h / 2 - _nodeH / 2 - 2;
        final centers = [
          for (var i = 0; i < items.length; i++)
            center +
                Offset(
                  rx * math.cos(-math.pi / 2 + i * 2 * math.pi / items.length),
                  ry * math.sin(-math.pi / 2 + i * 2 * math.pi / items.length),
                ),
        ];

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LinkPainter(
                    center: center,
                    ends: centers,
                    colors: [
                      for (final i in items)
                        AppColors.forStatus(assessment.reading(i).status),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: center.dx - 44,
                top: center.dy - 44,
                child: Container(
                  width: 88,
                  height: 88,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceSelected,
                    border: Border.all(
                      color: AppColors.forStatus(assessment.overall),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${assessment.degreesOffCourse.round()}°',
                        style: AppText.section(),
                      ),
                      Text(
                        assessment.overall.label(context.l10n),
                        textAlign: TextAlign.center,
                        style: AppText.body(
                          size: 11,
                          weight: 600,
                          color: AppColors.forStatus(assessment.overall),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (var i = 0; i < items.length; i++)
                Positioned(
                  left: centers[i].dx - _nodeW / 2,
                  top: centers[i].dy - _nodeH / 2,
                  width: _nodeW,
                  height: _nodeH,
                  child: _MapNode(
                    reading: assessment.reading(items[i]),
                    selected: selected == items[i],
                    onTap: () => onSelect(items[i]),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _MapNode extends StatelessWidget {
  const _MapNode({
    required this.reading,
    required this.selected,
    required this.onTap,
  });

  final IndicatorReading reading;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: _semanticsFor(context, reading),
      child: ExcludeSemantics(
        child: AppCard(
          radius: AppRadii.tile,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          selected: selected,
          borderColor: selected ? AppColors.forStatus(reading.status) : null,
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reading.indicator.label(context.l10n),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.body(
                  size: 13,
                  weight: 600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              StatusBadge(reading.status, fontSize: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkPainter extends CustomPainter {
  _LinkPainter({
    required this.center,
    required this.ends,
    required this.colors,
  });

  final Offset center;
  final List<Offset> ends;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < ends.length; i++) {
      canvas.drawLine(
        center,
        ends[i],
        Paint()
          ..color = colors[i].withValues(alpha: 0.7)
          ..strokeWidth = 2,
      );
    }
  }

  @override
  // The lists are rebuilt each time, so comparing them would always say "changed".
  bool shouldRepaint(_LinkPainter old) => true;
}

/// Mission day and phase caption.
String missionLine(AppLocalizations l, RiskAssessment a) =>
    l.missionLine(a.missionDay, a.phase.label(l));
