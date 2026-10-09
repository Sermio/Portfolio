import 'package:flutter/foundation.dart';

@immutable
class Project {
  const Project({
    required this.name,
    required this.description,
    required this.link,
    required this.images,
    this.icon,
    this.playStoreUrl,
  });

  final String name;

  /// Mentions the technologies used: the project filter searches them here.
  final String description;
  final String link;
  final List<String> images;

  /// Asset path of the app icon (`assets/icons/<name>.png`), if any.
  final String? icon;

  /// Google Play page; only set for published apps.
  final String? playStoreUrl;
}
