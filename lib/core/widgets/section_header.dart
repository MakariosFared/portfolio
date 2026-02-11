import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'scroll_reveal.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isMobile;

  const SectionHeader({super.key, required this.title, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      type: ScrollRevealType.fadeSlideRight,
      child: Row(
        children: [
          Container(
            width: 5,
            height: isMobile ? 28 : 35,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: AppTypography.h2.copyWith(
              color: AppColors.textLight,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
