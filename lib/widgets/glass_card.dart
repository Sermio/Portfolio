import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Dark translucent card with a subtle border. When [hoverable], it lifts
/// and gets an orange glow while the pointer is over it.
class GlassCard extends StatefulWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.hoverable = false,
    this.highlighted = false,
    this.radius = AppRadius.lg,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool hoverable;

  /// Keeps the hover look on (e.g. the selected card of a list).
  final bool highlighted;
  final double radius;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = (widget.hoverable && _hovered) || widget.highlighted;
    final lift = widget.hoverable && _hovered && !context.reduceMotion;
    return MouseRegion(
      onEnter: widget.hoverable ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.hoverable ? (_) => setState(() => _hovered = false) : null,
      child: AnimatedContainer(
        duration: AppDurations.medium,
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, lift ? -4 : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: active ? AppColors.surfaceRaised : AppColors.surface,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(
            color: active
                ? AppColors.orange.withValues(alpha: 0.55)
                : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: active
                  ? AppColors.orange.withValues(alpha: 0.16)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: active ? 40 : 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
