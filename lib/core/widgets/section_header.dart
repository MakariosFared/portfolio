import 'package:flutter/material.dart';
import '../../core/utils/responsive/size_config.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'scroll_reveal.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final bool isMobile = SizeConfig.isMobile;

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
              color: AppColors.textOnPrimary,
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
