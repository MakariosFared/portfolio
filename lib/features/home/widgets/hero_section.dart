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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hi, I'm ",
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  Text(
                    "Makarios Fared",
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 15 : 17,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text("👋", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),

          // Main Headline
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Crafting High-Performance\nMobile Experiences',
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
          const SizedBox(height: 8),

          // Framework Specialization
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'With ',
                style: AppTypography.h2.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 18 : 26,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Flutter',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.primary,
                      fontSize: isMobile ? 18 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' & '),
                  TextSpan(
                    text: 'Dart',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.secondaryLight,
                      fontSize: isMobile ? 18 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Available Status Badge
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    'Available for new projects',
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
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                'Mobile Application Developer specializing in robust, scalable cross-platform applications with clean architecture and modern state management.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 14 : 16,
                  height: 1.5,
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
