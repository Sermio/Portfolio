import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Centres [child] within the max content width, with the page gutter and
/// the vertical spacing of a section.
class PageSection extends StatelessWidget {
  const PageSection({
    super.key,
    required this.child,
    this.verticalPadding = true,
  });

  final Widget child;
  final bool verticalPadding;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ScreenSize.maxContentWidth + size.gutter * 2,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.gutter,
            vertical: verticalPadding ? size.sectionSpacing / 2 : 0,
          ),
          child: child,
        ),
      ),
    );
  }
}
