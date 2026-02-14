import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';

class ExpertiseItem {
  final String title;
  final IconData icon;
  final Color color;

  ExpertiseItem({required this.title, required this.icon, required this.color});
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
    final categories = <ExpertiseCategory>[
      // ... existing categories (kept for brevity in replacement)
      ExpertiseCategory(
        title: 'Mobile Development',
        items: [
          ExpertiseItem(
            title: 'Flutter',
            icon: Icons.flutter_dash,
            color: const Color(0xFF02569B),
          ),
          ExpertiseItem(
            title: 'Dart',
            icon: Icons.code,
            color: const Color(0xFF0175C2),
          ),
        ],
      ),
      ExpertiseCategory(
        title: 'State Management',
        items: [
          ExpertiseItem(
            title: 'BLoC',
            icon: Icons.layers,
            color: const Color(0xFF5A67D8),
          ),
          ExpertiseItem(
            title: 'Cubit',
            icon: Icons.architecture,
            color: const Color(0xFF667EEA),
          ),
          ExpertiseItem(
            title: 'GetX',
            icon: Icons.dynamic_feed,
            color: const Color(0xFF764BA2),
          ),
        ],
      ),
      ExpertiseCategory(
        title: 'Backend & Data',
        items: [
          ExpertiseItem(
            title: 'Firebase',
            icon: Icons.fireplace,
            color: const Color(0xFFFFCA28),
          ),
          ExpertiseItem(
            title: 'RESTful APIs',
            icon: Icons.api,
            color: const Color(0xFF00B894),
          ),
          ExpertiseItem(
            title: 'Real-time DB',
            icon: Icons.storage,
            color: const Color(0xFFFDAA5D),
          ),
        ],
      ),
      ExpertiseCategory(
        title: 'Tools & UI/UX',
        items: [
          ExpertiseItem(
            title: 'Responsive Design',
            icon: Icons.devices,
            color: const Color(0xFF74B9FF),
          ),
          ExpertiseItem(
            title: 'Animation',
            icon: Icons.animation,
            color: const Color(0xFFF093FB),
          ),
          ExpertiseItem(
            title: 'Git',
            icon: Icons.terminal,
            color: const Color(0xFFF05032),
          ),
          ExpertiseItem(
            title: 'GitHub',
            icon: Icons.code_off,
            color: const Color(0xFF2D3436),
          ),
        ],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final bool isTablet = constraints.maxWidth < 1025;
        final double horizontalPadding = isMobile ? 20 : 40;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: 'Technical Expertise', isMobile: isMobile),
              const SizedBox(height: 50),

              ...categories.map(
                (category) => _ExpertiseSection(
                  title: category.title,
                  items: category.items,
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpertiseSection extends StatelessWidget {
  final String title;
  final List<ExpertiseItem> items;
  final bool isMobile;
  final bool isTablet;

  const _ExpertiseSection({
    required this.title,
    required this.items,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          type: ScrollRevealType.fadeSlideUp,
          offset: 20,
          child: Text(
            title,
            style: AppTypography.h4.copyWith(
              color: AppColors.textLight.withValues(alpha: 0.7),
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
            crossAxisSpacing: isMobile ? 12 : 25,
            mainAxisSpacing: isMobile ? 12 : 25,
            childAspectRatio: isMobile ? 1.1 : (isTablet ? 1.3 : 1.5),
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ScrollReveal(
              type: ScrollRevealType.fadeSlideUp,
              delay: Duration(milliseconds: 100 * index),
              offset: 30,
              child: _ExpertiseCard(item: item, isMobile: isMobile, isTablet: isTablet),
            );
          },
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _ExpertiseCard extends StatefulWidget {
  final ExpertiseItem item;
  final bool isMobile;
  final bool isTablet;

  const _ExpertiseCard({required this.item, required this.isMobile, required this.isTablet});

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
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: widget.isMobile || widget.isTablet
              ? BoxDecoration(
                  color: widget.item.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: widget.item.color, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: widget.item.color.withValues(alpha: 0.2),
                      blurRadius: 25,
                      spreadRadius: -5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                )
              : BoxDecoration(
                  color: isHovered
                      ? widget.item.color.withValues(alpha: 0.15)
                      : AppColors.surfaceDark.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isHovered
                        ? widget.item.color
                        : AppColors.border.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: widget.item.color.withValues(alpha: 0.2),
                            blurRadius: 25,
                            spreadRadius: -5,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [],
                ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isMobile || widget.isTablet
                          ? widget.item.color.withValues(alpha: 0.2)
                          : isHovered
                          ? widget.item.color.withValues(alpha: 0.2)
                          : Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isHovered
                              ? widget.item.color.withValues(alpha: 0.2)
                              : widget.item.color.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.item.icon,
                          size: 28,
                          color: isHovered
                              ? widget.item.color
                              : AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.item.title,
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyLarge.copyWith(
                          color: isHovered
                              ? widget.item.color
                              : AppColors.textLight,
                          fontWeight: isHovered
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
