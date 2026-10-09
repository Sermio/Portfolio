import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/data.dart';

void main() {
  final pubspec = File('pubspec.yaml').readAsStringSync();

  for (final project in projectList) {
    test('${project.name} has screenshots that exist and are declared', () {
      expect(project.images, isNotEmpty);
      expect(project.link, startsWith('https://github.com/Sermio/'));
      for (final image in project.images) {
        expect(File(image).existsSync(), isTrue, reason: '$image is missing');
        final folder = image.substring(0, image.lastIndexOf('/') + 1);
        expect(pubspec, contains('- $folder'),
            reason: '$folder is not declared in pubspec.yaml');
      }
    });
  }

  test('icons exist and store links point to Google Play', () {
    for (final project in projectList) {
      final icon = project.icon;
      if (icon != null) {
        expect(File(icon).existsSync(), isTrue, reason: '$icon is missing');
      }
      final store = project.playStoreUrl;
      if (store != null) {
        expect(icon, isNotNull, reason: '${project.name} needs an icon');
        expect(store, startsWith('https://play.google.com/store/apps/'));
      }
    }
  });

  test('project names are unique', () {
    final names = projectList.map((p) => p.name).toList();
    expect(names.toSet().length, names.length);
  });
}
