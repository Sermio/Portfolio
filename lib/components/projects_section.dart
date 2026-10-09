import 'package:flutter/material.dart';
import 'package:portfolio/components/project_card.dart';
import 'package:portfolio/components/project_filter.dart';
import 'package:portfolio/components/project_showcase.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/project_search.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/page_section.dart';
import 'package:portfolio/widgets/responsive_wrap.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/tech_chip.dart';

/// Filterable showcase of [projectList].
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final _searchController = TextEditingController();
  final _technologies = usedTechnologies(projectList, projectTechnologies);
  String? _technology;
  final _showcaseKey = GlobalKey();
  String? _selected;

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

  /// Selects [project] from the grid and brings the showcase into view.
  void _showcase(Project project) {
    setState(() => _selected = project.name);
    final showcase = _showcaseKey.currentContext;
    if (showcase == null) return;
    Scrollable.ensureVisible(
      showcase,
      alignment: 0.12,
      duration: context.reduceMotion ? Duration.zero : AppDurations.reveal,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final projects = filterProjects(
      projectList,
      query: _searchController.text,
      technology: _technology,
    );
    final selected = projects.isEmpty
        ? null
        : projects.firstWhere((p) => p.name == _selected,
            orElse: () => projects.first);

    return PageSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AnimatedSection(
            child: SectionHeader(
              eyebrow: 'Projects',
              title: 'Things I have built',
              subtitle:
                  'Apps, games and tools, most of them in Flutter. Pick one to see it up close, or browse them all below.',
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
          else ...[
            _Showcase(
              key: _showcaseKey,
              projects: projects,
              selected: selected!,
              onSelected: (p) => setState(() => _selected = p.name),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('All projects', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.lg),
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
                        child: ProjectCard(
                          project: project,
                          selected: project == selected,
                          onTap: () => _showcase(project),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

/// Project picker plus the [ProjectShowcase] of the selected one. A vertical
/// list beside the stage on desktop, a scrolling chip row above it elsewhere.
class _Showcase extends StatefulWidget {
  const _Showcase({
    super.key,
    required this.projects,
    required this.selected,
    required this.onSelected,
  });

  final List<Project> projects;
  final Project selected;
  final ValueChanged<Project> onSelected;

  @override
  State<_Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<_Showcase> {
  final _stageKey = GlobalKey();
  final _listController = ScrollController();
  double? _stageHeight;

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  /// The list is as tall as the stage, whatever the description length;
  /// measured after layout and re-measured on every rebuild.
  void _measureStage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final height = _stageKey.currentContext?.size?.height;
      if (mounted &&
          height != null &&
          (height - (_stageHeight ?? 0)).abs() > 0.5) {
        setState(() => _stageHeight = height);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final projects = widget.projects;
    final selected = widget.selected;
    final onSelected = widget.onSelected;
    final size = context.screenSize;
    final duration = context.reduceMotion ? Duration.zero : AppDurations.medium;
    final stage = AnimatedSection(
      child: AnimatedSwitcher(
        duration: duration,
        child: ProjectShowcase(
          key: ValueKey(selected.name),
          project: selected,
        ),
      ),
    );

    if (!size.isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: projects.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, i) => Center(
                child: TechChip(
                  label: projects[i].name,
                  selected: projects[i] == selected,
                  onTap: () => onSelected(projects[i]),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          stage,
        ],
      );
    }

    _measureStage();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 280,
          height: _stageHeight ?? ProjectShowcase.stripHeight(size) + 200,
          // Always-visible scrollbar: shows there are more projects to reach.
          child: Scrollbar(
            controller: _listController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _listController,
              padding: const EdgeInsets.only(right: AppSpacing.md),
              itemCount: projects.length,
              itemBuilder: (context, i) => _ProjectTile(
                number: i + 1,
                project: projects[i],
                selected: projects[i] == selected,
                onTap: () => onSelected(projects[i]),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xl),
        Expanded(child: KeyedSubtree(key: _stageKey, child: stage)),
      ],
    );
  }
}

class _ProjectTile extends StatelessWidget {
  const _ProjectTile({
    required this.number,
    required this.project,
    required this.selected,
    required this.onTap,
  });

  final int number;
  final Project project;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: selected ? AppColors.surfaceRaised : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(
                color: selected
                    ? AppColors.orange.withValues(alpha: 0.5)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Text(
                  number.toString().padLeft(2, '0'),
                  style: textTheme.labelMedium?.copyWith(
                    color:
                        selected ? AppColors.accentText : AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    project.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: selected ? AppColors.text : AppColors.textMuted,
                    ),
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
