import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/glass_card.dart';
import 'package:portfolio/widgets/page_section.dart';
import 'package:portfolio/widgets/section_header.dart';

/// Career timeline, most recent first.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedSection(
            child: SectionHeader(
              eyebrow: 'Experience',
              title: 'Where I have worked',
            ),
          ),
          for (final (index, item) in experienceList.indexed)
            AnimatedSection(
              delay: Duration(milliseconds: 60 * index),
              child: _TimelineItem(
                experience: item,
                isCurrent: index == 0,
                isLast: index == experienceList.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.experience,
    required this.isCurrent,
    required this.isLast,
  });

  final Experience experience;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDesktop = context.screenSize.isDesktop;

    final period = Text(
      experience.period,
      style: textTheme.labelMedium?.copyWith(color: AppColors.accentText),
    );

    final card = GlassCard(
      hoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isDesktop) ...[period, const SizedBox(height: AppSpacing.sm)],
          Text(experience.role, style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            experience.company,
            style: textTheme.titleMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            experience.description,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );

    // The rail is painted behind the card (Stack) instead of sharing a row
    // with it, so the card is always as tall as its own content.
    final cardWithRail = Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: _Rail(isCurrent: isCurrent, isLast: isLast),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: _Rail.width + (isDesktop ? AppSpacing.lg : AppSpacing.md),
            bottom: isLast ? 0 : AppSpacing.lg,
          ),
          child: card,
        ),
      ],
    );

    if (!isDesktop) return cardWithRail;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg + 2),
            child: period,
          ),
        ),
        Expanded(child: cardWithRail),
      ],
    );
  }
}

/// Dot and connecting line on the left of each timeline entry.
class _Rail extends StatelessWidget {
  const _Rail({required this.isCurrent, required this.isLast});

  static const double width = 20;

  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.lg + 4),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isCurrent ? AppColors.brandGradient : null,
              color: isCurrent ? null : AppColors.background,
              border: isCurrent
                  ? null
                  : Border.all(color: AppColors.orange, width: 2),
              boxShadow: [
                if (isCurrent)
                  BoxShadow(
                    color: AppColors.orange.withValues(alpha: 0.6),
                    blurRadius: 12,
                  ),
              ],
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                margin: const EdgeInsets.only(top: AppSpacing.xs),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.orange.withValues(alpha: 0.6),
                      AppColors.border,
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
