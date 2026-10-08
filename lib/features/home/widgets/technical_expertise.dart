import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/utils/responsive/size_config.dart';

class ExpertiseItem {
  final String title;
  final String subtitle;
  final dynamic icon;
  final Color color;

  ExpertiseItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class ExpertiseCategory {
  final String title;
  final List<ExpertiseItem> items;

  ExpertiseCategory({required this.title, required this.items});
}

class TechnicalExpertise extends StatelessWidget {
  const TechnicalExpertise({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final categories = <ExpertiseCategory>[
      ExpertiseCategory(
        title: 'Core Framework & Dart',
        items: [
          ExpertiseItem(
            title: 'Flutter SDK',
            subtitle: 'iOS, Android & Web Platforms',
            icon: Icons.flutter_dash,
            color: const Color(0xFF02569B),
          ),
          ExpertiseItem(
            title: 'Dart Language',
            subtitle: 'OOP, Streams, Async & Null Safety',
            icon: Icons.code,
            color: const Color(0xFF0175C2),
          ),
          ExpertiseItem(
            title: 'Custom Widgets',
            subtitle: 'Reusable Component Systems',
            icon: Icons.widgets_rounded,
            color: const Color(0xFF00B4D8),
          ),
          ExpertiseItem(
            title: 'Responsive UI',
            subtitle: 'Adaptive Multi-Screen Specs',
            icon: Icons.stay_current_portrait_rounded,
            color: const Color(0xFF74B9FF),
          ),
        ],
      ),
      ExpertiseCategory(
        title: 'Architecture & State Management',
        items: [
          ExpertiseItem(
            title: 'Clean Architecture',
            subtitle: 'Data, Domain & UI Separation',
            icon: Icons.account_tree_rounded,
            color: const Color(0xFF10B981),
          ),
          ExpertiseItem(
            title: 'BLoC & Cubit',
            subtitle: 'Event-Driven Reactive State',
            icon: FontAwesomeIcons.cubes,
            color: const Color(0xFF5A67D8),
          ),
          ExpertiseItem(
            title: 'Repository Pattern',
            subtitle: 'Decoupled Abstract Data Sources',
            icon: Icons.alt_route_rounded,
            color: const Color(0xFF6366F1),
          ),
          ExpertiseItem(
            title: 'SOLID Principles',
            subtitle: 'Maintainable & Testable Codebase',
            icon: Icons.verified_user_rounded,
            color: const Color(0xFF8B5CF6),
          ),
        ],
      ),
      ExpertiseCategory(
        title: 'Networking & Real-Time Data',
        items: [
          ExpertiseItem(
            title: 'WebSockets',
            subtitle: 'Live Bidirectional Event Streams',
            icon: Icons.swap_calls_rounded,
            color: const Color(0xFFE17055),
          ),
          ExpertiseItem(
            title: 'RESTful APIs',
            subtitle: 'Dio, Interceptors & Error Models',
            icon: Icons.api_rounded,
            color: const Color(0xFF00B894),
          ),
          ExpertiseItem(
            title: 'Firebase & FCM',
            subtitle: 'Targeted & Background Push Alerts',
            icon: FontAwesomeIcons.fire,
            color: const Color(0xFFFFCA28),
          ),
          ExpertiseItem(
            title: 'Local Storage & DB',
            subtitle: 'Hive, SQLite & Offline Persistence',
            icon: Icons.storage_rounded,
            color: const Color(0xFFFDAA5D),
          ),
        ],
      ),
      ExpertiseCategory(
        title: 'Tooling & Mobile Ecosystem',
        items: [
          ExpertiseItem(
            title: 'Google Maps SDK',
            subtitle: 'Geospatial Markers & Route Polylines',
            icon: Icons.map_rounded,
            color: const Color(0xFF4285F4),
          ),
          ExpertiseItem(
            title: 'Git & GitHub',
            subtitle: 'Branching, PRs & Version Control',
            icon: FontAwesomeIcons.github,
            color: const Color(0xFFB0BEC5),
          ),
          ExpertiseItem(
            title: 'Postman',
            subtitle: 'API Contract Testing & Debugging',
            icon: Icons.send_rounded,
            color: const Color(0xFFFF6C37),
          ),
          ExpertiseItem(
            title: 'Smooth Animations',
            subtitle: 'Micro-interactions & Physics',
            icon: Icons.animation_rounded,
            color: const Color(0xFFF093FB),
          ),
        ],
      ),
    ];

    final bool isMobile = SizeConfig.isMobile;
    final double horizontalPadding = isMobile ? 20 : 40;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Technical Expertise'),
          const SizedBox(height: 50),
          ...categories.map(
            (category) =>
                _ExpertiseSection(title: category.title, items: category.items),
          ),
        ],
      ),
    );
  }
}

