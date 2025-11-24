import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';

class StickyNavigationBar extends StatefulWidget {
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final ScrollController scrollController;

  const StickyNavigationBar({
    super.key,
    required this.aboutKey,
    required this.experienceKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.contactKey,
    required this.scrollController,
  });

  @override
  State<StickyNavigationBar> createState() => _StickyNavigationBarState();
}

class _StickyNavigationBarState extends State<StickyNavigationBar> {
  bool _isScrolled = false;
  String _activeSection = 'About';

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = widget.scrollController.offset > 50;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  Future<void> _scrollToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 70,
      decoration: BoxDecoration(
        color: _isScrolled
            ? (isDark ? AppTheme.darkSurface : Colors.white)
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SM',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              if (MediaQuery.of(context).size.width > 600)
                Row(
                  children: [
                    _NavItem(
                      label: 'About',
                      isActive: _activeSection == 'About',
                      onTap: () => _scrollToSection(widget.aboutKey),
                    ),
                    const SizedBox(width: 20),
                    _NavItem(
                      label: 'Experience',
                      isActive: _activeSection == 'Experience',
                      onTap: () => _scrollToSection(widget.experienceKey),
                    ),
                    const SizedBox(width: 20),
                    _NavItem(
                      label: 'Skills',
                      isActive: _activeSection == 'Skills',
                      onTap: () => _scrollToSection(widget.skillsKey),
                    ),
                    const SizedBox(width: 20),
                    _NavItem(
                      label: 'Projects',
                      isActive: _activeSection == 'Projects',
                      onTap: () => _scrollToSection(widget.projectsKey),
                    ),
                  ],
                )
              else
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu),
                  onSelected: (value) {
                    switch (value) {
                      case 'About':
                        _scrollToSection(widget.aboutKey);
                        break;
                      case 'Experience':
                        _scrollToSection(widget.experienceKey);
                        break;
                      case 'Skills':
                        _scrollToSection(widget.skillsKey);
                        break;
                      case 'Projects':
                        _scrollToSection(widget.projectsKey);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'About', child: Text('About')),
                    const PopupMenuItem(value: 'Experience', child: Text('Experience')),
                    const PopupMenuItem(value: 'Skills', child: Text('Skills')),
                    const PopupMenuItem(value: 'Projects', child: Text('Projects')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isActive
                ? AppTheme.primaryColor
                : theme.colorScheme.onSurface,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}


