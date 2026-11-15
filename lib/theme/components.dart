import 'package:material_ui/material_ui.dart';

import '../l10n/l10n.dart';
import '../models/status.dart';
import 'app_theme.dart';
import 'tokens.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.cardPadding),
    this.selected = false,
    this.radius = AppRadii.card,
    this.borderColor,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool selected;
  final double radius;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(radius);
    return Material(
      color: selected ? AppColors.surfaceSelected : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: shape,
        side: BorderSide(color: borderColor ?? AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Status dot plus the status word, so colour is never the only signal.
class StatusBadge extends StatelessWidget {
  const StatusBadge(this.status, {super.key, this.fontSize = 13});

  final Status status;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.forStatus(status);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            status.label(context.l10n),
            overflow: TextOverflow.ellipsis,
            style: AppText.body(size: fontSize, weight: 600, color: color),
          ),
        ),
      ],
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.heading()),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: AppText.caption()),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class SampleDataChip extends StatelessWidget {
  const SampleDataChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
        color: AppColors.surface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.science_outlined,
            size: 14,
            color: AppColors.textMuted,
          ),
          const SizedBox(width: 4),
          Text(context.l10n.sampleData, style: AppText.caption()),
        ],
      ),
    );
  }
}

class DisclaimerLine extends StatelessWidget {
  const DisclaimerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(Icons.info_outline, size: 14, color: AppColors.textMuted),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(context.l10n.disclaimer, style: AppText.caption()),
        ),
      ],
    );
  }
}

/// Scrollable page body shared by every tab.
class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding,
          16,
          AppSpacing.screenPadding,
          24,
        ),
        children: children,
      ),
    );
  }
}

/// Label, 0 to 100 value and a bar.
class TraitBar extends StatelessWidget {
  const TraitBar({super.key, required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.traitSemantics(label, value.round()),
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(label, style: AppText.body())),
                  Text('${value.round()}', style: AppText.body(weight: 600)),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value / 100,
                  minHeight: 8,
                  backgroundColor: AppColors.border,
                  color: AppColors.onCourse,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
