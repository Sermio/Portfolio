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
  bool _showDescription = false;
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        height: 500,
        decoration: BoxDecoration(
          color: _showDescription ? theme.cardColor : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryColor.withOpacity(0.4)
                : theme.dividerColor.withOpacity(0.1),
            width: _isHovered ? 2.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppTheme.primaryColor.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              spreadRadius: _isHovered ? 2 : 0,
              blurRadius: _isHovered ? 15 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Contenido de la imagen (carrusel) - ocupa toda la card
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AnimatedOpacity(
                  opacity: _showDescription ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: _showDescription
                      ? const SizedBox.shrink()
                      : _buildImageCarousel(theme),
                ),
              ),
            ),
            // Contenido de la descripción
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AnimatedOpacity(
                  opacity: _showDescription ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: _showDescription
                      ? _buildDescriptionContent(theme)
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            // Indicadores del carrusel superpuestos (solo cuando se muestran imágenes)
            if (!_showDescription && widget.project.images.length > 1)
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.project.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _currentImageIndex == entry.key ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentImageIndex == entry.key
                              ? Colors.black
                              : Colors.black.withOpacity(0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            // Botones superpuestos
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Botón para ver descripción/imagen (siempre visible)
                    if (!_showDescription)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _showDescription = !_showDescription;
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "+Info",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Flecha para volver (solo visible cuando se muestra la descripción)
                    if (_showDescription)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _showDescription = !_showDescription;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Botón para ver proyecto (solo visible cuando se muestra la descripción)
                    if (_showDescription) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
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
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: _isHovered ? 8 : 4,
                            shadowColor: AppTheme.primaryColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(ThemeData theme) {
    if (widget.project.images.isEmpty) {
      return Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return CarouselSlider(
          carouselController: _carouselController,
          items: widget.project.images.map((img) {
            return Image.asset(
              img,
              fit: BoxFit.cover,
              width: double.infinity,
            );
          }).toList(),
          options: CarouselOptions(
            height: constraints.maxHeight,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: widget.project.images.length > 1,
            autoPlay: widget.project.images.length > 1 && !_showDescription,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildDescriptionContent(ThemeData theme) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.15),
                      AppTheme.secondaryColor.withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.code,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.project.name,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                widget.project.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.8,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
