import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeContactButtons extends StatefulWidget {
  const ResumeContactButtons({super.key});

  @override
  State<ResumeContactButtons> createState() => _ResumeContactButtonsState();
}

class _ResumeContactButtonsState extends State<ResumeContactButtons> {
  bool _isHoveredResume = false;
  bool _isHoveredContact = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHoveredResume = true),
          onExit: (_) => setState(() => _isHoveredResume = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton.icon(
              onPressed: () async {
                final Uri url = Uri.parse(resumeLink);
                await launchUrl(url, mode: LaunchMode.externalApplication);
              },
              icon: const Icon(Icons.description_outlined, size: 20),
              label: const Text("Ver CV"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: _isHoveredResume ? 8 : 4,
                shadowColor: AppTheme.primaryColor.withOpacity(0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        MouseRegion(
          onEnter: (_) => setState(() => _isHoveredContact = true),
          onExit: (_) => setState(() => _isHoveredContact = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: OutlinedButton.icon(
              onPressed: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                );
                await launchUrl(emailLaunchUri);
              },
              icon: const Icon(Icons.email_outlined, size: 20),
              label: const Text("Contactar"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: AppTheme.primaryColor,
                  width: _isHoveredContact ? 2.5 : 2,
                ),
                backgroundColor: _isHoveredContact
                    ? AppTheme.primaryColor.withOpacity(0.1)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
