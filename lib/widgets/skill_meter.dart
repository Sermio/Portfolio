import 'package:flutter/material.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Skill name, percentage and a gradient progress bar.
class SkillMeter extends StatelessWidget {
  const SkillMeter({super.key, required this.skill});

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final percent = (skill.percent * 100).round();
    return Semantics(
      label: '${skill.name}, $percent percent',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  skill.name,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '$percent%',
                style:
                    textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 6,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: ColoredBox(color: AppColors.surfaceRaised),
                  ),
                  FractionallySizedBox(
                    widthFactor: skill.percent.clamp(0, 1),
                    heightFactor: 1,
                    child: const DecoratedBox(
                      decoration:
                          BoxDecoration(gradient: AppColors.brandGradient),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
