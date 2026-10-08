import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Floating button that appears after scrolling down and calls [onPressed].
class ScrollToTopButton extends StatefulWidget {
  const ScrollToTopButton({
    super.key,
    required this.controller,
    required this.onPressed,
  });

  final ScrollController controller;
  final VoidCallback onPressed;

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final visible = widget.controller.offset > 700;
    if (visible != _visible) setState(() => _visible = visible);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        duration: AppDurations.medium,
        opacity: _visible ? 1 : 0,
        child: AnimatedScale(
          duration: AppDurations.medium,
          scale: _visible ? 1 : 0.8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.brandGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.orange.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: IconButton(
              tooltip: 'Back to top',
              onPressed: widget.onPressed,
              color: AppColors.onAccent,
              constraints: const BoxConstraints(minWidth: 52, minHeight: 52),
              icon: const Icon(Icons.arrow_upward_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
