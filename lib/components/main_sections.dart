import 'package:flutter/material.dart';
import 'package:portfolio/components/skills_section.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_theme.dart';

class MainSections extends StatelessWidget {
  const MainSections({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.work_outline,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "Experience",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        _ExperienceCard(
          title: workFreelance2Title,
          date: workFreelance2Date,
          description: workFreelance2Info,
        ),
        const SizedBox(height: 20),

        _ExperienceCard(
          title: workSoteloTitle,
          date: workSoteloDate,
          description: workSoteloInfo,
        ),
        const SizedBox(height: 20),
        _ExperienceCard(
          title: workFreelanceTitle,
          date: workFreelanceDate,
          description: workFreelanceInfo,
        ),
        const SizedBox(height: 20),
        _ExperienceCard(
          title: workInternshipTitle,
          date: workInternshipDate,
          description: workInternshipInfo,
        ),
        const SizedBox(height: 48),
        const Divider(height: 1),
        const SizedBox(height: 48),
        Row(
          children: [
            Icon(
              Icons.person_outline,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "About Me",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          aboutMeSummary,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.7,
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 48),
        const Divider(height: 1),
        const SizedBox(height: 48),
        Row(
          children: [
            Icon(
              Icons.code_outlined,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "My Skills",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SkillsSection(skills: skillsList),
        const SizedBox(height: 32),
      ],
    );
  }
}

class MainSectionsWithoutSkills extends StatelessWidget {
  const MainSectionsWithoutSkills({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.work_outline,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "Experience",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        _ExperienceCard(
          title: workFreelance2Title,
          date: workFreelance2Date,
          description: workFreelance2Info,
        ),
        const SizedBox(height: 20),

        _ExperienceCard(
          title: workSoteloTitle,
          date: workSoteloDate,
          description: workSoteloInfo,
        ),
        const SizedBox(height: 20),
        _ExperienceCard(
          title: workFreelanceTitle,
          date: workFreelanceDate,
          description: workFreelanceInfo,
        ),
        const SizedBox(height: 20),
        _ExperienceCard(
          title: workInternshipTitle,
          date: workInternshipDate,
          description: workInternshipInfo,
        ),
        const SizedBox(height: 48),
        const Divider(height: 1),
        const SizedBox(height: 48),
        Row(
          children: [
            Icon(
              Icons.person_outline,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "About Me",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          aboutMeSummary,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.7,
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class SkillsSectionWidget extends StatelessWidget {
  const SkillsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.code_outlined,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "My Skills",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SkillsSection(skills: skillsList),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const _ExperienceCard({
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmallScreen = MediaQuery.of(context).size.width <= 600;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSmallScreen)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    date,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    date,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
