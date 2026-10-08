import 'package:flutter/material.dart';
import 'package:portfolio/components/project_card.dart';
import 'package:portfolio/components/project_filter.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/project_search.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/page_section.dart';
import 'package:portfolio/widgets/responsive_wrap.dart';
import 'package:portfolio/widgets/section_header.dart';

/// Filterable grid of [projectList].
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final _searchController = TextEditingController();
  final _technologies = usedTechnologies(projectList, projectTechnologies);
  String? _technology;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final projects = filterProjects(
      projectList,
      query: _searchController.text,
      technology: _technology,
    );

    return PageSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AnimatedSection(
            child: SectionHeader(
              eyebrow: 'Projects',
              title: 'Things I have built',
              subtitle:
                  'Apps, games and tools, most of them in Flutter. Tap a screenshot to open the gallery.',
            ),
          ),
          AnimatedSection(
            child: ProjectFilter(
              controller: _searchController,
              technologies: _technologies,
              selectedTechnology: _technology,
              onTechnologySelected: (tech) =>
                  setState(() => _technology = tech),
              resultCount: projects.length,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (projects.isEmpty)
            const _EmptyState()
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = switch (size) {
                  ScreenSize.mobile => 1,
                  ScreenSize.tablet => 2,
                  ScreenSize.desktop => constraints.maxWidth >= 1100 ? 3 : 2,
                };
                return ResponsiveWrap(
                  columns: columns,
                  spacing: AppSpacing.lg,
                  runSpacing: AppSpacing.lg,
                  children: [
                    for (final (index, project) in projects.indexed)
                      AnimatedSection(
                        key: ValueKey(project.name),
                        delay: Duration(milliseconds: 70 * (index % columns)),
                        child: ProjectCard(project: project),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded,
              size: 40, color: AppColors.textMuted),
          const SizedBox(height: AppSpacing.md),
          Text('No projects match your search', style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Try another word or pick a different technology.',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
