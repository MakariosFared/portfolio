import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class JourneyItem {
  final String role;
  final String company;
  final String period;
  final String description;
  final IconData icon;

  JourneyItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.icon,
  });
}

class ProfessionalJourney extends StatelessWidget {
  const ProfessionalJourney({super.key});

  @override
  Widget build(BuildContext context) {
    final journeyItems = <JourneyItem>[
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Flieger Tech',
        period: 'Present',
        description:
            'Working on production-grade Flutter applications, collaborating with backend and UI/UX teams, and delivering scalable, maintainable mobile solutions.',
        icon: Icons.work_rounded,
      ),
      JourneyItem(
        role: 'Flutter Developer',
        company: 'Shrka',
        period: 'Previous Role',
        description:
            'Contributed to building and maintaining Flutter applications, integrating RESTful APIs, and improving UI performance and responsiveness.',
        icon: Icons.business_rounded,
      ),
      JourneyItem(
        role: 'Freelance Flutter Developer',
        company: 'Self-Employed',
        period: 'Freelance',
        description:
            'Delivered multiple Flutter projects for different clients, including business apps, dashboards, and service-based mobile solutions.',
        icon: Icons.handyman_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double horizontalPadding = isMobile ? 20 : 40;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 800),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 35,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'Professional Journey',
                      style: AppTypography.h2.copyWith(
                        color: AppColors.textLight,
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              ...journeyItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return FadeInUp(
                  delay: Duration(milliseconds: 150 * index),
                  duration: const Duration(milliseconds: 600),
                  child: _JourneyCard(item: item),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _JourneyCard extends StatelessWidget {
  final JourneyItem item;

  const _JourneyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
              ),
              Container(
                width: 2,
                height: 90,
                color: AppColors.border.withValues(alpha: 0.2),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Content Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.role,
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.company,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.period,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.description,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
