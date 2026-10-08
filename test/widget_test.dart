import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/components/nav_bar.dart';
import 'package:portfolio/components/project_card.dart';
import 'package:portfolio/components/project_filter.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/main.dart';

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
      expect(find.text('Where I have worked'), findsOneWidget);
      expect(find.text('My toolbox'), findsOneWidget);
      expect(find.text('Things I have built'), findsOneWidget);
      expect(find.byType(ProjectCard), findsNWidgets(projectList.length));
    });
  }

  testWidgets('technology chip filters the project grid', (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    final chip = find.descendant(
        of: find.byType(ProjectFilter), matching: find.text('Flame'));
    await _centre(tester, chip);
    await tester.tap(chip);
    await tester.pumpAndSettle();

    final cards = tester.widgetList<ProjectCard>(find.byType(ProjectCard));
    expect(cards, isNotEmpty);
    expect(cards.length, lessThan(projectList.length));
    expect(cards.every((c) => c.project.description.contains('Flame')), isTrue);
  });

  testWidgets('search with no match shows the empty state', (tester) async {
    await _pumpApp(tester, const Size(1440, 900));

    await tester.enterText(find.byType(TextField), 'zzz-no-project');
    await tester.pumpAndSettle();

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