class _ExpertiseSection extends StatelessWidget {
  final String title;
  final List<ExpertiseItem> items;

  const _ExpertiseSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile;
    final bool isTablet = SizeConfig.isTablet;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          type: ScrollRevealType.fadeSlideUp,
          offset: 20,
          child: Text(
            title,
            style: AppTypography.h4.copyWith(
              color: AppColors.textOnPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ScrollReveal(
          type: ScrollRevealType.fadeSlideUp,
          offset: 10,
          delay: const Duration(milliseconds: 100),
          child: Divider(
            color: AppColors.border.withValues(alpha: 0.1),
            thickness: 1,
          ),
        ),
        const SizedBox(height: 25),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
            crossAxisSpacing: isMobile ? 12 : 20,
            mainAxisSpacing: isMobile ? 12 : 20,
            childAspectRatio: isMobile ? 1.05 : (isTablet ? 1.25 : 1.35),
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _ExpertiseCard(item: item);
          },
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _ExpertiseCard extends StatefulWidget {
  final ExpertiseItem item;

  const _ExpertiseCard({required this.item});

  @override
  State<_ExpertiseCard> createState() => _ExpertiseCardState();
}

class _ExpertiseCardState extends State<_ExpertiseCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02, // 👈 subtle scale for desktop
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile;
    final bool isTablet = SizeConfig.isTablet;
    final bool isDesktop = !isMobile && !isTablet;

    return MouseRegion(
      onEnter: (_) {
        if (isDesktop) {
          setState(() => isHovered = true);
          _controller.forward();
        }
      },
      onExit: (_) {
        if (isDesktop) {
          setState(() => isHovered = false);
          _controller.reverse();
        }
      },
      child: ScrollReveal(
        type: ScrollRevealType.fadeSlideUp,
        offset: 20,
        child: ScaleTransition(
          scale: isDesktop ? _scaleAnimation : const AlwaysStoppedAnimation(1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: isDesktop
                ? BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isHovered
                          ? widget.item.color
                          : AppColors.border.withValues(alpha: 0.15),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isHovered
                            ? widget.item.color.withValues(alpha: 0.25)
                            : Colors.black.withValues(alpha: 0.2),
                        blurRadius: isHovered ? 30 : 15,
                        spreadRadius: -5,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  )
                : BoxDecoration(
                    color: widget.item.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.item.color.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 16,
                vertical: isMobile ? 12 : 18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.item.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: widget.item.icon is IconData
                        ? Icon(
                            widget.item.icon as IconData,
                            size: isMobile
                                ? 22
                                : (isTablet ? 26 : 32),
                            color: isHovered && isDesktop
                                ? widget.item.color
                                : AppColors.textOnPrimary,
                          )
                        : FaIcon(
                            widget.item.icon as FaIconData,
                            size: isMobile
                                ? 22
                                : (isTablet ? 26 : 32),
                            color: isHovered && isDesktop
                                ? widget.item.color
                                : AppColors.textOnPrimary,
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.item.title,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge.copyWith(
                      fontSize: isMobile ? 13 : 16,
                      fontWeight: FontWeight.bold,
                      color: isHovered && isDesktop
                          ? widget.item.color
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      fontSize: isMobile ? 11 : 12,
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
