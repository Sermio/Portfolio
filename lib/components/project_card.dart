import 'package:flutter/material.dart';
import 'package:portfolio/components/cover_flow_carousel.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/project_search.dart';
import 'package:portfolio/widgets/glass_card.dart';
import 'package:portfolio/widgets/project_icon.dart';
import 'package:portfolio/widgets/tech_chip.dart';

/// Compact project tile: browsable screenshots, name, technologies and a short
/// description. Tapping it calls [onTap] (select it in the showcase).
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.selected,
    required this.onTap,
  });

  static const double _carouselHeight = 360;
  static const int _descriptionLines = 3;

  final Project project;
  final bool selected;
  final VoidCallback onTap;

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

    return Semantics(
      button: true,
      selected: selected,
      label: 'Show ${project.name} above',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: GlassCard(
            hoverable: true,
            highlighted: selected,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg)),
                  child: Container(
                    height: _carouselHeight,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, 0.2),
                        radius: 0.8,
                        colors: [
                          AppColors.orange.withValues(alpha: 0.14),
                          AppColors.surfaceRaised,
                        ],
                      ),
                    ),
                    // Arrows bring the next photo to the middle; tapping the
                    // middle photo selects the project like the rest of the card.
                    child: Stack(
                      children: [
                        CoverFlowCarousel(
                          images: project.images,
                          projectName: project.name,
                          onCenterTap: onTap,
                        ),
                        Positioned(
                          right: AppSpacing.md,
                          bottom: AppSpacing.md,
                          child: ProjectIcon(project: project),
                        ),
                      ],
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
                        child: Text(
                          project.description,
                          style: descriptionStyle,
                          maxLines: _descriptionLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
