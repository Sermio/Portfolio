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

  /// Whether the nearest [AnimatedSection] above [context] has been revealed.
  /// True when there is none or when motion is reduced, so content that waits
  /// for it never stays hidden. Registers [context] to rebuild on reveal.
  static bool isRevealed(BuildContext context) {
    if (context.reduceMotion) return true;
    final scope = context.dependOnInheritedWidgetOfExactType<_RevealScope>();
    return scope?.revealed ?? true;
  }

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _RevealScope extends InheritedWidget {
  const _RevealScope({required this.revealed, required super.child});

  final bool revealed;

  @override
  bool updateShouldNotify(_RevealScope oldWidget) =>
      revealed != oldWidget.revealed;
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
  bool _revealed = false;

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
      setState(() => _revealed = true);
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
    return _RevealScope(
      revealed: _revealed,
      child: AnimatedBuilder(
        animation: _progress,
        builder: (context, child) => Opacity(
          opacity: _progress.value,
          child: Transform.translate(
            offset: Offset(0, 28 * (1 - _progress.value)),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
