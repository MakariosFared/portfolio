import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/widgets/professional_journey.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/connect_with_me.dart';
import '../widgets/desktop_app_bar.dart';
import '../widgets/featured_projects.dart';
import '../widgets/hero_section.dart';

import '../widgets/technical_expertise.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _journeyKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: DesktopNavBar(
          onHomeTap: () => _scrollToSection(_homeKey),
          onSkillsTap: () => _scrollToSection(_skillsKey),
          onJourneyTap: () => _scrollToSection(_journeyKey),
          onProjectsTap: () => _scrollToSection(_projectsKey),
          onContactTap: () => _scrollToSection(_contactKey),
        ),
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HomeHero(
              key: _homeKey,
              onWorkTap: () => _scrollToSection(_projectsKey),
              onContactTap: () => _scrollToSection(_contactKey),
            ),
            const SizedBox(height: 100),
            FadeInUp(key: _skillsKey, child: const TechnicalExpertise()),
            const SizedBox(height: 100),
            FadeInUp(key: _journeyKey, child: const ProfessionalJourney()),
            const SizedBox(height: 100),
            FeaturedProjects(key: _projectsKey),
            const SizedBox(height: 100),
            ConnectWithMe(key: _contactKey),
            const SizedBox(height: 60),
            // Footer
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              width: double.infinity,
              color: AppColors.surfaceDark.withValues(alpha: 0.5),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      '© 2026 Makarios Fared Naeem. All rights reserved.',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Built with Flutter for Web',
                      style: AppTypography.overline.copyWith(
                        color: AppColors.primaryLight.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
