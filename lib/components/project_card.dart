import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/components/screenshot_carousel.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';
import 'package:portfolio/utils/project_search.dart';
import 'package:portfolio/widgets/glass_card.dart';
import 'package:portfolio/widgets/tech_chip.dart';

/// Project tile: screenshot carousel, name, technologies, description and
/// actions. Tapping a screenshot opens the full-screen gallery.
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  static const double _carouselHeight = 380;
  static const int _descriptionLines = 4;

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final descriptionStyle =
        textTheme.bodyMedium!.copyWith(color: AppColors.textMuted);
    final descriptionHeight =
        MediaQuery.textScalerOf(context).scale(descriptionStyle.fontSize!) *
            descriptionStyle.height! *
            _descriptionLines;
    final technologies =
        technologiesOf(project, projectTechnologies).take(3).toList();

    return GlassCard(
      hoverable: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            child: Container(
              height: _carouselHeight,
              color: AppColors.surfaceRaised,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.55,
                    colors: [
                      AppColors.orange.withValues(alpha: 0.07),
                      AppColors.orange.withValues(alpha: 0),
                    ],
                  ),
                ),
                child: ScreenshotCarousel(
                  images: project.images,
                  projectName: project.name,
                  onImageTap: (index) =>
                      showProjectGallery(context, project, index),
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.name,
                    style: textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: AppSpacing.sm + 2),
                SizedBox(
                  height: 28,
                  child: Row(
                    children: [
                      for (final tech in technologies) ...[
                        Flexible(child: TechChip(label: tech)),
                        const SizedBox(width: AppSpacing.sm - 2),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: descriptionHeight,
                  child: Tooltip(
                    message: project.description,
                    waitDuration: const Duration(milliseconds: 600),
                    child: Text(
                      project.description,
                      style: descriptionStyle,
                      maxLines: _descriptionLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    _CardAction(
                      icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                      label: 'Code',
                      onPressed: () => openLink(Uri.parse(project.link)),
                    ),
                    _CardAction(
                      icon: const Icon(Icons.fullscreen_rounded, size: 20),
                      label: 'Screenshots (${project.images.length})',
                      onPressed: () => showProjectGallery(context, project, 0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({
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

/// Full-screen screenshot gallery for [project], starting at [initialIndex].
Future<void> showProjectGallery(
    BuildContext context, Project project, int initialIndex) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.85),
    builder: (dialogContext) {
      final textTheme = Theme.of(dialogContext).textTheme;
      return Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg, AppSpacing.md, AppSpacing.sm, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(project.name,
                          style: textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      iconSize: 28,
                      constraints:
                          const BoxConstraints(minWidth: 48, minHeight: 48),
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ScreenshotCarousel(
                  images: project.images,
                  projectName: project.name,
                  initialPage: initialIndex,
                  autofocus: true,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
