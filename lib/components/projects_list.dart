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

    final isLargeScreen = screenWidth > 1200;
    final contentWidth = isLargeScreen ? screenWidth * 0.85 : screenWidth * 0.9;
    
    return Center(
      child: SizedBox(
        width: contentWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  Icon(
                    Icons.folder_special_outlined,
                    color: AppTheme.primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Projects',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calcular dinámicamente cuántas columnas caben
                  final availableWidth = constraints.maxWidth;
                  // Ancho mínimo estimado por card (considerando márgenes y spacing)
                  // Con aspectRatio 1.25, si la altura es ~400px, el ancho sería ~320px
                  // Pero necesitamos considerar márgenes (8px * 2 = 16px) y spacing (16px)
                  const minCardWidth = 450.0; // Ancho mínimo cómodo para cada card
                  const spacing = 16.0; // Espacio entre cards
                  
                  // Calcular cuántas columnas caben realmente
                  int crossAxisCount = (availableWidth / (minCardWidth + spacing)).floor();
                  
                  // Asegurar mínimo 1 y máximo razonable
                  crossAxisCount = crossAxisCount.clamp(1, 4);
                  
                  // Si hay espacio para al menos 1.5 cards, mostrar mínimo 2
                  if (availableWidth >= minCardWidth * 1.5) {
                    crossAxisCount = crossAxisCount.clamp(2, 4);
                  }
                  
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: crossAxisCount > 2 ? 1.2 : 1.25,
                    ),
                    itemCount: projectList.length,
                    itemBuilder: (context, index) {
                      return ProjectWidget(
                        project: projectList[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
