import 'package:flutter/material.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/widgets/animated_section.dart';

/// Skill name, percentage and a gradient progress bar. The bar fills and the
/// percentage counts up once the enclosing [AnimatedSection] is revealed, with
/// [delay] to stagger neighbours.
class SkillMeter extends StatefulWidget {
  const SkillMeter({
    super.key,
    required this.skill,
    this.delay = Duration.zero,
  });

  final Skill skill;
  final Duration delay;

  @override
  State<SkillMeter> createState() => _SkillMeterState();
}

class _SkillMeterState extends State<SkillMeter> {
  bool _go = false;
  bool _pending = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_go || _pending || !AnimatedSection.isRevealed(context)) return;
    if (context.reduceMotion || widget.delay == Duration.zero) {
      _go = true;
      return;
    }
    _pending = true;
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _go = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final skill = widget.skill;
    final percent = (skill.percent * 100).round();
    final target = skill.percent.clamp(0.0, 1.0);
    final filled = context.reduceMotion || _go;

    return Semantics(
      label: '${skill.name}, $percent percent',
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: filled ? target : 0),
        duration: context.reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 1100),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    skill.name,
                    style: textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${(value * 100).round()}%',
                  style: textTheme.labelMedium
                      ?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                height: 6,
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: ColoredBox(color: AppColors.surfaceRaised),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      heightFactor: 1,
                      child: const DecoratedBox(
                        decoration:
                            BoxDecoration(gradient: AppColors.brandGradient),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
