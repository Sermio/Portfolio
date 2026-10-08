import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_colors.dart';

/// Orange and pink light blooms over a faint dot grid, painted behind the
/// hero. Purely decorative.
class BackgroundGlow extends StatelessWidget {
  const BackgroundGlow({super.key, this.height = 900});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: IgnorePointer(
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              const Positioned.fill(child: CustomPaint(painter: _DotGrid())),
              _bloom(const Alignment(-1.1, -1.2), AppColors.orange, 0.30),
              _bloom(const Alignment(1.2, -0.6), AppColors.pink, 0.18),
              _bloom(const Alignment(0.2, -1.4), AppColors.amber, 0.12),
              // Fade the whole decoration into the page background.
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x000A0A0F), AppColors.background],
                      stops: [0.55, 1],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bloom(Alignment center, Color color, double alpha) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: center,
            radius: 0.9,
            colors: [
              color.withValues(alpha: alpha),
              color.withValues(alpha: 0)
            ],
          ),
        ),
      ),
    );
  }
}

class _DotGrid extends CustomPainter {
  const _DotGrid();

  static const double _gap = 28;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.text.withValues(alpha: 0.06);
    for (var y = _gap / 2; y < size.height; y += _gap) {
      for (var x = _gap / 2; x < size.width; x += _gap) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
