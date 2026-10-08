import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/components/nav_bar.dart';
import 'package:portfolio/components/social_links.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/app_button.dart';
import 'package:portfolio/widgets/gradient_text.dart';
import 'package:portfolio/widgets/page_section.dart';

/// Opening section: headline, calls to action, key figures and avatar.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final intro = _Intro(onViewProjects: onViewProjects);
    final avatar = _Avatar(diameter: size.isDesktop ? 340 : 220);

    return Padding(
      padding: EdgeInsets.only(
        top: NavBar.height + (size.isMobile ? AppSpacing.xl : AppSpacing.xxxl),
      ),
      child: PageSection(
        child: AnimatedSection(
          child: size.isDesktop
              ? Row(
                  children: [
                    Expanded(flex: 7, child: intro),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(flex: 5, child: Center(child: avatar)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avatar,
                    const SizedBox(height: AppSpacing.xl),
                    intro,
                  ],
                ),
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = context.screenSize;
    final headlineStyle = switch (size) {
      ScreenSize.mobile => textTheme.displaySmall,
      ScreenSize.tablet => textTheme.displayMedium,
      ScreenSize.desktop => textTheme.displayLarge,
    };
    final years = DateTime.now().difference(careerStart).inDays ~/ 365;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Badge(label: '$role · $location'),
        const SizedBox(height: AppSpacing.lg),
        Text(
          "Hi, I'm $name.",
          style: textTheme.titleLarge?.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: AppSpacing.sm),
        Semantics(
          header: true,
          label: '$heroHeadlineStart$heroHeadlineHighlight.',
          excludeSemantics: true,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: heroHeadlineStart),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child:
                      GradientText(heroHeadlineHighlight, style: headlineStyle),
                ),
                const TextSpan(text: '.'),
              ],
            ),
            style: headlineStyle,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            heroSubtitle,
            style: textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            AppButton(
              label: 'View projects',
              icon: Icons.arrow_downward_rounded,
              onPressed: onViewProjects,
            ),
            AppButton(
              label: 'Resume',
              icon: Icons.description_outlined,
              variant: AppButtonVariant.outline,
              onPressed: () => openLink(resumeUri),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const SocialLinks(),
        SizedBox(height: size.isMobile ? AppSpacing.xl : AppSpacing.xxl),
        Wrap(
          spacing: size.isMobile ? AppSpacing.xl : AppSpacing.xxl,
          runSpacing: AppSpacing.lg,
          children: [
            _Stat(value: '$years+', label: 'Years building apps'),
            _Stat(value: '${projectList.length}', label: 'Featured projects'),
            _Stat(value: '${languagesList.length}', label: 'Languages spoken'),
          ],
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md - 2, vertical: AppSpacing.sm - 2),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const FaIcon(FontAwesomeIcons.flutter,
              size: 14, color: AppColors.accentText),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.accentText),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientText(value, style: textTheme.displaySmall),
        Text(label,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted)),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.diameter});

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.brandGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withValues(alpha: 0.35),
            blurRadius: 80,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.background,
        ),
        child: ClipOval(
          child: Image.asset(
            avatarAsset,
            fit: BoxFit.cover,
            semanticLabel: 'Portrait of $name',
            errorBuilder: (_, __, ___) => const ColoredBox(
              color: AppColors.surfaceRaised,
              child: Icon(Icons.person_rounded,
                  size: 96, color: AppColors.textMuted),
            ),
          ),
        ),
      ),
    );
  }
}
