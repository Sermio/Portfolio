import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';

/// GitHub, LinkedIn and email icon buttons.
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        _SocialButton(
          tooltip: 'GitHub',
          icon: FontAwesomeIcons.github,
          uri: githubUri,
        ),
        _SocialButton(
          tooltip: 'LinkedIn',
          icon: FontAwesomeIcons.linkedinIn,
          uri: linkedinUri,
        ),
        _SocialButton(
          tooltip: 'Email',
          icon: FontAwesomeIcons.solidEnvelope,
          uri: emailUri,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.tooltip,
    required this.icon,
    required this.uri,
  });

  final String tooltip;
  final FaIconData icon;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: () => openLink(uri),
      icon: FaIcon(icon, size: 18),
      color: AppColors.textMuted,
      hoverColor: AppColors.orange.withValues(alpha: 0.12),
      highlightColor: AppColors.orange.withValues(alpha: 0.2),
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      style: IconButton.styleFrom(
        side: const BorderSide(color: AppColors.border),
        backgroundColor: AppColors.surface,
      ),
    );
  }
}
