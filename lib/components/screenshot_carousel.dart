import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Swipeable screenshots with previous/next buttons and a page indicator.
/// Used in the full-screen gallery; the picture swallows taps so the gallery
/// can close when the backdrop is tapped.
class ScreenshotCarousel extends StatefulWidget {
  const ScreenshotCarousel({
    super.key,
    required this.images,
    required this.projectName,
    this.initialPage = 0,
    this.autofocus = false,
  });

  final List<String> images;
  final String projectName;
  final int initialPage;

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
                  ),
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
                        onPressed: _page > 0 ? () => _goTo(_page - 1) : null,
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
                      child: CarouselPageIndicator(
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

/// One screenshot sized to its real aspect ratio, so only the picture itself
/// (not the empty space around it) swallows taps.
class _Screenshot extends StatefulWidget {
  const _Screenshot({
    required this.path,
    required this.cacheHeight,
    required this.label,
  });

  final String path;
  final int cacheHeight;
  final String label;

  @override
  State<_Screenshot> createState() => _ScreenshotState();
}

class _ScreenshotState extends State<_Screenshot> {
  late final ImageStreamListener _listener = ImageStreamListener(
    (info, _) {
      final ratio = info.image.width / info.image.height;
      if (mounted && ratio != _ratio) setState(() => _ratio = ratio);
    },
    onError: (_, __) {
      if (mounted) setState(() => _failed = true);
    },
  );
  ImageStream? _stream;
  double? _ratio;
  bool _failed = false;

  ImageProvider get _provider => widget.cacheHeight > 0
      ? ResizeImage(AssetImage(widget.path), height: widget.cacheHeight)
      : AssetImage(widget.path);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stream?.removeListener(_listener);
    _stream = _provider.resolve(createLocalImageConfiguration(context))
      ..addListener(_listener);
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return const Center(
        child: Icon(Icons.broken_image_outlined, color: AppColors.textMuted),
      );
    }
    final ratio = _ratio;
    final image = Image(
      image: _provider,
      fit: ratio == null ? BoxFit.contain : BoxFit.fill,
      semanticLabel: widget.label,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xxl, AppSpacing.lg, AppSpacing.xxl, AppSpacing.xxl),
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: ratio == null
              ? image
              : AspectRatio(aspectRatio: ratio, child: image),
        ),
      ),
    );
  }
}

/// Round prev/next button laid over a carousel.
class CarouselArrowButton extends StatelessWidget {
  const CarouselArrowButton({
    super.key,
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

/// Dots (or "n / total" for long sets) showing the current page.
class CarouselPageIndicator extends StatelessWidget {
  const CarouselPageIndicator(
      {super.key, required this.page, required this.count});

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
