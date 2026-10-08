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

  test('project names are unique', () {
    final names = projectList.map((p) => p.name).toList();
    expect(names.toSet().length, names.length);
  });
}
