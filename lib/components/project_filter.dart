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
      padding: const EdgeInsets.all(AppSpacing.lg),
      margin: const EdgeInsets.only(bottom: AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.filter_list,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Filtrar proyectos',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar proyectos...',
              prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.dividerColor.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.dividerColor.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceVariant,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                selectedColor: AppTheme.primaryColor.withOpacity(0.15),
                checkmarkColor: AppTheme.primaryColor,
                labelStyle: theme.textTheme.bodyMedium,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : theme.dividerColor.withOpacity(0.3),
                  width: isSelected ? 1.5 : 1,
                ),
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


