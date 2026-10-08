import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';

/// Text painted with the brand gradient.
class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: AppColors.brandGradient.createShader,
      child: Text(text, style: style),
    );
  }
}
