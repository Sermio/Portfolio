# CLAUDE.md

Personal portfolio of Sergio Miguel Trabajo built with Flutter (web first, deployed to Firebase Hosting at https://sergio-mt-flutter-portfolio.web.app/). Shows about me, experience, skills, languages and a filterable list of projects with screenshot carousels. Forked and adapted from adityathakurxd/flutter_portfolio. See `README.md`.

## Layout
- `lib/data/data.dart` — all content: personal info, experience texts, `skillsList`, `languagesList` and `projectList`.
- `lib/models/` — `Project` (name, description, link, images), `Skill`.
- `lib/components/` — page sections (header, navigation, projects list, filter, skills, references, slideshow…).
- `lib/screens/home_screen.dart` and `lib/screens/widgets/project_widget.dart` (project card with carousel).
- `lib/theme/`, `lib/providers/theme_provider.dart`, `lib/utils/`, `lib/widgets/`.
- `assets/images/<Project>/N.jpg|png` — screenshots per project (phone size, 1080×2400 for recent ones).
- `.skills/` — modular AI rules referenced by `.cursorrules`.

## Commands
- `flutter pub get`, `flutter analyze`, `flutter test`
- `flutter run -d chrome`; deploy: `flutter build web` then `firebase deploy --only hosting`.
- Versions: see `pubspec.yaml` and `flutter --version`.

## Adding a project
1. Put screenshots in `assets/images/<FolderName>/1.jpg, 2.jpg…`.
2. Declare the folder in `pubspec.yaml` under `flutter.assets` (each subfolder must be listed).
3. Add a `Project` to `projectList` in `lib/data/data.dart`. Mention the technologies in the description: `ProjectFilter` filters by searching tech names in name + description.
4. `test/project_data_test.dart` checks that every image path exists and its folder is declared.

## Modularity and reuse
- Search `lib/components/` and `lib/widgets/` before creating a widget; reuse `ProjectWidget`, `AnimatedSection`, etc.
- Extract anything used twice into a shared component.
- Keep files focused; keep content in `lib/data/` and logic out of widgets.
