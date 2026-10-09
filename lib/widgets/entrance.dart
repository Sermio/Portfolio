import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Plays an `animate_do` entrance as soon as it is built, for content that is
/// already on screen at load (the hero). Shows [child] untouched when the
/// platform asks to reduce motion.
class Entrance extends StatelessWidget {
  /// Fades the child in while sliding it up by [from] pixels.
  const Entrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.from = 20,
  }) : zoom = false;

  /// Scales the child in with a soft overshoot.
  const Entrance.zoom({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  })  : zoom = true,
        from = 0;

  final Widget child;

  /// Wait before the animation starts, used to stagger siblings.
  final Duration delay;
  final double from;
  final bool zoom;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    // Its own layer: animating it moves a cached texture instead of
    // repainting blurred shadows and gradient text on every frame.
    final layer = RepaintBoundary(child: child);
    return zoom
        ? ZoomIn(
            delay: delay,
            duration: const Duration(milliseconds: 550),
            curve: Curves.easeOutBack,
            child: layer,
          )
        : FadeInUp(
            delay: delay,
            from: from,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutCubic,
            child: layer,
          );
  }
}
