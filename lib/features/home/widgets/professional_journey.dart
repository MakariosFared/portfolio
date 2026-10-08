import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/utils/responsive/size_config.dart';

class JourneyItem {
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> bulletPoints;
  final List<String> technologies;
  final IconData icon;

  JourneyItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.bulletPoints,
    required this.technologies,
    required this.icon,
  });
}

class ProfessionalJourney extends StatelessWidget {
  const ProfessionalJourney({super.key});

  @override
  Widget build(BuildContext context) {
    final journeyItems = <JourneyItem>[
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Flieger Tech',
        period: 'Aug 2025 - Present',
        description:
            'Architected and delivered two flagship production-grade mobile platforms from scratch: FeGo Passenger and FeGo Driver ride-hailing applications.',
        bulletPoints: [
          'Engineered full duplex WebSocket pipelines for zero-latency ride requests, driver dispatching, trip state transitions, and fare updates.',
          'Implemented real-time vehicle movement tracking on Google Maps using spherical coordinate interpolation (lerp) for smooth 60fps animations.',
          'Built deterministic state machines using BLoC & Cubit to maintain strict synchronization across complex trip lifecycles (requested, accepted, ongoing, completed).',
          'Integrated Firebase Cloud Messaging (FCM) with background/foreground priority channels ensuring reliable mission-critical notifications.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'BLoC / Cubit',
          'WebSockets',
          'Google Maps API',
          'FCM',
          'Clean Architecture',
          'Dio',
        ],
        icon: Icons.rocket_launch_rounded,
      ),
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Shrka',
        period: 'Apr 2025 - Aug 2025',
        description:
            'Engineered an enterprise CRM mobile solution within an agile engineering team, empowering sales forces with real-time lead pipelines and operational insights.',
        bulletPoints: [
          'Architected an offline-first data synchronization engine: persists sales leads locally when offline and automatically syncs with backend upon network reconnection.',
          'Developed complex state-driven features using BLoC & Cubit to manage multi-stage sales funnels and dynamic lead qualification pipelines.',
          'Constructed robust REST API integrations using Dio with interceptors for JWT token auto-refresh and centralized error handling.',
          'Collaborated closely with backend engineers and UI/UX designers to implement pixel-perfect, responsive field agent workflows.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'BLoC / Cubit',
          'Offline-First Sync',
          'Hive / Local DB',
          'Dio Interceptors',
          'RESTful APIs',
        ],
        icon: Icons.devices_other_rounded,
      ),
      JourneyItem(
        role: 'Freelance Mobile Developer',
        company: 'Client Projects & Products',
        period: '2023 - Present',
        description:
            'Designed, developed, and deployed high-performance mobile applications for clients, emphasizing Clean Architecture and clean code principles.',
        bulletPoints: [
          'Thaheen LMS: Built a local-first offline learning platform with sequential lesson unlocking, video playback state persistence via Hive, and unit-tested domain rules.',
          'Dikkan: Engineered a multi-vendor marketplace featuring OTP authentication, Google Maps vendor discovery, shopping carts, and live order tracking.',
          'Bookly: Built a clean e-reading application integrating the Google Books REST API with responsive search and reader views.',
          'Maintained strict Clean Architecture standards, separation of concerns, dependency injection (GetIt), and testable business logic.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Clean Architecture',
          'Hive',
          'Unit Testing',
          'GetIt',
          'REST APIs',
        ],
        icon: Icons.code_rounded,
      ),
    ];

    SizeConfig.init(context);
    final bool isMobile = SizeConfig.isMobile;
    final double horizontalPadding = isMobile ? 20 : 40;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Professional Journey'),
          const SizedBox(height: 60),

          // Timeline and Cards
          isMobile
              ? Column(
                  children: journeyItems.asMap().entries.map((entry) {
                    return ScrollReveal(
                      type: ScrollRevealType.fadeSlideUp,
                      delay: Duration(milliseconds: 100 * entry.key),
                      child: _JourneyCard(
                        item: entry.value,
                        isFirst: entry.key == 0,
                        isLast: entry.key == journeyItems.length - 1,
                      ),
                    );
                  }).toList(),
                )
              : Stack(
                  children: [
                    // Vertical Timeline Line
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: ScrollReveal(
                        type: ScrollRevealType.fadeSlideUp,
                        child: Container(
                          width: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primary,
                                AppColors.secondary.withValues(alpha: 0.5),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: journeyItems.asMap().entries.map((entry) {
                        return ScrollReveal(
                          type: ScrollRevealType.fadeSlideUp,
                          delay: Duration(milliseconds: 200 * entry.key),
                          child: _JourneyCard(
                            item: entry.value,
                            isFirst: entry.key == 0,
                            isLast: entry.key == journeyItems.length - 1,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _JourneyCard extends StatefulWidget {
  final JourneyItem item;
  final bool isFirst;
  final bool isLast;

  const _JourneyCard({
    required this.item,
    required this.isFirst,
    required this.isLast,
  });

  @override
  State<_JourneyCard> createState() => _JourneyCardState();
}

class _JourneyCardState extends State<_JourneyCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.015),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(
              left: SizeConfig.isMobile ? 0 : 60,
              bottom: 40,
            ),
            padding: const EdgeInsets.all(30),
            decoration: SizeConfig.isMobile
                ? BoxDecoration(
                    color: AppColors.surfaceDark.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  )
                : BoxDecoration(
                    color: isHovered
                        ? AppColors.surfaceDark.withValues(alpha: 0.6)
                        : AppColors.surfaceDark.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isHovered
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : AppColors.border.withValues(alpha: 0.1),
                      width: 1.5,
                    ),
                    boxShadow: isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ]
                        : [],
                  ),
            child: Stack(
              children: [
                // Timeline dot for wide screens
                if (!SizeConfig.isMobile)
                  Positioned(
                    left: -70,
                    top: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundDark,
                        border: Border.all(
                          color: isHovered
                              ? AppColors.primary
                              : AppColors.border.withValues(alpha: 0.3),
                          width: 4,
                        ),
                        boxShadow: isHovered
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
                                  blurRadius: 10,
                                ),
                              ]
                            : [],
                      ),
                    ),
                  ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.item.icon,
                            color: isHovered
                                ? AppColors.primaryLight
                                : AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.role,
                                style: AppTypography.h4.copyWith(
                                  color: isHovered
                                      ? AppColors.textOnPrimary
                                      : AppColors.textOnPrimary.withValues(
                                          alpha: 0.9,
                                        ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.item.company,
                                style: AppTypography.bodyLarge.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!SizeConfig.isMobile)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              widget.item.period,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (SizeConfig.isMobile) ...[
                      const SizedBox(height: 12),
                      Text(
                        widget.item.period,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Text(
                      widget.item.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                        height: 1.6,
                        fontSize: 16,
                      ),
                    ),
                    if (widget.item.bulletPoints.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      ...widget.item.bulletPoints.map(
                        (bullet) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.5),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  bullet,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textOnPrimary.withValues(
                                      alpha: 0.85,
                                    ),
                                    height: 1.55,
                                    fontSize: 14.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (widget.item.technologies.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.item.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.22),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
