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
          const SizedBox(height: 40),

          // 🌟 Flagship Project Showcase: FeGo Platform
          const ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            child: _FeGoFlagshipCard(),
          ),

          const SizedBox(height: 60),

          // Subheader for Other Core Projects
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Other Core Projects',
                  style: AppTypography.h3.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Other Projects Grid
          Builder(
            builder: (context) {
              if (isMobile) {
                return Column(
                  children: List.generate(_otherProjects.length, (index) {
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

              // Desktop/Tablet: 2 columns
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ScrollReveal(
                      type: ScrollRevealType.fadeSlideUp,
                      delay: const Duration(milliseconds: 200),
                      child: _buildProjectCard(0),
                    ),
                  ),
                  const SizedBox(width: 35),
                  if (_otherProjects.length > 1)
                    Expanded(
                      child: ScrollReveal(
                        type: ScrollRevealType.fadeSlideUp,
                        delay: const Duration(milliseconds: 400),
                        child: _buildProjectCard(1),
                      ),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(int index) {
    final project = _otherProjects[index];
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

class _FeGoFlagshipCard extends StatefulWidget {
  const _FeGoFlagshipCard();

  @override
  State<_FeGoFlagshipCard> createState() => _FeGoFlagshipCardState();
}

class _FeGoFlagshipCardState extends State<_FeGoFlagshipCard> {
  bool isHovered = false;

  void _openImagePreview(BuildContext context, String imageUrl, String title) {
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
                child: Image.asset(imageUrl, fit: BoxFit.contain),
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
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = SizeConfig.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryLight
                : AppColors.primary.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: isHovered ? 0.25 : 0.12,
              ),
              blurRadius: isHovered ? 35 : 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 18 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Badge Header
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'FLAGSHIP CASE STUDY',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'TWO-SIDED PLATFORM (PASSENGER + DRIVER)',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Platform Title
                Text(
                  'FeGo – Real-Time Ride-Hailing Platform',
                  style: AppTypography.h2.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 22 : 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Platform Summary
                Text(
                  'Production-grade transportation ecosystem built entirely from scratch in Flutter. Connects riders and drivers in real time with bidirectional WebSocket events, live geospatial map tracking, and foreground/background push notifications.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                    fontSize: isMobile ? 14 : 16,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 24),

                // Dual Mockups Display
                isMobile
                    ? Column(
                        children: [
                          _buildMockupCard(
                            title: 'FeGo Passenger App',
                            badge: 'Rider Client',
                            image: 'assets/images/fego_user_app.png',
                            isMobile: true,
                          ),
                          const SizedBox(height: 16),
                          _buildMockupCard(
                            title: 'FeGo Driver App',
                            badge: 'Driver Partner',
                            image: 'assets/images/fego_driver_app.png',
                            isMobile: true,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildMockupCard(
                              title: 'FeGo Passenger App',
                              badge: 'Rider Client',
                              image: 'assets/images/fego_user_app.png',
                              isMobile: false,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildMockupCard(
                              title: 'FeGo Driver App',
                              badge: 'Driver Partner',
                              image: 'assets/images/fego_driver_app.png',
                              isMobile: false,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 28),

                // Key Technical Highlights Section
                Container(
                  padding: EdgeInsets.all(isMobile ? 16 : 22),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDark.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.psychology_rounded,
                            color: AppColors.primaryLight,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Key Engineering Highlights & Problem Solving',
                            style: AppTypography.h4.copyWith(
                              color: Colors.white,
                              fontSize: isMobile ? 15 : 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildHighlightItem(
                        title: 'Live WebSocket Synchronization:',
                        description:
                            'Maintained persistent duplex socket streams for instant ride dispatching, fare negotiations, driver pings, and state recovery upon network reconnect.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 10),
                      _buildHighlightItem(
                        title: 'Geospatial Interpolation:',
                        description:
                            'Integrated Google Maps SDK with coordinate interpolation (lerp) to smoothly animate moving vehicles on the map, eliminating GPS marker jumping.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 10),
                      _buildHighlightItem(
                        title: 'Deterministic State Machine:',
                        description:
                            'Employed Cubit to manage multi-step trip lifecycles (Requesting → Accepted → In-Trip → Completed) with zero state corruption across disconnects.',
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tags Matrix
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Flutter SDK',
                    'Clean Architecture',
                    'Cubit State Machine',
                    'WebSockets (Live Duplex)',
                    'Google Maps SDK',
                    'Firebase Cloud Messaging (FCM)',
                    'Dio / REST APIs',
                    'Foreground GPS Streaming',
                  ].map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile ? 11 : 13,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Action Buttons Row
                Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => launchLink('https://play.google.com/store/search?q=fego&c=apps'),
                      icon: const FaIcon(
                        FontAwesomeIcons.googlePlay,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Google Play Store',
                        style: AppTypography.button.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 24,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openImagePreview(
                        context,
                        'assets/images/fego_user_app.png',
                        'FeGo Passenger App',
                      ),
                      icon: const Icon(Icons.fullscreen_rounded, size: 18, color: Colors.white),
                      label: Text(
                        'Zoom Passenger UI',
                        style: AppTypography.button.copyWith(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 20,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openImagePreview(
                        context,
                        'assets/images/fego_driver_app.png',
                        'FeGo Driver App',
                      ),
                      icon: const Icon(Icons.fullscreen_rounded, size: 18, color: Colors.white),
                      label: Text(
                        'Zoom Driver UI',
                        style: AppTypography.button.copyWith(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 20,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMockupCard({
    required String title,
    required String badge,
    required String image,
    required bool isMobile,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _openImagePreview(context, image, title),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: SizedBox(
                height: isMobile ? 180 : 270,
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem({
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Icon(Icons.arrow_right_rounded, color: AppColors.primaryLight, size: 18),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$title ',
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 13 : 14,
              ),
              children: [
                TextSpan(
                  text: description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.normal,
                    height: 1.45,
                    fontSize: isMobile ? 12 : 13.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final List<Map<String, dynamic>> _otherProjects = [
  {
    'title': 'Dikkan – Multi-Vendor Retail Platform',
    'description':
        'A comprehensive multi-vendor mobile marketplace connecting customers with nearby merchants. Engineered with Clean Architecture & Cubit, featuring offline cart caching via Hive, phone OTP authentication, real-time order status tracking, and RESTful API integration.',
    'image': 'assets/images/dikkan_app.png',
    'tags': [
      'Flutter SDK',
      'Clean Architecture',
      'Cubit',
      'Hive (Offline-First)',
      'REST APIs',
      'Google Maps',
    ],
    'githubUrl': 'https://github.com/MakariosFared',
    'liveUrl': null,
  },
  {
    'title': 'Bookly – Catalog & Reader Client',
    'description':
        'A clean reference implementation of Feature-First Clean Architecture utilizing the Google Books REST API. Emphasizes clean repository patterns, robust error/loading UI states, and custom widget composition with zero third-party UI framework dependencies.',
    'image': 'assets/images/bookly_app.png',
    'tags': [
      'Flutter SDK',
      'Google Books REST API',
      'Clean Architecture',
      'Cubit',
      'MVVM Pattern',
    ],
    'githubUrl': 'https://github.com/MakariosFared/Bookly-App',
    'liveUrl': null,
  },
];


