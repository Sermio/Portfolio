import 'package:flutter/material.dart';
import 'package:portfolio/components/header.dart';
import 'package:portfolio/components/main_content.dart';
import 'package:portfolio/components/projects_list.dart';
import 'package:portfolio/components/resume_contact_buttons.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WebHeader(),
            const SizedBox(height: 40),
            Center(
              child: Text(
                name,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            const ResumeContactButtons(),
            const SizedBox(height: 64),
            const MainContent(),
            const SizedBox(height: 48),
            const ProjectsList(),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
