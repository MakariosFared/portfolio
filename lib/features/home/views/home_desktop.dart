import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/functions.dart';
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
          onHomeTap: () => scrollToSection(context,_homeKey),
          onSkillsTap: () => scrollToSection(context,_skillsKey),
          onJourneyTap: () => scrollToSection(context,_journeyKey),
          onProjectsTap: () => scrollToSection(context,_projectsKey),
          onContactTap: () => scrollToSection(context,_contactKey),
        ),
      ),
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HomeHero(
              key: _homeKey,
              onWorkTap: () => scrollToSection(context,_projectsKey),
              onContactTap: () => scrollToSection(context,_contactKey),
            ),
            const SizedBox(height: 100),
            TechnicalExpertise(key: _skillsKey),
            const SizedBox(height: 100),
            ProfessionalJourney(key: _journeyKey),
            const SizedBox(height: 100),
            FeaturedProjects(key: _projectsKey),
            const SizedBox(height: 100),
            ConnectWithMe(key: _contactKey),
            const SizedBox(height: 60),
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
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
    );
  }
}
