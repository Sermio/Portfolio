import 'package:flutter/material.dart';
import 'package:portfolio/components/screenshot_carousel.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_layout.dart';

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
        // Tapping anywhere that is not the image or a button closes the gallery.
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(dialogContext).pop(),
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
        ),
      );
    },
  );
}
