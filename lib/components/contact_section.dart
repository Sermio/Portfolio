import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/components/social_links.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/app_button.dart';
import 'package:portfolio/widgets/gradient_text.dart';
import 'package:portfolio/widgets/page_section.dart';

/// Closing call to action and footer.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = context.screenSize;
    final titleStyle =
        size.isMobile ? textTheme.displaySmall : textTheme.displayMedium;

    return Column(
      children: [
        PageSection(
          child: AnimatedSection(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: size.isMobile ? AppSpacing.lg : AppSpacing.xxxl,
                vertical: size.isMobile ? AppSpacing.xxl : AppSpacing.xxxl,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg + 8),
                border:
                    Border.all(color: AppColors.orange.withValues(alpha: 0.35)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.alphaBlend(AppColors.orange.withValues(alpha: 0.14),
                        AppColors.surface),
                    AppColors.surface,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Semantics(
                    header: true,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Let's build "),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GradientText('something', style: titleStyle),
                          ),
                          const TextSpan(text: ' together.'),
                        ],
                      ),
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Have a project or a role in mind? Send me an email or reach out on LinkedIn.',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColors.textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      AppButton(
                        label: 'Email me',
                        icon: Icons.mail_outline_rounded,
                        onPressed: () => openLink(emailUri),
                      ),
                      AppButton(
                        label: 'LinkedIn',
                        icon: FontAwesomeIcons.linkedinIn.data,
                        variant: AppButtonVariant.outline,
                        onPressed: () => openLink(linkedinUri),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const _Footer(),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final note = Text(
      '© ${DateTime.now().year} $name · Built with Flutter',
      style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
      textAlign: TextAlign.center,
    );
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: PageSection(
        verticalPadding: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          child: context.screenSize.isMobile
              ? Column(
                  children: [
                    const SocialLinks(),
                    const SizedBox(height: AppSpacing.md),
                    note,
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft, child: note)),
                    const SocialLinks(),
                  ],
                ),
        ),
      ),
    );
  }
}
