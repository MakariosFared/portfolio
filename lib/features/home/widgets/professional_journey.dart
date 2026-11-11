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
  final String employmentType;
  final String description;
  final List<String> impactMetrics;
  final List<String> bulletPoints;
  final List<String> technologies;
  final IconData icon;

  JourneyItem({
    required this.role,
    required this.company,
    required this.period,
    required this.employmentType,
    required this.description,
    required this.impactMetrics,
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
      // 🚀 1. Flieger Tech (Flagship Ride-Hailing)
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Flieger Tech',
        period: 'Aug 2025 - Present',
        employmentType: 'Full-Time',
        description:
            'Architected and delivered two flagship production-grade mobile platforms from scratch: FeGo Passenger and FeGo Driver ride-hailing applications.',
        impactMetrics: [
          '⚡ 60fps Map Tracking',
          '📡 <50ms WebSockets',
          '📱 2 Apps in Production',
          '🎯 100% Clean Architecture',
        ],
        bulletPoints: [
          'Engineered full-duplex WebSocket pipelines for zero-latency ride requests, driver dispatching, trip state transitions, and live fare updates.',
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
          'FCM High-Priority',
          'Clean Architecture',
          'Dio Interceptors',
        ],
        icon: Icons.rocket_launch_rounded,
      ),

      // 💼 2. Shrka (Enterprise CRM)
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Shrka',
        period: 'Apr 2025 - Aug 2025',
        employmentType: 'Agile Engineering Team',
        description:
            'Engineered an enterprise CRM mobile solution within an agile engineering team, empowering sales forces with real-time lead pipelines and operational insights.',
        impactMetrics: [
          '📦 Offline-First Hive Sync',
          '🔄 Auto JWT Refresh Interceptor',
          '💼 Enterprise Sales Pipeline',
        ],
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
          'Hive Local DB',
          'Dio Interceptors',
          'RESTful APIs',
        ],
        icon: Icons.devices_other_rounded,
      ),

      // 🌐 3. Freelance & Client Products
      JourneyItem(
        role: 'Freelance Mobile Developer & SaaS Builder',
        company: 'Client Projects & Products',
        period: '2023 - Present',
        employmentType: 'Independent / Contracts',
        description:
            'Designed, developed, and deployed high-performance mobile applications and SaaS platforms for clients, emphasizing Clean Architecture and clean code principles.',
        impactMetrics: [
          '⚡ Prolio Full-Stack SaaS',
          '📚 Mini Offline LMS App',
          '🛍️ Multi-Vendor Dikkan App',
        ],
        bulletPoints: [
          'Thaheen LMS: Built a local-first offline learning platform with sequential lesson unlocking, video playback state persistence via Hive, and unit-tested domain rules.',
          'Dikkan: Engineered a multi-vendor marketplace featuring OTP authentication, Google Maps vendor discovery, shopping carts, and live order tracking.',
          'Prolio SaaS: Built a modern full-stack portfolio & resume SaaS builder with Next.js 16, Supabase RLS, and Gemini/Groq AI Copilot.',
          'Maintained strict Clean Architecture standards, separation of concerns, dependency injection (GetIt), and testable business logic.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Clean Architecture',
          'Next.js 16',
          'Supabase RLS',
          'Hive',
          'Unit Testing',
          'GetIt',
        ],
        icon: Icons.code_rounded,
      ),

      // 🤖 4. Graduation Project – IoT & Robotics Lead
      JourneyItem(
        role: 'IoT & Mobile Systems Lead (Graduation Project)',
        company: 'Faculty of Engineering – Graduation Project',
        period: '2024 - 2025',
        employmentType: 'Graduation Project 🎓',
        description:
            'Led the hardware-software integration engineering team to design, manufacture, and program an autonomous medical assistance robot with a companion Flutter remote controller.',
        impactMetrics: [
          '🏆 Ranked Top Tier / Excellent',
          '🤖 Low-Latency RFCOMM Serial',
          '📹 Live MJPEG Stream Feed',
          '🛡️ Hardware Watchdog Fail-Safe',
        ],
        bulletPoints: [
          'Pioneered bi-directional Bluetooth RFCOMM communication protocol with custom binary packet framing for continuous on-screen virtual joystick navigation.',
          'Implemented emergency watchdog safety failsafes: if telemetry drops for >500ms, the robot microcontroller triggers an immediate emergency motor brake.',
          'Built a custom low-latency MJPEG video streaming canvas and an offline SQLite prescription dispensing scheduler with exact local alarms.',
          'Delivered a successful live physical hardware demonstration during university graduation project defense before the engineering faculty committee.',
        ],
        technologies: [
          'Flutter SDK',
          'Bluetooth Serial (RFCOMM)',
          'ESP32 / Microcontrollers',
          'MJPEG Streaming',
          'SQLite Local-First',
          'Hardware HAL',
        ],
        icon: Icons.smart_toy_rounded,
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
          const SizedBox(height: 50),

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
                      top: 10,
                      bottom: 40,
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
                                AppColors.accent.withValues(alpha: 0.6),
                                AppColors.primary.withValues(alpha: 0.2),
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
                          delay: Duration(milliseconds: 150 * entry.key),
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
      end: 1.015,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.01),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = AppColors.getSurface(context);
    final bgColor = AppColors.getBackground(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

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
              bottom: 36,
            ),
            padding: EdgeInsets.all(SizeConfig.isMobile ? 20 : 30),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isHovered
                    ? AppColors.primary.withValues(alpha: 0.6)
                    : borderColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: isHovered ? 30 : 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Timeline dot for wide screens
                if (!SizeConfig.isMobile)
                  Positioned(
                    left: -70,
                    top: 14,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                        border: Border.all(
                          color: isHovered
                              ? AppColors.primaryLight
                              : AppColors.primary,
                          width: isHovered ? 5 : 4,
                        ),
                        boxShadow: isHovered
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.6),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                    ),
                  ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row: Icon, Role, Company, Period & Type
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: isHovered ? AppColors.primaryGradient : null,
                            color: isHovered
                                ? null
                                : AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: isHovered
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.35),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            widget.item.icon,
                            color: isHovered ? Colors.white : AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.role,
                                style: AppTypography.h4.copyWith(
                                  color: textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.isMobile ? 18 : 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.item.company,
                                style: AppTypography.bodyLarge.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.isMobile ? 14 : 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!SizeConfig.isMobile)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(alpha: 0.25),
                                  ),
                                ),
                                child: Text(
                                  widget.item.period,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.item.employmentType,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    if (SizeConfig.isMobile) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              widget.item.period,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.item.employmentType,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    // ⚡ High-Signal Impact Badges
                    if (widget.item.impactMetrics.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.item.impactMetrics.map((metric) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              metric,
                              style: AppTypography.caption.copyWith(
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    const SizedBox(height: 16),
                    Text(
                      widget.item.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: textSecondary,
                        height: 1.6,
                        fontSize: SizeConfig.isMobile ? 14 : 15.5,
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
                                    color: textSecondary,
                                    height: 1.55,
                                    fontSize: SizeConfig.isMobile ? 13.5 : 14.5,
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
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.25),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
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
