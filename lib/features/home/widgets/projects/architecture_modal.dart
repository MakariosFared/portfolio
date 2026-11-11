import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/responsive/size_config.dart';
import 'architecture_model.dart';

void showArchitectureDialog(BuildContext context, ProjectArchitecture architecture) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Architecture Details',
    barrierColor: Colors.black.withValues(alpha: 0.75),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (dialogContext, anim1, anim2) {
      return Center(
        child: ArchitectureModal(architecture: architecture),
      );
    },
    transitionBuilder: (dialogContext, anim1, anim2, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      );
    },
  );
}

class ArchitectureModal extends StatelessWidget {
  final ProjectArchitecture architecture;

  const ArchitectureModal({super.key, required this.architecture});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isMobile = SizeConfig.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor = AppColors.getSurface(context);
    final bgColor = AppColors.getBackground(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

    final double modalMaxWidth = isMobile ? (context.screenWidth * 0.94) : 860;
    final double modalMaxHeight = context.screenHeight * 0.88;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: modalMaxWidth,
        constraints: BoxConstraints(maxHeight: modalMaxHeight),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? AppColors.primary.withValues(alpha: 0.4) : borderColor,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.15),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 18 : 28,
                  vertical: isMobile ? 16 : 22,
                ),
                decoration: BoxDecoration(
                  color: bgColor.withValues(alpha: 0.85),
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.account_tree_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'ARCHITECTURE DEEP-DIVE',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.primaryLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.5,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            architecture.title,
                            style: AppTypography.h3.copyWith(
                              color: textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 18 : 22,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            architecture.subtitle,
                            style: AppTypography.bodySmall.copyWith(
                              color: textSecondary,
                              fontSize: isMobile ? 12 : 13.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      color: textSecondary,
                      tooltip: 'Close',
                      style: IconButton.styleFrom(
                        backgroundColor: surfaceColor,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Body
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 18 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Architectural Pattern Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.layers_rounded,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Architectural Pattern',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              architecture.pattern,
                              style: AppTypography.bodyLarge.copyWith(
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: isMobile ? 14 : 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              architecture.overview,
                              style: AppTypography.bodyMedium.copyWith(
                                color: textSecondary,
                                height: 1.55,
                                fontSize: isMobile ? 13 : 14.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),

                      // Section 1: Data Flow Pipeline
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.linear_scale_rounded,
                              color: AppColors.accent,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Data Flow & Execution Pipeline',
                              style: AppTypography.h4.copyWith(
                                color: textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 16 : 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Pipeline Steps
                      ...architecture.pipeline.map(
                        (step) => _buildPipelineStepItem(
                          step: step,
                          isMobile: isMobile,
                          bgColor: bgColor,
                          borderColor: borderColor,
                          textPrimary: textPrimary,
                          textSecondary: textSecondary,
                          isLast: step == architecture.pipeline.last,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Section 2: Key Engineering Challenges & Solutions
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: AppColors.warning,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Engineering Challenges & Solved Edge-Cases',
                              style: AppTypography.h4.copyWith(
                                color: textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 16 : 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      ...architecture.challenges.map(
                        (item) => _buildChallengeCard(
                          item: item,
                          isMobile: isMobile,
                          isDark: isDark,
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          textPrimary: textPrimary,
                          textSecondary: textSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Section 3: Architecture Tech Stack
                      Text(
                        'Core Stack & Protocols',
                        style: AppTypography.bodyMedium.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: architecture.techStack.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // Modal Footer
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 18 : 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: bgColor.withValues(alpha: 0.8),
                  border: Border(
                    top: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Got it!'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPipelineStepItem({
    required ArchitecturePipelineStep step,
    required bool isMobile,
    required Color bgColor,
    required Color borderColor,
    required Color textPrimary,
    required Color textSecondary,
    required bool isLast,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${step.stepNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        step.title,
                        style: AppTypography.bodyMedium.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 13.5 : 15,
                        ),
                      ),
                    ),
                    if (step.badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          step.badge!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  step.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: textSecondary,
                    height: 1.5,
                    fontSize: isMobile ? 12.5 : 13.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard({
    required ArchitectureChallenge item,
    required bool isMobile,
    required bool isDark,
    required Color surfaceColor,
    required Color borderColor,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(item.icon, color: AppColors.primaryLight, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 13.5 : 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Challenge block
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: isDark ? 0.12 : 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.red.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Challenge: ',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 12 : 13,
                      ),
                      children: [
                        TextSpan(
                          text: item.challenge,
                          style: AppTypography.bodySmall.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.normal,
                            fontSize: isMobile ? 12 : 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Solution block
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: isDark ? 0.12 : 0.07),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_outline_rounded, color: AppColors.success, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Architectural Solution: ',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 12 : 13,
                      ),
                      children: [
                        TextSpan(
                          text: item.solution,
                          style: AppTypography.bodySmall.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.normal,
                            fontSize: isMobile ? 12 : 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
