import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';

class SkillBar extends StatelessWidget {
  const SkillBar({super.key, required this.skillName, required this.percent});

  final String skillName;
  final double percent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determinar el nivel de la skill
    final bool isExpert = percent >= 0.9;
    final bool isAdvanced = percent >= 0.75 && percent < 0.9;
    
    // Colores y estilos según el nivel
    final Color borderColor = isExpert
        ? Colors.amber.shade600
        : isAdvanced
            ? AppTheme.secondaryColor.withOpacity(0.2)
            : theme.dividerColor.withOpacity(0.1);
    
    final double borderWidth = isExpert ? 2 : 1;
    final double barHeight = isExpert ? 10 : (isAdvanced ? 9 : 8);
    final double shadowIntensity = isExpert ? 0.15 : (isAdvanced ? 0.1 : 0.05);
    
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12, right: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: isExpert
                ? AppTheme.primaryColor.withOpacity(shadowIntensity)
                : Colors.black.withOpacity(shadowIntensity),
            blurRadius: isExpert ? 12 : 8,
            spreadRadius: isExpert ? 1 : 0,
            offset: Offset(0, isExpert ? 4 : 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (isExpert)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        skillName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: isExpert
                              ? FontWeight.bold
                              : isAdvanced
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                          fontSize: isExpert ? 15 : 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isExpert ? 8 : 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isExpert
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : isAdvanced
                          ? AppTheme.secondaryColor.withOpacity(0.08)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${(percent * 100).toInt()}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isExpert
                        ? AppTheme.primaryColor
                        : isAdvanced
                            ? AppTheme.secondaryColor
                            : theme.colorScheme.onSurface.withOpacity(0.7),
                    fontSize: isExpert ? 13 : 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: barHeight,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(barHeight / 2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent,
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.secondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(barHeight / 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.4),
                        blurRadius: isExpert ? 6 : 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
