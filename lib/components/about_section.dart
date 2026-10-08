import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/glass_card.dart';
import 'package:portfolio/widgets/page_section.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/skill_meter.dart';

/// Summary paragraphs next to a card with contact details and languages.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDesktop = context.screenSize.isDesktop;

    final summary = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: 'About me',
          title: 'Engineer, team player, product builder.',
        ),
        for (final paragraph in aboutMeParagraphs)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              paragraph,
              style: textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
            ),
          ),
      ],
    );

    return PageSection(
      child: AnimatedSection(
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: summary),
                  const SizedBox(width: AppSpacing.xxl),
                  const Expanded(flex: 5, child: _InfoCard()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  summary,
                  const SizedBox(height: AppSpacing.lg),
                  const _InfoCard(),
                ],
              ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _InfoRow(icon: FontAwesomeIcons.locationDot, label: location),
          _InfoRow(
            icon: FontAwesomeIcons.solidEnvelope,
            label: email,
            onTap: () => openLink(emailUri),
          ),
          _InfoRow(
            icon: FontAwesomeIcons.phone,
            label: phone,
            onTap: () => openLink(phoneUri),
          ),
          _InfoRow(
            icon: FontAwesomeIcons.linkedinIn,
            label: linkedinHandle,
            onTap: () => openLink(linkedinUri),
          ),
          _InfoRow(
            icon: FontAwesomeIcons.github,
            label: githubHandle,
            onTap: () => openLink(githubUri),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Divider(height: 1),
          ),
          Text('Languages', style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          for (final language in languagesList)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: SkillMeter(skill: language),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, this.onTap});

  final FaIconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: FaIcon(icon, size: 15, color: AppColors.accentText),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(label,
                style: textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
          ),
          if (onTap != null)
            const Icon(Icons.north_east_rounded,
                size: 16, color: AppColors.textMuted),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: onTap == null
          ? row
          : InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: row,
            ),
    );
  }
}
