import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Pill label. Static when [onTap] is null; otherwise a selectable filter.
class TechChip extends StatelessWidget {
  const TechChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final interactive = onTap != null;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(999);

    final chip = AnimatedContainer(
      duration: AppDurations.fast,
      constraints: BoxConstraints(minHeight: interactive ? 40 : 28),
      padding: EdgeInsets.symmetric(
        horizontal: interactive ? AppSpacing.md : 10,
      ),
      decoration: BoxDecoration(
        gradient: selected ? AppColors.brandGradient : null,
        color: selected
            ? null
            : interactive
                ? AppColors.surface
                : AppColors.orange.withValues(alpha: 0.1),
        borderRadius: radius,
        border: Border.all(
          color: selected
              ? Colors.transparent
              : interactive
                  ? AppColors.border
                  : AppColors.orange.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: (interactive ? textTheme.labelMedium : textTheme.bodySmall)
                ?.copyWith(
              color: selected
                  ? AppColors.onAccent
                  : interactive
                      ? AppColors.text
                      : AppColors.accentText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (!interactive) return chip;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: chip,
        ),
      ),
    );
  }
}
