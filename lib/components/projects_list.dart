import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/screens/widgets/project_widget.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/extensions.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = context.screenConstraint().width;

    return Center(
      child: SizedBox(
        width: screenWidth > 1200 ? 1200 : screenWidth * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.15),
                          AppTheme.secondaryColor.withOpacity(0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.folder_special_outlined,
                      color: AppTheme.primaryColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Projects',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: projectList.map((project) {
                  return ProjectWidget(
                    project: project,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
