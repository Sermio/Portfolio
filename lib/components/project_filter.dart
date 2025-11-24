import 'package:flutter/material.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_theme.dart';

class ProjectFilter extends StatefulWidget {
  final Function(List<Project>) onFilterChanged;

  const ProjectFilter({super.key, required this.onFilterChanged});

  @override
  State<ProjectFilter> createState() => _ProjectFilterState();
}

class _ProjectFilterState extends State<ProjectFilter> {
  String _searchQuery = '';
  final List<String> _technologies = [
    'Flutter',
    'Dart',
    'Vue',
    'Python',
    'React Native',
    'Kotlin',
    'Java',
  ];
  final Set<String> _selectedTechnologies = {};

  @override
  void initState() {
    super.initState();
    // Retrasar la aplicación del filtro hasta después del primer frame
    // para evitar problemas de layout durante el build inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _applyFilter();
      }
    });
  }

  void _applyFilter() {
    List<Project> filtered = projectList.where((project) {
      // Filtrar por búsqueda de texto
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!project.name.toLowerCase().contains(query) &&
            !project.description.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Filtrar por tecnologías
      if (_selectedTechnologies.isNotEmpty) {
        final projectText = '${project.name} ${project.description}'.toLowerCase();
        final hasSelectedTech = _selectedTechnologies.any((tech) =>
            projectText.contains(tech.toLowerCase()));
        if (!hasSelectedTech) {
          return false;
        }
      }

      return true;
    }).toList();

    widget.onFilterChanged(filtered);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_list, color: AppTheme.primaryColor),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Filtrar proyectos',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar proyectos...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceVariant,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                _applyFilter();
              });
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _technologies.map((tech) {
              final isSelected = _selectedTechnologies.contains(tech);
              return FilterChip(
                label: Text(tech),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedTechnologies.add(tech);
                    } else {
                      _selectedTechnologies.remove(tech);
                    }
                    _applyFilter();
                  });
                },
                selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                checkmarkColor: AppTheme.primaryColor,
              );
            }).toList(),
          ),
          if (_selectedTechnologies.isNotEmpty || _searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedTechnologies.clear();
                    _searchQuery = '';
                    _applyFilter();
                  });
                },
                icon: const Icon(Icons.clear, size: 18),
                label: const Text('Limpiar filtros'),
              ),
            ),
        ],
      ),
    );
  }
}


