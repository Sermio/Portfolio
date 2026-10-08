import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Fades and slides [child] in the first time it scrolls into view.
/// Shows it immediately when the platform asks to reduce motion.
class AnimatedSection extends StatefulWidget {
  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;

  /// Extra wait before the animation starts, used to stagger siblings.
  final Duration delay;

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.reveal + widget.delay,
  );
  late final Animation<double> _progress = CurvedAnimation(
    parent: _controller,
    curve: Interval(
      widget.delay.inMilliseconds / _controller.duration!.inMilliseconds,
      1,
      curve: Curves.easeOutCubic,
    ),
  );
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position != _position) {
      _position?.removeListener(_checkVisibility);
      _position = position?..addListener(_checkVisibility);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (!mounted || _controller.status != AnimationStatus.dismissed) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < MediaQuery.sizeOf(context).height * 0.92) {
      _position?.removeListener(_checkVisibility);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return widget.child;
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) => Opacity(
        opacity: _progress.value,
        child: Transform.translate(
          offset: Offset(0, 28 * (1 - _progress.value)),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
