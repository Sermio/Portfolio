import 'package:flutter/material.dart';
import 'package:portfolio/components/main_sections.dart';
import 'package:portfolio/components/references.dart';
import 'package:portfolio/utils/extensions.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.screenConstraint().width * 0.8,
        child: context.screenConstraint().width > 1200
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: MainSections(),
                  ),
                  SizedBox(width: 40),
                  Flexible(flex: 1, child: References()),
                ],
              )
            : const Column(
                children: [
                  MainSections(),
                  References(),
                ],
              ),
      ),
    );
  }
}
