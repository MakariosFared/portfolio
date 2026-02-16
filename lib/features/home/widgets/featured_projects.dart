import 'package:flutter/material.dart';
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
    return _ProjectCard(
      title: _fakeProjects[index]['title']!,
      description: _fakeProjects[index]['description']!,
      tags: _fakeProjects[index]['tags'] as List<String>,
      imageUrl: _fakeProjects[index]['image']!,
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
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
            ? (Matrix4.identity()..translate(0, -10, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
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
              /// 🖼 Image
              SizedBox(
                height: isMobile ? 180 : 360,
                width: double.infinity,
                child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
              ),

              /// 📄 Content
              Padding(
                padding: EdgeInsets.all(isMobile ? 14 : 20),
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
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryLight,
                              fontSize: isMobile ? 14 : 16,
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
                        color: AppColors.textLight,
                        fontSize: isMobile ? 12 : 14,
                      ),
                      maxLines: isMobile
                          ? 4
                          : 10, // Higher maxLines for natural flow
                      overflow: TextOverflow.visible, // Allow it to show fully
                    ),

                    SizedBox(height: isMobile ? 16 : 24),

                    Divider(
                      color: AppColors.textLight,
                      thickness: 1,
                    ),

                    SizedBox(height: isMobile ? 16 : 24),

                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isMobile || isHovered ? 1.0 : 0.0,
                      child: Row(
                        children: [
                          Text(
                            'View Project',
                            style: AppTypography.button.copyWith(
                              color: AppColors.accent,
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: AppColors.accent,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isMobile ? 12 : 24),
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
      'Real-time Location Tracking',
    ],
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
      'Real-time Location Tracking',
    ],
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
  },
  {
    'title': 'Bookly App – Book Browsing & Reading',
    'description':
        'A collaborative project management tool for teams with drag-and-drop support and detailed analytics.',
    'image': 'assets/images/bookly_app.png',
    'tags': ['Flutter', 'MVP', 'Cubit'],
  },
];
