import 'package:flutter/material.dart';
import 'package:portfolio/models/skill.dart';
import 'skill_bar.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0.0,
      runSpacing: 0.0,
      alignment: WrapAlignment.start,
      children: skills.map((skill) {
        return SkillBar(
          skillName: skill.name,
          percent: skill.percent,
        );
      }).toList(),
    );
  }
}
