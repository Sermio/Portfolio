# CLAUDE.md

Personal portfolio of Sergio Miguel Trabajo built with Flutter (web first, deployed to Firebase Hosting at https://sergio-mt-flutter-portfolio.web.app/). Shows about me, experience, skills, languages and a filterable list of projects with screenshot carousels. Forked and adapted from adityathakurxd/flutter_portfolio. See `README.md`.

## Layout
- `lib/data/data.dart` — all content: personal info, `experienceList`, `techSkills`, `softSkills`, `languagesList`, `projectTechnologies` and `projectList`. Hidden projects stay commented out there.
- `lib/models/` — immutable `Project`, `Skill`, `Experience`.
- `lib/theme/` — `AppColors` (dark tokens + `brandGradient`), `AppTheme.dark`, `app_layout.dart` (`AppSpacing`, `AppRadius`, `AppDurations`, `ScreenSize` breakpoints, `context.screenSize` / `context.reduceMotion`). Never use raw hex in widgets.
- `lib/components/` — page sections (`nav_bar`, `hero_section`, `about_section`, `experience_section`, `skills_section`, `projects_section`, `contact_section`) and their parts (`project_card`, `project_filter`, `screenshot_carousel`, `social_links`).
- `lib/widgets/` — shared building blocks: `PageSection`, `SectionHeader`, `GlassCard`, `AppButton`, `TechChip`, `SkillMeter`, `GradientText`, `ResponsiveWrap`, `AnimatedSection` (scroll reveal), `BackgroundGlow`, `ScrollToTopButton`.
- `lib/utils/` — `project_search.dart` (pure filter logic), `links.dart` (`openLink`).
- `lib/screens/home_screen.dart` — single page, fixed `NavBar`, anchors per `PageAnchor`.
- `assets/images/<Project>/N.jpg|png` — screenshots per project (phone size, 1080×2400 for recent ones).
- `google_fonts/` — bundled Poppins and Inter (400–700). Runtime fetching is disabled in `main.dart`; only use those weights.
- `.skills/` — modular AI rules referenced by `.cursorrules`.

## Commands
- `flutter pub get`, `flutter analyze`, `flutter test`
- `flutter run -d chrome`; deploy: `flutter build web` then `firebase deploy --only hosting`.
- Versions: see `pubspec.yaml` and `flutter --version`.

## Adding a project
1. Put screenshots in `assets/images/<FolderName>/1.jpg, 2.jpg…`.
2. Declare the folder in `pubspec.yaml` under `flutter.assets` (each subfolder must be listed).
3. Add a `Project` to `projectList` in `lib/data/data.dart` using `_screenshots(folder, count, ext:)`. Mention the technologies in the description: filter chips and card tags come from `projectTechnologies` found (whole word) in name + description.
4. `test/project_data_test.dart` checks that every image path exists and its folder is declared. `test/widget_test.dart` renders the page at 375/768/1024/1440 px and fails on any overflow.

## Modularity and reuse
- Search `lib/components/` and `lib/widgets/` before creating a widget; reuse `GlassCard`, `AppButton`, `SectionHeader`, `PageSection`, `AnimatedSection`, etc.
- Extract anything used twice into a shared component.
- Keep files focused; keep content in `lib/data/` and logic out of widgets.
