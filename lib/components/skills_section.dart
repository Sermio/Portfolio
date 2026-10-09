import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/glass_card.dart';
import 'package:portfolio/widgets/page_section.dart';
import 'package:portfolio/widgets/responsive_wrap.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/skill_meter.dart';
import 'package:portfolio/widgets/tech_chip.dart';

/// Technical skills as meters and soft skills as chips.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final textTheme = Theme.of(context).textTheme;
    return PageSection(
      child: AnimatedSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(
              eyebrow: 'Skills',
              title: 'My toolbox',
              subtitle:
                  'Mobile first with Flutter and Dart, plus the web and backend tools I use around it.',
            ),
            GlassCard(
              padding:
                  EdgeInsets.all(size.isMobile ? AppSpacing.lg : AppSpacing.xl),
              child: ResponsiveWrap(
                columns: switch (size) {
                  ScreenSize.mobile => 1,
                  ScreenSize.tablet => 2,
                  ScreenSize.desktop => 3,
                },
                spacing: AppSpacing.xl,
                runSpacing: AppSpacing.lg,
                children: [
                  for (final (index, skill) in techSkills.indexed)
                    SkillMeter(
                      skill: skill,
                      delay: Duration(milliseconds: 60 * index),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Soft skills',
              style:
                  textTheme.titleMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final skill in softSkills) TechChip(label: skill),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
