import 'package:flutter/foundation.dart';

@immutable
class Project {
  const Project({
    required this.name,
    required this.description,
    required this.link,
    required this.images,
  });

  final String name;

  /// Mentions the technologies used: the project filter searches them here.
  final String description;
  final String link;
  final List<String> images;
}
