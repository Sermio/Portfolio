import 'package:flutter/material.dart';

class AnimatedSection extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Curve curve;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    // Simplificado temporalmente para evitar problemas de estado
    return child;
  }
}


