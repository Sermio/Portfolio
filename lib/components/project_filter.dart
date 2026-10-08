import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/widgets/tech_chip.dart';

/// Search field and single-choice technology chips. Stateless: the parent
/// owns the query and the selected technology.
class ProjectFilter extends StatelessWidget {
  const ProjectFilter({
    super.key,
    required this.controller,
    required this.technologies,
    required this.selectedTechnology,
    required this.onTechnologySelected,
    required this.resultCount,
  });

  final TextEditingController controller;
  final List<String> technologies;
  final String? selectedTechnology;
  final ValueChanged<String?> onTechnologySelected;
  final int resultCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMobile = context.screenSize.isMobile;

    final search = TextField(
      controller: controller,
      style: textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search by name or technology',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, _) => value.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: 'Clear search',
                  icon: const Icon(Icons.close_rounded, size: 18),
                  onPressed: controller.clear,
                ),
        ),
      ),
    );

    final count = Text(
      '$resultCount ${resultCount == 1 ? 'project' : 'projects'}',
      style: textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          label: 'Search projects',
          textField: true,
          child: isMobile
              ? search
              : Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: SizedBox(width: double.infinity, child: search),
                    ),
                    const Spacer(),
                    count,
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            TechChip(
              label: 'All',
              selected: selectedTechnology == null,
              onTap: () => onTechnologySelected(null),
            ),
            for (final tech in technologies)
              TechChip(
                label: tech,
                selected: selectedTechnology == tech,
                onTap: () => onTechnologySelected(
                    selectedTechnology == tech ? null : tech),
              ),
          ],
        ),
        if (isMobile) ...[
          const SizedBox(height: AppSpacing.md),
          count,
        ],
      ],
    );
  }
}
