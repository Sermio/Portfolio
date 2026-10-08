import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/utils/links.dart';
import 'package:portfolio/widgets/app_button.dart';

/// Page sections reachable from the navigation bar.
enum PageAnchor {
  about('About'),
  experience('Experience'),
  skills('Skills'),
  projects('Projects'),
  contact('Contact');

  const PageAnchor(this.label);
  final String label;
}

/// Fixed translucent top bar. Collapses the links into a bottom sheet on
/// narrow screens.
class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.onNavigate, required this.onLogoTap});

  static const double height = 72;

  /// Narrower screens show the menu button instead of inline links.
  static const double _inlineLinksMinWidth = 1100;

  final ValueChanged<PageAnchor> onNavigate;
  final VoidCallback onLogoTap;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final inlineLinks =
        MediaQuery.sizeOf(context).width >= _inlineLinksMinWidth;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.72),
            border: const Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ScreenSize.maxContentWidth + size.gutter * 2,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.gutter),
                child: Row(
                  children: [
                    _Logo(onTap: onLogoTap),
                    const Spacer(),
                    if (inlineLinks) ...[
                      for (final anchor in PageAnchor.values)
                        _NavLink(
                          label: anchor.label,
                          onTap: () => onNavigate(anchor),
                        ),
                      const SizedBox(width: AppSpacing.md),
                      AppButton(
                        label: 'Resume',
                        icon: Icons.description_outlined,
                        compact: true,
                        onPressed: () => openLink(resumeUri),
                      ),
                    ] else
                      IconButton(
                        tooltip: 'Open menu',
                        iconSize: 26,
                        constraints:
                            const BoxConstraints(minWidth: 48, minHeight: 48),
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: () => _openMenu(context),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dropdown panel anchored under the bar. Anchoring it to the top (rather
  /// than a bottom sheet) keeps every item clear of mobile browser toolbars.
  void _openMenu(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close menu',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration:
          context.reduceMotion ? Duration.zero : AppDurations.medium,
      transitionBuilder: (context, animation, _, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween(begin: const Offset(0, -0.04), end: Offset.zero)
                .animate(curved),
            child: child,
          ),
        );
      },
      pageBuilder: (dialogContext, _, __) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            height + AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                side: const BorderSide(color: AppColors.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final anchor in PageAnchor.values)
                      ListTile(
                        minTileHeight: 52,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.sm)),
                        title: Text(anchor.label, style: textTheme.titleMedium),
                        trailing: const Icon(Icons.arrow_forward_rounded,
                            size: 18, color: AppColors.textMuted),
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          onNavigate(anchor);
                        },
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Divider(height: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: AppButton(
                        label: 'Resume',
                        icon: Icons.description_outlined,
                        onPressed: () => openLink(resumeUri),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      button: true,
      label: '$name, back to top',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  'S',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.onAccent,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 2),
              Text(
                '$firstName M.T.',
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) => setState(() => _hovered = value),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Center(
            widthFactor: 1,
            child: AnimatedDefaultTextStyle(
              duration: AppDurations.fast,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: _hovered ? AppColors.text : AppColors.textMuted,
                  ),
              child: Text(widget.label),
            ),
          ),
        ),
      ),
    );
  }
}
