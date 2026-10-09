import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/components/nav_bar.dart';
import 'package:portfolio/components/project_card.dart';
import 'package:portfolio/components/project_filter.dart';
import 'package:portfolio/components/project_showcase.dart';
import 'package:portfolio/components/screenshot_carousel.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/project_search.dart';

Future<void> _pumpApp(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

/// Scrolls [finder] to the middle of the viewport, clear of the fixed nav bar.
Future<void> _centre(WidgetTester tester, Finder finder) async {
  Scrollable.ensureVisible(tester.element(finder.first), alignment: 0.5);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  for (final (label, size) in [
    ('small desktop', const Size(1024, 768)),
    ('phone', const Size(375, 812)),
    ('tablet', const Size(768, 1024)),
    ('desktop', const Size(1440, 900)),
  ]) {
    testWidgets('renders every section without overflow on $label',
        (tester) async {
      await _pumpApp(tester, size);

      expect(tester.takeException(), isNull);
      expect(find.text("Hi, I'm $name."), findsOneWidget);
      expect(find.text('Professional Experience'), findsOneWidget);
      expect(find.text('My toolbox'), findsOneWidget);
      expect(find.text('Things I have built'), findsOneWidget);
      expect(find.byType(ProjectShowcase), findsOneWidget);
      expect(find.byType(ProjectCard), findsNWidgets(projectList.length));
    });
  }

  testWidgets('technology chip filters the project list', (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final chip = find.descendant(
        of: find.byType(ProjectFilter), matching: find.text('Flame'));
    await _centre(tester, chip);
    await tester.tap(chip);
    await tester.pumpAndSettle();

    final shown = tester.widget<ProjectShowcase>(find.byType(ProjectShowcase));
    expect(shown.project.description, contains('Flame'));
    final count = filterProjects(projectList, technology: 'Flame').length;
    expect(count, lessThan(projectList.length));
    expect(find.text('$count ${count == 1 ? 'project' : 'projects'}'),
        findsOneWidget);
    expect(find.byType(ProjectCard), findsNWidgets(count));
  });

  testWidgets('search with no match shows the empty state', (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    await tester.enterText(find.byType(TextField), 'zzz-no-project');
    await tester.pumpAndSettle();

    expect(find.byType(ProjectShowcase), findsNothing);
    expect(find.byType(ProjectCard), findsNothing);
    expect(find.text('No projects match your search'), findsOneWidget);
  });

  testWidgets('screenshots button opens the gallery', (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final first = projectList.first;
    final button = find.text('Screenshots (${first.images.length})').first;
    await _centre(tester, button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byTooltip('Close'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close'), findsNothing);
  });

  testWidgets('tapping a screenshot opens the gallery', (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final shot = find.byKey(const ValueKey('screenshot-0'));
    await _centre(tester, shot);
    await tester.tap(shot);
    await tester.pumpAndSettle();

    expect(find.byTooltip('Close'), findsOneWidget);

    // Let the real image decode so the tap area shrinks to the picture.
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pumpAndSettle();

    // Tapping the picture keeps it open; empty space beside it closes it.
    final picture = tester.getRect(find.byType(Image).last);
    await tester.tapAt(picture.center);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close'), findsOneWidget);
    await tester.tapAt(Offset(picture.left - 30, picture.center.dy));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close'), findsNothing);
  });

  testWidgets('card arrows loop through the photos without selecting',
      (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final card = find.byType(ProjectCard).first;
    await _centre(tester, card);
    final count = projectList.first.images.length;
    int page() => tester
        .widget<CarouselPageIndicator>(find.descendant(
            of: card, matching: find.byType(CarouselPageIndicator)))
        .page;

    expect(page(), 0);
    await tester.tap(find.descendant(
        of: card, matching: find.byTooltip('Previous screenshot')));
    await tester.pumpAndSettle();
    expect(page(), count - 1);

    await tester.tap(
        find.descendant(of: card, matching: find.byTooltip('Next screenshot')));
    await tester.pumpAndSettle();
    expect(page(), 0);

    final shown = tester.widget<ProjectShowcase>(find.byType(ProjectShowcase));
    expect(shown.project, same(projectList.first));
  });

  testWidgets('picking a project in the list changes the stage',
      (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final next = projectList[1];
    final tile = find.text(next.name).first;
    await _centre(tester, tile);
    await tester.tap(tile);
    await tester.pumpAndSettle();

    final shown = tester.widget<ProjectShowcase>(find.byType(ProjectShowcase));
    expect(shown.project, same(next));
  });

  testWidgets('tapping a card puts that project in the showcase',
      (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final target = projectList.last;
    final card = find.widgetWithText(ProjectCard, target.name);
    await _centre(tester, card);
    await tester.tap(card);
    await tester.pumpAndSettle();

    final shown = tester.widget<ProjectShowcase>(find.byType(ProjectShowcase));
    expect(shown.project, same(target));
  });

  testWidgets('nav link scrolls the section below the navigation bar',
      (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    await tester.tap(find.descendant(
        of: find.byType(NavBar), matching: find.text('Projects')));
    await tester.pumpAndSettle();

    final top = tester.getTopLeft(find.text('Things I have built')).dy;
    expect(top, greaterThan(NavBar.height));
    expect(top, lessThan(900 / 2));
  });

  testWidgets('mobile menu keeps every item and Resume on screen',
      (tester) async {
    await _pumpApp(tester, const Size(375, 640));

    await tester.tap(find.byTooltip('Open menu'));
    await tester.pumpAndSettle();

    final screen = tester.view.physicalSize;
    for (final label in [...PageAnchor.values.map((a) => a.label), 'Resume']) {
      final bottom = tester.getBottomLeft(find.text(label).last).dy;
      expect(bottom, lessThan(screen.height - 150),
          reason: '$label is too low and a browser toolbar could cover it');
    }

    await tester.tap(find.text('Skills').last);
    await tester.pumpAndSettle();
    expect(find.text('Contact'), findsNothing, reason: 'menu should close');
  });
}
