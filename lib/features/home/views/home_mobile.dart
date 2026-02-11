import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/widgets/professional_journey.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/hero_section.dart';
import '../widgets/technical_expertise.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      drawer: Drawer(
        backgroundColor: AppColors.surfaceDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Home',
                style: TextStyle(color: AppColors.textLight),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Projects',
                style: TextStyle(color: AppColors.textLight),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Contact',
                style: TextStyle(color: AppColors.textLight),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'M',
                  style: AppTypography.h4.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('Makarios Fared', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: AppColors.textLight),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHero(),
            const SizedBox(height: 60),
            const TechnicalExpertise(),
            const SizedBox(height: 60),
            ProfessionalJourney(),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Projects',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Mobile Projects Grid',
                        style: AppTypography.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            // Footer
            Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.surfaceDark,
              child: Center(
                child: Text(
                  '© 2026 Makarios Fared Naeem',
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
