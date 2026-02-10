import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import 'package:animate_do/animate_do.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double horizontalPadding = isMobile ? 20 : 40;
        final double verticalPadding = isMobile ? 40 : 80;
        final double titleFontSize = isMobile ? 32 : 48;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/5809368.jpg'),
              fit: BoxFit.cover,
              opacity: 0.1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Text(
                  'Crafting Mobile Experiences',
                  textAlign: TextAlign.center,
                  style: AppTypography.h1.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: titleFontSize,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'With ',
                    style: AppTypography.h1.copyWith(
                      color: AppColors.textOnPrimary,
                      fontSize: titleFontSize,
                      letterSpacing: -1.0,
                    ),
                    children: [
                      TextSpan(
                        text: 'Flutter',
                        style: AppTypography.h1.copyWith(
                          color: AppColors.primary,
                          fontSize: titleFontSize,
                          letterSpacing: -1.0,
                        ),
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: 'Dart',
                        style: AppTypography.h1.copyWith(
                          color: AppColors.secondary,
                          fontSize: titleFontSize,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDark,
                    borderRadius: BorderRadius.circular(120),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '•',
                        style: AppTypography.h2.copyWith(
                          color: AppColors.primary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Expert in Cross-Platform App Development',
                        textAlign: TextAlign.center,
                        style: AppTypography.h2.copyWith(
                          color: AppColors.textOnPrimary,
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Text(
                  'I build high-performance mobile applications with beautiful\n UI and seamless user experience using Flutter framework.',
                  textAlign: TextAlign.center,
                  style: AppTypography.h1.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: isMobile ? 18 : 20,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              isMobile
                  ? Column(
                      children: [
                        _Button(
                          text: 'View My Work',
                          onPressed: () {},
                          isPrimary: true,
                        ),
                        const SizedBox(height: 16),
                        _Button(
                          text: 'Contact Me',
                          onPressed: () {},
                          isPrimary: false,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          child: _Button(
                            text: 'View My Work',
                            onPressed: () {},
                            isPrimary: true,
                          ),
                        ),
                        const SizedBox(width: 20),
                        FadeInRight(
                          delay: const Duration(milliseconds: 600),
                          child: _Button(
                            text: 'Contact Me',
                            onPressed: () {},
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

class _Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _Button({
    required this.text,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final style = isPrimary
        ? ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )
        : OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );

    return isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: style,
            child: Text(
              text,
              style: AppTypography.button.copyWith(fontSize: 16),
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: Text(
              text,
              style: AppTypography.button.copyWith(
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          );
  }
}
