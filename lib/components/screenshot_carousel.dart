import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Swipeable screenshots with previous/next buttons and a page indicator.
/// Used inside project cards and in the full-screen gallery.
class ScreenshotCarousel extends StatefulWidget {
  const ScreenshotCarousel({
    super.key,
    required this.images,
    required this.projectName,
    this.initialPage = 0,
    this.onImageTap,
    this.autofocus = false,
  });

  final List<String> images;
  final String projectName;
  final int initialPage;

  /// Called with the current index when a screenshot is tapped.
  final ValueChanged<int>? onImageTap;

  /// Takes keyboard focus so arrow keys change the page (gallery mode).
  final bool autofocus;

  @override
  State<ScreenshotCarousel> createState() => _ScreenshotCarouselState();
}

class _ScreenshotCarouselState extends State<ScreenshotCarousel> {
  late final PageController _controller =
      PageController(initialPage: widget.initialPage);
  late int _page = widget.initialPage;

  bool get _hasMany => widget.images.length > 1;

  void _goTo(int page) {
    final target = page.clamp(0, widget.images.length - 1);
    if (context.reduceMotion) {
      _controller.jumpToPage(target);
    } else {
      _controller.animateToPage(target,
          duration: AppDurations.medium, curve: Curves.easeOutCubic);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            _goTo(_page - 1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            _goTo(_page + 1),
      },
      child: Focus(
        autofocus: widget.autofocus,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cacheHeight =
                (constraints.maxHeight * MediaQuery.devicePixelRatioOf(context))
                    .round();
            return Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: widget.images.length,
                  onPageChanged: (page) => setState(() => _page = page),
                  itemBuilder: (context, index) => _Screenshot(
                    path: widget.images[index],
                    cacheHeight: cacheHeight,
                    label:
                        '${widget.projectName} screenshot ${index + 1} of ${widget.images.length}',
                    onTap: widget.onImageTap == null
                        ? null
                        : () => widget.onImageTap!(index),
                  ),
                ),
                if (_hasMany) ...[
                  Positioned(
                    left: AppSpacing.sm,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _ArrowButton(
                        icon: Icons.chevron_left_rounded,
                        tooltip: 'Previous screenshot',
                        onPressed: _page > 0 ? () => _goTo(_page - 1) : null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: AppSpacing.sm,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _ArrowButton(
                        icon: Icons.chevron_right_rounded,
                        tooltip: 'Next screenshot',
                        onPressed: _page < widget.images.length - 1
                            ? () => _goTo(_page + 1)
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: AppSpacing.md,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: _PageIndicator(
                        page: _page,
                        count: widget.images.length,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Screenshot extends StatelessWidget {
  const _Screenshot({
    required this.path,
    required this.cacheHeight,
    required this.label,
    this.onTap,
  });

  final String path;
  final int cacheHeight;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final image = Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xxl, AppSpacing.lg, AppSpacing.xxl, AppSpacing.xxl),
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        cacheHeight: cacheHeight > 0 ? cacheHeight : null,
        semanticLabel: label,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.broken_image_outlined, color: AppColors.textMuted),
        ),
      ),
    );
    if (onTap == null) return image;
    return MouseRegion(
      cursor: SystemMouseCursors.zoomIn,
      child: GestureDetector(onTap: onTap, child: image),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: onPressed == null ? 0.3 : 1,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(icon),
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        style: IconButton.styleFrom(
          backgroundColor: AppColors.background.withValues(alpha: 0.7),
          disabledBackgroundColor: AppColors.background.withValues(alpha: 0.7),
          foregroundColor: AppColors.text,
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.page, required this.count});

  final int page;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Screenshot ${page + 1} of $count',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 2, vertical: AppSpacing.xs + 2),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.border),
        ),
        child: count > 8
            ? Text(
                '${page + 1} / $count',
                style: Theme.of(context).textTheme.labelMedium,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < count; i++)
                    AnimatedContainer(
                      duration: AppDurations.medium,
                      width: i == page ? 18 : 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: i == page ? AppColors.brandGradient : null,
                        color: i == page
                            ? null
                            : AppColors.text.withValues(alpha: 0.35),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
