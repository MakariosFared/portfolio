import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class JourneyItem {
  final String role;
  final String company;
  final String period;
  final String description;
  final String? description2;
  final String? description3;
  final IconData icon;

  JourneyItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.description2,
    this.description3,
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
        description: 'Built feature-rich ride-booking',
        description2:
            'Fego App: Ride-booking app with Google Maps, WebSockets, and FCM.',
        description3:
            'Fego Driver App: Driver-focused app with real-time request handling.',
        icon: Icons.rocket_launch_rounded,
      ),
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Shrka',
        period: 'Apr 2025 - Aug 2025',
        description: 'CRM Mobile Application',
        description2:
            'A full-featured CRM mobile application developed with Flutter to empower sales teams with real-time access to leads, customer data, and sales pipelines. The app improves productivity by enabling fast updates, seamless API integration, and a responsive UI optimized for field usage. The solution was designed for scalability, performance, and maintainability in a production environment.',
        icon: Icons.devices_other_rounded,
      ),
      JourneyItem(
        role: 'Freelance Mobile Developer',
        company: 'Global Clients',
        period: '2023 - Present',
        description: 'Dikkan – Multi-Vendor E-Commerce Platform',
        description2:
            'Built a scalable multi-vendor e-commerce mobile application using Flutter that connects customers with multiple local shops in one platform. The app allows users to authenticate via OTP, discover nearby stores using Google Maps, browse products by category, manage a shopping cart, and track orders in real time. The solution integrates with RESTful APIs, follows a clean architecture approach with state management, and focuses on performance, reliability, and a smooth user experience for daily shopping needs.',
        icon: Icons.code_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double horizontalPadding = isMobile ? 20 : 40;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 800),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 35,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'Professional Journey',
                      style: AppTypography.h2.copyWith(
                        color: AppColors.textLight,
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // Timeline and Cards
              isMobile
                  ? Column(
                      children: journeyItems.asMap().entries.map((entry) {
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * entry.key),
                          child: _JourneyCard(
                            item: entry.value,
                            isFirst: entry.key == 0,
                            isLast: entry.key == journeyItems.length - 1,
                            isMobile: true,
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
                        Column(
                          children: journeyItems.asMap().entries.map((entry) {
                            return FadeInUp(
                              delay: Duration(milliseconds: 200 * entry.key),
                              child: _JourneyCard(
                                item: entry.value,
                                isFirst: entry.key == 0,
                                isLast: entry.key == journeyItems.length - 1,
                                isMobile: false,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _JourneyCard extends StatefulWidget {
  final JourneyItem item;
  final bool isFirst;
  final bool isLast;
  final bool isMobile;

  const _JourneyCard({
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.isMobile,
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
            margin: EdgeInsets.only(left: widget.isMobile ? 0 : 60, bottom: 40),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
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
                if (!widget.isMobile)
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
                                      ? AppColors.textLight
                                      : AppColors.textLight.withValues(
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
                        if (!widget.isMobile)
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
                    if (widget.isMobile) ...[
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
                    if (widget.item.description2 != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.arrow_right,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.item.description2!,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textOnPrimary.withValues(
                                  alpha: 0.8,
                                ),
                                height: 1.6,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (widget.item.description3 != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.arrow_right,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.item.description3!,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textOnPrimary.withValues(
                                  alpha: 0.8,
                                ),
                                height: 1.6,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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
