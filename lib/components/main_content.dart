import 'package:flutter/material.dart';
import 'package:portfolio/components/main_sections.dart';
import 'package:portfolio/components/references.dart';
import 'package:portfolio/utils/extensions.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenConstraint().width;
    final isLargeScreen = screenWidth > 1200;
    
    if (isLargeScreen) {
      return Center(
        child: SizedBox(
          width: screenWidth * 0.85,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: const MainSections(),
              ),
              const SizedBox(width: 32),
              SizedBox(
                width: 320,
                child: const References(),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: SizedBox(
          width: screenWidth * 0.9,
          child: const Column(
            children: [
              MainSectionsWithoutSkills(),
              SizedBox(height: 32),
              References(),
              SizedBox(height: 32),
              SkillsSectionWidget(),
            ],
          ),
        ),
      );
    }
  }
}
