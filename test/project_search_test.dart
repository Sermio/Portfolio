import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/utils/project_search.dart';

const _flutterApp = Project(
  name: 'Wallet',
  description: 'Built with Flutter and Firebase.',
  link: 'https://github.com/Sermio/a',
  images: [],
);
const _webApp = Project(
  name: 'Panel',
  description: 'A JavaScript dashboard made with Vue.',
  link: 'https://github.com/Sermio/b',
  images: [],
);
const _projects = [_flutterApp, _webApp];

void main() {
  group('technologiesOf', () {
    test('returns mentioned technologies in candidate order', () {
      expect(technologiesOf(_flutterApp, ['Firebase', 'Flutter', 'Vue']),
          ['Firebase', 'Flutter']);
    });

    test('matches whole words only', () {
      expect(technologiesOf(_webApp, ['Java']), isEmpty);
    });
  });

  group('filterProjects', () {
    test('returns everything without filters', () {
      expect(filterProjects(_projects), _projects);
    });

    test('searches name and description case-insensitively', () {
      expect(filterProjects(_projects, query: 'panel'), [_webApp]);
      expect(filterProjects(_projects, query: '  FIREBASE '), [_flutterApp]);
    });

    test('filters by technology and combines with the query', () {
      expect(filterProjects(_projects, technology: 'Vue'), [_webApp]);
      expect(filterProjects(_projects, query: 'wallet', technology: 'Vue'),
          isEmpty);
    });
  });

  test('usedTechnologies drops technologies no project mentions', () {
    expect(usedTechnologies(_projects, ['Flutter', 'Kotlin', 'Vue']),
        ['Flutter', 'Vue']);
  });
}
