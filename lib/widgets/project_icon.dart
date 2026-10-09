import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/utils/links.dart';

/// App icon of [project]. Opens its Google Play page when it is published.
/// Renders nothing when the project has no icon or the file is missing.
class ProjectIcon extends StatelessWidget {
  const ProjectIcon({super.key, required this.project, this.size = 56});

  final Project project;
  final double size;

  @override
  Widget build(BuildContext context) {
    final icon = project.icon;
    if (icon == null) return const SizedBox.shrink();

    final storeUrl = project.playStoreUrl;
    final image = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22 - 1),
        child: Image.asset(
          icon,
          width: size,
          height: size,
          fit: BoxFit.cover,
          cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
          semanticLabel: '${project.name} app icon',
          errorBuilder: (_, __, ___) => SizedBox.square(dimension: size),
        ),
      ),
    );
    if (storeUrl == null) return image;

    return Semantics(
      button: true,
      label: 'Get ${project.name} on Google Play',
      child: Tooltip(
        message: 'Get it on Google Play',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => openLink(Uri.parse(storeUrl)),
            child: image,
          ),
        ),
      ),
    );
  }
}
