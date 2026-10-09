import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/components/project_gallery.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';
import 'package:portfolio/utils/project_search.dart';
import 'package:portfolio/widgets/project_icon.dart';
import 'package:portfolio/widgets/tech_chip.dart';

/// Large stage for one project: title, technologies, description, actions and
/// a draggable strip with its screenshots at near full size. Tapping a
/// screenshot opens the full-screen gallery.
class ProjectShowcase extends StatelessWidget {
  const ProjectShowcase({super.key, required this.project});

  final Project project;

  static double stripHeight(ScreenSize size) => switch (size) {
        ScreenSize.mobile => 420,
        ScreenSize.tablet => 500,
        ScreenSize.desktop => 560,
      };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = context.screenSize;
    final technologies = technologiesOf(project, projectTechnologies);
    final pad = size.isMobile ? AppSpacing.md : AppSpacing.xl;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        gradient: RadialGradient(
          center: const Alignment(0, 0.6),
          radius: 1.1,
          colors: [
            AppColors.orange.withValues(alpha: 0.14),
            AppColors.surface,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(pad, pad, pad, AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(project.name,
                          style: size.isMobile
                              ? textTheme.headlineSmall
                              : textTheme.headlineMedium),
                    ),
                    if (project.icon != null) ...[
                      const SizedBox(width: AppSpacing.md),
                      ProjectIcon(project: project, size: 44),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final tech in technologies) TechChip(label: tech),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Text(
                    project.description,
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    _Action(
                      icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                      label: 'Code',
                      onPressed: () => openLink(Uri.parse(project.link)),
                    ),
                    _Action(
                      icon: const Icon(Icons.fullscreen_rounded, size: 20),
                      label: 'Screenshots (${project.images.length})',
                      onPressed: () => showProjectGallery(context, project, 0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _ScreenshotStrip(
            project: project,
            height: stripHeight(size),
            padding: pad,
          ),
        ],
      ),
    );
  }
}

class _ScreenshotStrip extends StatefulWidget {
  const _ScreenshotStrip({
    required this.project,
    required this.height,
    required this.padding,
  });

  final Project project;
  final double height;
  final double padding;

  @override
  State<_ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<_ScreenshotStrip> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final images = widget.project.images;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      // Mouse drag is off by default for scrollables: enable it, plus a bar.
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: PointerDeviceKind.values.toSet(),
          scrollbars: false,
        ),
        child: Scrollbar(
          controller: _controller,
          thumbVisibility: true,
          child: SizedBox(
            height: widget.height + AppSpacing.md,
            child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(
                  widget.padding, 0, widget.padding, AppSpacing.md),
              itemCount: images.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) => MouseRegion(
                cursor: SystemMouseCursors.zoomIn,
                child: GestureDetector(
                  key: ValueKey('screenshot-$index'),
                  onTap: () =>
                      showProjectGallery(context, widget.project, index),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                          color: AppColors.text.withValues(alpha: 0.18)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.45),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.md - 1),
                      child: Image.asset(
                        images[index],
                        height: widget.height,
                        fit: BoxFit.fitHeight,
                        cacheHeight: (widget.height * dpr).round(),
                        semanticLabel:
                            '${widget.project.name} screenshot ${index + 1} of ${images.length}',
                        errorBuilder: (_, __, ___) => SizedBox(
                          width: widget.height * 0.45,
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

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.text,
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
