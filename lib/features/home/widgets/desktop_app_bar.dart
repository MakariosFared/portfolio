import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive/size_config.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class DesktopNavBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onJourneyTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const DesktopNavBar({
    super.key,
    required this.onHomeTap,
    required this.onSkillsTap,
    required this.onJourneyTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withValues(alpha: 0.5),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Area
          InkWell(
            onTap: onHomeTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'M',
                      style: AppTypography.h3.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Makarios Fared',
                  style: AppTypography.h4.copyWith(color: AppColors.textOnPrimary),
                ),
              ],
            ),
          ),

          // Navigation Links
          Row(
            children: [
              _NavBarItem(title: 'Home', onTap: onHomeTap),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Skills', onTap: onSkillsTap),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Experience', onTap: onJourneyTap),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Projects', onTap: onProjectsTap),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Contact', onTap: onContactTap),
              const SizedBox(width: 40),
              _ResumeButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: AppTypography.bodyMedium.copyWith(
                color: isHovered
                    ? AppColors.primaryLight
                    : AppColors.textOnPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isHovered ? 20 : 0,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
      child: Text('Resume', style: AppTypography.button),
    );
  }
}
