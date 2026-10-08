import 'package:portfolio/models/project_model.dart';

/// Technologies from [candidates] mentioned in the project name or
/// description, in the order of [candidates]. Matches whole words only, so
/// "Java" does not match "JavaScript".
List<String> technologiesOf(Project project, List<String> candidates) {
  final text = '${project.name} ${project.description}';
  return [
    for (final tech in candidates)
      if (_wordPattern(tech).hasMatch(text)) tech,
  ];
}

/// Projects matching a free-text [query] (name or description) and, when
/// given, mentioning [technology].
List<Project> filterProjects(
  List<Project> projects, {
  String query = '',
  String? technology,
}) {
  final needle = query.trim().toLowerCase();
  final techPattern = technology == null ? null : _wordPattern(technology);
  return [
    for (final project in projects)
      if ((needle.isEmpty ||
              project.name.toLowerCase().contains(needle) ||
              project.description.toLowerCase().contains(needle)) &&
          (techPattern == null ||
              techPattern.hasMatch('${project.name} ${project.description}')))
        project,
  ];
}

/// Technologies from [candidates] used by at least one of [projects].
List<String> usedTechnologies(List<Project> projects, List<String> candidates) {
  return [
    for (final tech in candidates)
      if (projects.any((p) => technologiesOf(p, [tech]).isNotEmpty)) tech,
  ];
}

RegExp _wordPattern(String word) =>
    RegExp('(?<![\\w])${RegExp.escape(word)}(?![\\w])', caseSensitive: false);
