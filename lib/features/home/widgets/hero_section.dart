import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/utils/responsive/size_config.dart';

class HomeHero extends StatelessWidget {
  final VoidCallback? onWorkTap;
  final VoidCallback? onContactTap;

  const HomeHero({super.key, this.onWorkTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final bool isMobile = SizeConfig.isMobile;
    final double horizontalPadding = isMobile ? 20 : 40;
    final double verticalPadding = isMobile ? 35 : 55;
    final double titleFontSize = isMobile ? 32 : 54;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        image: const DecorationImage(
          image: AssetImage('assets/images/background_image.jpg'),
          fit: BoxFit.cover,
          opacity: 0.08,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Avatar with Glowing Ring
          ScrollReveal(
            type: ScrollRevealType.zoomFade,
            duration: const Duration(milliseconds: 600),
            child: Container(
              margin: const EdgeInsets.only(bottom: 18),
              width: isMobile ? 105 : 135,
              height: isMobile ? 105 : 135,
              padding: const EdgeInsets.all(3.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.45),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.65),
                ),
              ),
            ),
          ),

          // Direct Greeting & Identity
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            duration: const Duration(milliseconds: 700),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Makarios Fared",
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Flutter Developer",
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 13 : 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Headline
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Engineering Reliable,\nProduction-Grade Mobile Apps',
              textAlign: TextAlign.center,
              style: AppTypography.h1.copyWith(
                color: AppColors.textOnPrimary,
                fontSize: titleFontSize,
                letterSpacing: -1.2,
                height: 1.15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Framework Specialization
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Specializing in ',
                style: AppTypography.h3.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 16 : 22,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Clean Architecture (BLoC/Cubit)',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.primaryLight,
                      fontSize: isMobile ? 16 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' & '),
                  TextSpan(
                    text: 'Real-Time APIs',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.secondaryLight,
                      fontSize: isMobile ? 16 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Available Status Badge
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Available for Full-Time & Contract Roles',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: isMobile ? 12 : 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Value Proposition Subtitle
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 700),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                'Flutter Developer with 2+ years of experience engineering production-grade mobile applications from scratch—including two-sided ride-hailing with real-time WebSockets, offline-first sync architectures, and Google Maps tracking.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 14 : 16,
                  height: 1.55,
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),

          // CTAs (Above the Fold)
          isMobile
              ? Column(
                  children: [
                    ScrollReveal(
                      type: ScrollRevealType.zoomFade,
                      delay: const Duration(milliseconds: 900),
                      child: _Button(
                        text: 'View My Work',
                        onPressed: onWorkTap ?? () {},
                        isPrimary: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ScrollReveal(
                      type: ScrollRevealType.zoomFade,
                      delay: const Duration(milliseconds: 1000),
                      child: _Button(
                        text: 'Contact Me',
                        onPressed: onContactTap ?? () {},
                        isPrimary: false,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScrollReveal(
                      type: ScrollRevealType.zoomFade,
                      delay: const Duration(milliseconds: 900),
                      child: _Button(
                        text: 'View My Work',
                        onPressed: onWorkTap ?? () {},
                        isPrimary: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ScrollReveal(
                      type: ScrollRevealType.zoomFade,
                      delay: const Duration(milliseconds: 1000),
                      child: _Button(
                        text: 'Contact Me',
                        onPressed: onContactTap ?? () {},
                        isPrimary: false,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _Button extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _Button({
    required this.text,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered
            ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
            : Matrix4.identity(),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              gradient: widget.isPrimary ? AppColors.primaryGradient : null,
              color: widget.isPrimary ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: widget.isPrimary
                  ? null
                  : Border.all(color: AppColors.primary, width: 2),
              boxShadow: [
                if (widget.isPrimary && isHovered)
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
              ],
            ),
            child: Text(
              widget.text,
              style: AppTypography.button.copyWith(
                color: widget.isPrimary || isHovered
                    ? Colors.white
                    : AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
