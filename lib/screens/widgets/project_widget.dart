import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;

  const ProjectWidget({super.key, required this.project});

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  bool _isHovered = false;
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppTheme.primaryColor.withOpacity(0.2)
                  : Colors.black.withOpacity(0.08),
              blurRadius: _isHovered ? 24 : 12,
              spreadRadius: _isHovered ? 2 : 0,
              offset: Offset(0, _isHovered ? 12 : 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isMobile ? _buildMobileLayout(theme) : _buildDesktopLayout(theme),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Sección de imágenes (lado izquierdo)
        Expanded(
          flex: 5,
          child: _buildImageSection(theme, height: 400),
        ),
        // Sección de información (lado derecho)
        Expanded(
          flex: 4,
          child: _buildInfoSection(theme),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sección de imágenes (arriba)
        _buildImageSection(theme, height: 300),
        // Sección de información (abajo)
        _buildInfoSection(theme),
      ],
    );
  }

  Widget _buildImageSection(ThemeData theme, {required double height}) {
    if (widget.project.images.isEmpty) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              AppTheme.secondaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: CarouselSlider(
            carouselController: _carouselController,
            items: widget.project.images.map((img) {
              return Container(
                width: double.infinity,
                height: height,
                color: Colors.black.withOpacity(0.02),
                child: Image.asset(
                  img,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: widget.project.images.length > 1,
              autoPlay: widget.project.images.length > 1,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              pauseAutoPlayOnTouch: true,
              pauseAutoPlayOnManualNavigate: true,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
        ),
        // Indicadores del carrusel
        if (widget.project.images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.project.images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentImageIndex == entry.key ? 32 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentImageIndex == entry.key
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        // Overlay de hover (no bloquea gestos)
        if (_isHovered)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título del proyecto
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.15),
                          AppTheme.secondaryColor.withOpacity(0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.code_rounded,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.project.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Descripción
              Flexible(
                child: Text(
                  widget.project.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Botón de acción
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                final Uri url = Uri.parse(widget.project.link);
                await launchUrl(url, mode: LaunchMode.externalApplication);
              },
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text("Ver Proyecto"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: _isHovered ? 6 : 2,
                shadowColor: AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
