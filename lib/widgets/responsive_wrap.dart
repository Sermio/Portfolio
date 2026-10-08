import 'package:flutter/material.dart';

/// Lays [children] out in rows of [columns] equal-width cells.
class ResponsiveWrap extends StatelessWidget {
  const ResponsiveWrap({
    super.key,
    required this.columns,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
  });

  final int columns;
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: [
            for (final child in children)
              SizedBox(width: cellWidth.floorToDouble(), child: child),
          ],
        );
      },
    );
  }
}
