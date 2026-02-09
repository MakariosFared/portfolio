import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive/size_config.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: AppColors.backgroundDark.withValues(
        alpha: 0.9,
      ), // Glassmorphism base
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Area
          Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Makarios Fared',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Navigation Links
          Row(
            children: [
              _NavBarItem(title: 'Home', onTap: () {}),
              const SizedBox(width: 30),
              _NavBarItem(title: 'About', onTap: () {}),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Skills', onTap: () {}),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Projects', onTap: () {}),
              const SizedBox(width: 30),
              _NavBarItem(title: 'Contact', onTap: () {}),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Resume'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
