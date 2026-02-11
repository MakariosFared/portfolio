import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';

class HomeHero extends StatelessWidget {
  final VoidCallback? onWorkTap;
  final VoidCallback? onContactTap;

  const HomeHero({super.key, this.onWorkTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double horizontalPadding = isMobile ? 20 : 40;
        final double verticalPadding = isMobile ? 60 : 120;
        final double titleFontSize = isMobile ? 36 : 64;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScrollReveal(
                type: ScrollRevealType.fadeSlideUp,
                duration: const Duration(milliseconds: 800),
                child: Text(
                  'Crafting Mobile Experiences',
                  textAlign: TextAlign.center,
                  style: AppTypography.h1.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: titleFontSize,
                    letterSpacing: -1.5,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ScrollReveal(
                type: ScrollRevealType.fadeSlideUp,
                delay: const Duration(milliseconds: 300),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'With ',
                    style: AppTypography.h1.copyWith(
                      color: AppColors.textOnPrimary,
                      fontSize: titleFontSize,
                      letterSpacing: -1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Flutter',
                        style: AppTypography.h1.copyWith(
                          color: AppColors.primary,
                          fontSize: titleFontSize,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: 'Dart',
                        style: AppTypography.h1.copyWith(
                          color: AppColors.secondary,
                          fontSize: titleFontSize,
                          letterSpacing: -1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ScrollReveal(
                type: ScrollRevealType.fadeSlideUp,
                delay: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(120),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
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
                      const SizedBox(width: 12),
                      Text(
                        'Available for new projects',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ScrollReveal(
                type: ScrollRevealType.fadeSlideUp,
                delay: const Duration(milliseconds: 800),
                child: Text(
                  'Expert in building high-performance, beautiful mobile and\n web applications using Flutter framework and modern tech stack.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: isMobile ? 16 : 18,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              isMobile
                  ? Column(
                      children: [
                        ScrollReveal(
                          type: ScrollRevealType.zoomFade,
                          delay: const Duration(milliseconds: 1000),
                          child: _Button(
                            text: 'View My Work',
                            onPressed: onWorkTap ?? () {},
                            isPrimary: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ScrollReveal(
                          type: ScrollRevealType.zoomFade,
                          delay: const Duration(milliseconds: 1100),
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
                          delay: const Duration(milliseconds: 1000),
                          child: _Button(
                            text: 'View My Work',
                            onPressed: onWorkTap ?? () {},
                            isPrimary: true,
                          ),
                        ),
                        const SizedBox(width: 25),
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
      },
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
            ? (Matrix4.identity()..scale(1.05))
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
