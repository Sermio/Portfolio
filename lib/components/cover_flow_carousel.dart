import 'package:flutter/material.dart';
import 'package:portfolio/components/screenshot_carousel.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Looping screenshots: the current one big in front, its neighbours smaller,
/// dimmed and tucked slightly behind it. Arrows, dragging and tapping a
/// neighbour bring it to the front; tapping the front one calls [onCenterTap].
class CoverFlowCarousel extends StatefulWidget {
  const CoverFlowCarousel({
    super.key,
    required this.images,
    required this.projectName,
    required this.onCenterTap,
  });

  /// Screenshots are phone-shaped; used to place the neighbours.
  static const double _aspect = 0.45;

  /// Distance between neighbours and centre, as a share of the picture width
  /// (below 1 so they slide partly behind the middle one).
  static const double _stepFactor = 0.78;

  final List<String> images;
  final String projectName;
  final VoidCallback onCenterTap;

  @override
  State<CoverFlowCarousel> createState() => _CoverFlowCarouselState();
}

class _CoverFlowCarouselState extends State<CoverFlowCarousel>
    with SingleTickerProviderStateMixin {
  /// Position in "pictures": 0 shows the first one in front, 1.5 is halfway
  /// to the second. Unbounded so looping never has to jump back.
  late final _position = AnimationController.unbounded(vsync: this);

  int get _count => widget.images.length;
  bool get _hasMany => _count > 1;

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  void _moveTo(double target) {
    if (context.reduceMotion) {
      _position.value = target;
    } else {
      _position.animateTo(target,
          duration: AppDurations.medium, curve: Curves.easeOutCubic);
    }
  }

  void _shift(int by) => _moveTo(_position.value.round() + by.toDouble());

  /// Signed offset of picture [i] from the front one, wrapped so the shortest
  /// way round the loop is used.
  double _offset(int i, double position) {
    var d = (i - position) % _count;
    if (d > _count / 2) d -= _count;
    return d;
  }

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final pictureHeight = constraints.maxHeight - AppSpacing.lg - 56;
        final step = pictureHeight *
            CoverFlowCarousel._aspect *
            CoverFlowCarousel._stepFactor;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragUpdate:
              _hasMany ? (d) => _position.value -= d.delta.dx / step : null,
          onHorizontalDragEnd: _hasMany
              ? (d) {
                  final velocity = d.primaryVelocity ?? 0;
                  final fling = velocity.abs() > 300 ? -velocity.sign : 0.0;
                  _moveTo(_position.value.round() + fling);
                }
              : null,
          child: AnimatedBuilder(
            animation: _position,
            builder: (context, _) {
              final position = _position.value;
              final front = position.round() % _count;
              // Farthest first, so the front picture is painted last (on top).
              final order = [
                for (var i = 0; i < _count; i++)
                  if (_offset(i, position).abs() < 1.5) i,
              ]..sort((a, b) => _offset(b, position)
                  .abs()
                  .compareTo(_offset(a, position).abs()));

              return Stack(
                children: [
                  for (final i in order)
                    _Picture(
                      path: widget.images[i],
                      label:
                          '${widget.projectName} screenshot ${i + 1} of $_count',
                      height: pictureHeight,
                      cacheHeight: (pictureHeight * dpr).round(),
                      offset: _offset(i, position),
                      step: step,
                      onTap: i == front
                          ? widget.onCenterTap
                          : () => _shift(_offset(i, position).round()),
                    ),
                  if (_hasMany) ...[
                    Positioned(
                      left: AppSpacing.sm,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: CarouselArrowButton(
                          icon: Icons.chevron_left_rounded,
                          tooltip: 'Previous screenshot',
                          onPressed: () => _shift(-1),
                        ),
                      ),
                    ),
                    Positioned(
                      right: AppSpacing.sm,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: CarouselArrowButton(
                          icon: Icons.chevron_right_rounded,
                          tooltip: 'Next screenshot',
                          onPressed: () => _shift(1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: AppSpacing.md,
                      left: 0,
                      right: 0,
                      child: Center(
                        child:
                            CarouselPageIndicator(page: front, count: _count),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }
}

/// One picture placed [offset] pictures away from the front one.
class _Picture extends StatelessWidget {
  const _Picture({
    required this.path,
    required this.label,
    required this.height,
    required this.cacheHeight,
    required this.offset,
    required this.step,
    required this.onTap,
  });

  final String path;
  final String label;
  final double height;
  final int cacheHeight;
  final double offset;
  final double step;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final distance = offset.abs();
    final near = distance.clamp(0.0, 1.0);
    // Fade out completely between 1 and 1.5 so pictures leave smoothly.
    final fade = distance <= 1 ? 1.0 : (1.5 - distance) * 2;

    return Positioned(
      left: 0,
      right: 0,
      top: AppSpacing.lg,
      height: height,
      child: Center(
        child: Transform.translate(
          offset: Offset(offset * step, 0),
          child: Transform.scale(
            scale: 1 - 0.2 * near,
            child: Opacity(
              opacity: (1 - 0.35 * near) * fade,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTap,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: Image.asset(
                        path,
                        height: height,
                        fit: BoxFit.fitHeight,
                        cacheHeight: cacheHeight,
                        semanticLabel: label,
                        errorBuilder: (_, __, ___) => SizedBox(
                          width: height * CoverFlowCarousel._aspect,
                          child: const Icon(Icons.broken_image_outlined,
                              color: AppColors.textMuted),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
