import 'package:flutter/material.dart';
import 'package:portfolio/components/about_section.dart';
import 'package:portfolio/components/contact_section.dart';
import 'package:portfolio/components/experience_section.dart';
import 'package:portfolio/components/hero_section.dart';
import 'package:portfolio/components/nav_bar.dart';
import 'package:portfolio/components/projects_section.dart';
import 'package:portfolio/components/skills_section.dart';
import 'package:portfolio/theme/app_layout.dart';
import 'package:portfolio/widgets/background_glow.dart';
import 'package:portfolio/widgets/scroll_to_top_button.dart';

/// Single-page portfolio with a fixed navigation bar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _anchors = {
    for (final anchor in PageAnchor.values) anchor: GlobalKey()
  };

  Duration get _scrollDuration =>
      context.reduceMotion ? Duration.zero : const Duration(milliseconds: 700);

  /// Scrolls so the section starts just below the fixed navigation bar.
  void _scrollTo(PageAnchor anchor) {
    final box = _anchors[anchor]!.currentContext?.findRenderObject();
    if (box is! RenderBox) return;
    final position = _scrollController.position;
    final top = box.localToGlobal(Offset.zero).dy;
    _scrollToOffset((position.pixels + top - NavBar.height)
        .clamp(0, position.maxScrollExtent));
  }

  void _scrollToTop() => _scrollToOffset(0);

  void _scrollToOffset(double offset) {
    if (_scrollDuration == Duration.zero) {
      _scrollController.jumpTo(offset);
    } else {
      _scrollController.animateTo(offset,
          duration: _scrollDuration, curve: Curves.easeInOutCubic);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _anchored(PageAnchor anchor, Widget child) =>
      KeyedSubtree(key: _anchors[anchor], child: child);

  @override
  Widget build(BuildContext context) {
    final gutter = context.screenSize.gutter;
    return Scaffold(
      body: Stack(
        children: [
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Stack(
                children: [
                  const BackgroundGlow(),
                  Column(
                    children: [
                      HeroSection(
                        onViewProjects: () => _scrollTo(PageAnchor.projects),
                      ),
                      _anchored(PageAnchor.about, const AboutSection()),
                      _anchored(
                          PageAnchor.experience, const ExperienceSection()),
                      _anchored(PageAnchor.skills, const SkillsSection()),
                      _anchored(PageAnchor.projects, const ProjectsSection()),
                      _anchored(PageAnchor.contact, const ContactSection()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(onNavigate: _scrollTo, onLogoTap: _scrollToTop),
          ),
          Positioned(
            right: gutter,
            bottom: gutter,
            child: ScrollToTopButton(
              controller: _scrollController,
              onPressed: _scrollToTop,
            ),
          ),
        ],
      ),
    );
  }
}
