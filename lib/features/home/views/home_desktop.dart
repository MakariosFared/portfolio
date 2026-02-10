import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/widgets/professional_journey.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/desktop_app_bar.dart';
import '../widgets/hero_section.dart';

import '../widgets/technical_expertise.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: DesktopNavBar(),
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHero(),
            const SizedBox(height: 100),
            const TechnicalExpertise(),
            const SizedBox(height: 100),
            const ProfessionalJourney(),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Projects',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Grid of projects would go here
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    // color: AppColors.surface, // Placeholder
                    child: Center(
                      child: Text(
                        'Projects Grid Here',
                        style: AppTypography.h3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            // Footer
            Container(
              padding: const EdgeInsets.all(40),
              color: AppColors.surfaceDark,
              child: Center(
                child: Text(
                  '© 2026 Makarios Fared Naeem. All rights reserved.',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
