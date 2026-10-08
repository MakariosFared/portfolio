import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/utils/responsive/size_config.dart';

class FeaturedProjects extends StatelessWidget {
  const FeaturedProjects({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isMobile = SizeConfig.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Featured Projects'),
          const SizedBox(height: 50),

          Builder(
            builder: (context) {
              if (isMobile) {
                return Column(
                  children: List.generate(_fakeProjects.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: ScrollReveal(
                        type: ScrollRevealType.fadeSlideUp,
                        delay: Duration(milliseconds: 200 * index),
                        child: _buildProjectCard(index),
                      ),
                    );
                  }),
                );
              }

              // Desktop/Tablet: 2 columns using Rows
              final List<Widget> rows = [];
              for (int i = 0; i < _fakeProjects.length; i += 2) {
                rows.add(
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ScrollReveal(
                            type: ScrollRevealType.fadeSlideUp,
                            delay: const Duration(milliseconds: 200),
                            child: _buildProjectCard(i),
                          ),
                        ),
                        const SizedBox(width: 35),
                        if (i + 1 < _fakeProjects.length)
                          Expanded(
                            child: ScrollReveal(
                              type: ScrollRevealType.fadeSlideUp,
                              delay: const Duration(milliseconds: 400),
                              child: _buildProjectCard(i + 1),
                            ),
                          )
                        else
                          const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                );
              }
              return Column(children: rows);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(int index) {
    final project = _fakeProjects[index];
    return _ProjectCard(
      title: project['title']!,
      description: project['description']!,
      tags: project['tags'] as List<String>,
      imageUrl: project['image']!,
      githubUrl: project['githubUrl'] as String?,
      liveUrl: project['liveUrl'] as String?,
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;
  final String? githubUrl;
  final String? liveUrl;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = SizeConfig.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: !isMobile && isHovered
            ? Matrix4.translationValues(0.0, -10.0, 0.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.border.withValues(alpha: 0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: !isMobile && isHovered ? 0.3 : 0.15,
              ),
              blurRadius: !isMobile && isHovered ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🖼 Interactive Image with Fullscreen Preview
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogCtx) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: InteractiveViewer(
                              child: Image.asset(
                                widget.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: IconButton(
                              onPressed: () => Navigator.pop(dialogCtx),
                              icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: isMobile ? 190 : 340,
                      width: double.infinity,
                      child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.fullscreen_rounded, size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              'Zoom',
                              style: AppTypography.caption.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 📄 Content
              Padding(
                padding: EdgeInsets.all(isMobile ? 14 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryLight,
                              fontSize: isMobile ? 12 : 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: isMobile ? 12 : 16),

                    Text(
                      widget.title,
                      style: AppTypography.h3.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 22,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      widget.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                        fontSize: isMobile ? 12 : 14,
                        height: 1.5,
                      ),
                      maxLines: isMobile ? 4 : 10,
                      overflow: TextOverflow.visible,
                    ),

                    const SizedBox(height: 20),

                    Divider(
                      color: AppColors.border.withValues(alpha: 0.1),
                      thickness: 1,
                    ),

                    const SizedBox(height: 12),

                    /// Action Buttons
                    Row(
                      children: [
                        if (widget.githubUrl != null)
                          ElevatedButton.icon(
                            onPressed: () => launchLink(widget.githubUrl!),
                            icon: const FaIcon(
                              FontAwesomeIcons.github,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text(
                              'GitHub',
                              style: AppTypography.button.copyWith(
                                color: Colors.white,
                                fontSize: isMobile ? 13 : 14,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.25),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              side: BorderSide(
                                color: AppColors.primary.withValues(alpha: 0.4),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 10 : 12,
                              ),
                            ),
                          ),
                        if (widget.githubUrl != null && widget.liveUrl != null)
                          const SizedBox(width: 12),
                        if (widget.liveUrl != null)
                          OutlinedButton.icon(
                            onPressed: () => launchLink(widget.liveUrl!),
                            icon: const Icon(
                              Icons.open_in_new,
                              size: 16,
                              color: AppColors.accent,
                            ),
                            label: Text(
                              'Preview',
                              style: AppTypography.button.copyWith(
                                color: AppColors.accent,
                                fontSize: isMobile ? 13 : 14,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.accent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 10 : 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _fakeProjects = [
  {
    'title': 'Fego Driver – Ride-Hailing Driver App',
    'description':
        'A driver-side mobile application for a ride-hailing platform, enabling real-time trip tracking, ride requests management, live location updates via Google Maps, and instant push notifications using Firebase. 🚗📍🔔',
    'image': 'assets/images/fego_driver_app.png',
    'tags': [
      'Flutter',
      'Google Maps',
      'FCM',
      'Cubit',
      'MVVM Architecture',
      'RESTful APIs',
      'WebSockets',
      'Real-time Tracking',
    ],
    'githubUrl': 'https://github.com/MakariosFared',
    'liveUrl': null,
  },
  {
    'title': 'Fego – Ride-Hailing Passenger App',
    'description':
        'A passenger-side mobile application for a ride-hailing platform, enabling users to book rides, track drivers in real-time, manage payments, and receive instant notifications. 🚗📍🔔',
    'image': 'assets/images/fego_user_app.png',
    'tags': [
      'Flutter',
      'Google Maps',
      'FCM',
      'Cubit',
      'MVVM Architecture',
      'RESTful APIs',
      'WebSockets',
      'Real-time Tracking',
    ],
    'githubUrl': 'https://github.com/MakariosFared',
    'liveUrl': null,
  },
  {
    'title': 'Dikkan – Multi-Vendor E-Commerce App',
    'description':
        'A mobile app that connects users with nearby stores, enabling product search, cart management, and smooth checkout with real-time order tracking. 🛒📍',
    'image': 'assets/images/dikkan_app.png',
    'tags': [
      'Flutter',
      'RESTful APIs',
      'Cubit',
      'MVVM Architecture',
      'Google Maps',
      'Hive',
    ],
    'githubUrl': 'https://github.com/MakariosFared',
    'liveUrl': null,
  },
  {
    'title': 'Bookly App – Book Browsing & Reading',
    'description':
        'A modern book browsing and reading application built with Flutter, integrating the Google Books API. Features book search, previewing, rating, and clean UI animations built with MVVM and Cubit. 📚✨',
    'image': 'assets/images/bookly_app.png',
    'tags': [
      'Flutter',
      'Google Books API',
      'Clean Architecture',
      'Cubit',
      'MVVM',
    ],
    'githubUrl': 'https://github.com/MakariosFared',
    'liveUrl': null,
  },
];

