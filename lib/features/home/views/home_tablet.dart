import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import 'package:my_portfolio/features/home/widgets/professional_journey.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/connect_with_me.dart';
import '../widgets/featured_projects.dart';
import '../widgets/hero_section.dart';
import '../widgets/technical_expertise.dart';

class HomeTablet extends StatefulWidget {
  const HomeTablet({super.key});

  @override
  State<HomeTablet> createState() => _HomeTabletState();
}

class _HomeTabletState extends State<HomeTablet> {
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
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'M',
                  style: AppTypography.h3.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Makarios Fared',
              style: AppTypography.h4.copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: [
          _NavButton(
            title: 'Home',
            onTap: () => scrollToSection(context, _homeKey),
          ),
          _NavButton(
            title: 'Skills',
            onTap: () => scrollToSection(context, _skillsKey),
          ),
          _NavButton(
            title: 'Projects',
            onTap: () => scrollToSection(context, _projectsKey),
          ),
          _NavButton(
            title: 'Contact',
            onTap: () => scrollToSection(context, _contactKey),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HomeHero(
              key: _homeKey,
              onWorkTap: () => scrollToSection(context, _projectsKey),
              onContactTap: () => scrollToSection(context, _contactKey),
            ),
            const SizedBox(height: 80),
            TechnicalExpertise(key: _skillsKey),
            const SizedBox(height: 80),
            ProfessionalJourney(key: _journeyKey),
            const SizedBox(height: 80),
            FeaturedProjects(key: _projectsKey),
            const SizedBox(height: 80),
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
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      color: AppColors.surfaceDark.withValues(alpha: 0.5),
      child: Center(
        child: Text(
          '© 2026 Makarios Fared Naeem',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textLight),
      ),
    );
  }
}
