import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Eyebrow label, title and optional subtitle that open each section.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMobile = context.screenSize.isMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 2,
              decoration: const BoxDecoration(
                gradient: AppColors.brandGradient,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              eyebrow.toUpperCase(),
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.accentText,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Semantics(
          header: true,
          child: Text(
            title,
            style: isMobile ? textTheme.headlineSmall : textTheme.displaySmall,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              style: textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
            ),
          ),
        ],
        SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),
      ],
    );
  }
}
