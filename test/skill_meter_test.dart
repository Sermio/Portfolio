import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/skill_meter.dart';

const _skill = Skill(name: 'Flutter', percent: 0.9);

Widget _host({required bool reduceMotion}) => MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: child!,
      ),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: AnimatedSection(child: SkillMeter(skill: _skill)),
        ),
      ),
    );

void main() {
  testWidgets('percentage counts up from 0 once the section is revealed',
      (tester) async {
    await tester.pumpWidget(_host(reduceMotion: false));
    expect(find.text('0%'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('90%'), findsOneWidget);
  });

  testWidgets('shows the final value straight away with reduced motion',
      (tester) async {
    await tester.pumpWidget(_host(reduceMotion: true));
    expect(find.text('90%'), findsOneWidget);
  });
}
