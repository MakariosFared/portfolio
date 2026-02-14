import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import 'package:my_portfolio/features/home/widgets/professional_journey.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/connect_with_me.dart';
import '../widgets/featured_projects.dart';
import '../widgets/hero_section.dart';
import '../widgets/technical_expertise.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
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
      drawer: Drawer(
        backgroundColor: AppColors.surfaceDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            _DrawerItem(title: 'Home', onTap: () => scrollToSection(context,_homeKey)),
            _DrawerItem(
              title: 'Skills',
              onTap: () => scrollToSection(context,_skillsKey),
            ),
            _DrawerItem(
              title: 'Experience',
              onTap: () => scrollToSection(context,_journeyKey),
            ),
            _DrawerItem(
              title: 'Projects',
              onTap: () => scrollToSection(context,_projectsKey),
            ),
            _DrawerItem(
              title: 'Contact',
              onTap: () => scrollToSection(context,_contactKey),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
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
            Text(
              'Makarios',
              style: AppTypography.h4.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HomeHero(
              key: _homeKey,
              onWorkTap: () => scrollToSection(context,_projectsKey),
              onContactTap: () => scrollToSection(context,_contactKey),
            ),
            const SizedBox(height: 60),
            TechnicalExpertise(key: _skillsKey),
            const SizedBox(height: 60),
            ProfessionalJourney(key: _journeyKey),
            const SizedBox(height: 60),
            FeaturedProjects(key: _projectsKey),
            const SizedBox(height: 60),
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
      padding: const EdgeInsets.all(20),
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

class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: AppTypography.h4.copyWith(color: AppColors.textLight),
      ),
    );
  }
}
