import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

enum AppButtonVariant { primary, outline }

/// Call-to-action button. [AppButtonVariant.primary] is filled with the brand
/// gradient; [AppButtonVariant.outline] is a translucent bordered button.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.compact = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool compact;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == AppButtonVariant.primary;
    final foreground = isPrimary ? AppColors.onAccent : AppColors.text;
    final radius = BorderRadius.circular(AppRadius.md);
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: foreground,
          fontSize: widget.compact ? 14 : 15,
        );

    return AnimatedContainer(
      duration: AppDurations.fast,
      decoration: BoxDecoration(
        gradient: isPrimary ? AppColors.brandGradient : null,
        color: isPrimary
            ? null
            : Colors.white.withValues(alpha: _hovered ? 0.08 : 0.03),
        borderRadius: radius,
        border: Border.all(
          color: _focused
              ? AppColors.text
              : isPrimary
                  ? Colors.transparent
                  : AppColors.border,
          width: _focused ? 2 : 1,
        ),
        boxShadow: [
          if (isPrimary)
            BoxShadow(
              color: AppColors.orange.withValues(alpha: _hovered ? 0.45 : 0.25),
              blurRadius: _hovered ? 28 : 18,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (value) => setState(() => _hovered = value),
          onFocusChange: (value) => setState(() => _focused = value),
          borderRadius: radius,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: foreground.withValues(alpha: 0.12),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: widget.compact ? 44 : 52),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? AppSpacing.md : AppSpacing.lg,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 18, color: foreground),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(widget.label, style: style),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
