import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/responsive/size_config.dart';
import 'architecture_model.dart';
import 'architecture_modal.dart';
import 'project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = SizeConfig.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final project = widget.project;

    final surfaceColor = AppColors.getSurface(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: !isMobile && isHovered
            ? Matrix4.translationValues(0.0, -10.0, 0.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withValues(alpha: 0.6)
                : borderColor,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: !isMobile && isHovered ? 30 : 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🖼 Interactive Image with Fullscreen Preview
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogCtx) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: InteractiveViewer(
                              child: Image.asset(
                                project.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: IconButton(
                              onPressed: () => Navigator.pop(dialogCtx),
                              icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: isMobile ? 190 : 340,
                      width: double.infinity,
                      child: Image.asset(project.image, fit: BoxFit.cover),
                    ),
                    if (project.badge != null)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Text(
                            project.badge!,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              fontSize: isMobile ? 10.5 : 11.5,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.fullscreen_rounded, size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              'Zoom',
                              style: AppTypography.caption.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 📄 Content
              Padding(
                padding: EdgeInsets.all(isMobile ? 14 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 12 : 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: isMobile ? 12 : 16),

                    Text(
                      project.title,
                      style: AppTypography.h3.copyWith(
                        color: textPrimary,
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      project.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: textSecondary,
                        fontSize: isMobile ? 12 : 14,
                        height: 1.5,
                      ),
                      maxLines: isMobile ? 4 : 10,
                      overflow: TextOverflow.visible,
                    ),

                    const SizedBox(height: 20),

                    Divider(
                      color: borderColor,
                      thickness: 1,
                    ),

                    const SizedBox(height: 12),

                    /// Action Buttons
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (project.demoUrl != null)
                          ElevatedButton.icon(
                            onPressed: () => launchLink(project.demoUrl!),
                            icon: const Icon(
                              Icons.phone_iphone_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Live Demo',
                                  style: AppTypography.button.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 13 : 14,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shadowColor: AppColors.primary.withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 10 : 12,
                              ),
                            ),
                          ),
                        if (project.architectureId != null &&
                            projectArchitectures.containsKey(project.architectureId))
                          OutlinedButton.icon(
                            onPressed: () {
                              final arch = projectArchitectures[project.architectureId];
                              if (arch != null) {
                                showArchitectureDialog(context, arch);
                              }
                            },
                            icon: const Icon(
                              Icons.account_tree_outlined,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            label: Text(
                              'Architecture',
                              style: AppTypography.button.copyWith(
                                color: AppColors.primary,
                                fontSize: isMobile ? 13 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.primary.withValues(alpha: 0.6),
                                width: 1.2,
                              ),
                              backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 10 : 12,
                              ),
                            ),
                          ),
                        if (project.githubUrl != null)
                          ElevatedButton.icon(
                            onPressed: () => launchLink(project.githubUrl!),
                            icon: const FaIcon(
                              FontAwesomeIcons.github,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text(
                              'GitHub',
                              style: AppTypography.button.copyWith(
                                color: Colors.white,
                                fontSize: isMobile ? 13 : 14,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.25),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              side: BorderSide(
                                color: AppColors.primary.withValues(alpha: 0.4),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 10 : 12,
                              ),
                            ),
                          ),
                        if (project.liveUrl != null)
                          OutlinedButton.icon(
                            onPressed: () => launchLink(project.liveUrl!),
                            icon: Icon(
                              project.liveUrl!.contains('drive.google') ||
                                      project.liveUrl!.contains('youtube') ||
                                      project.liveUrl!.contains('video')
                                  ? Icons.play_circle_outline_rounded
                                  : Icons.open_in_new,
                              size: 16,
                              color: AppColors.accent,
                            ),
                            label: Text(
                              project.liveUrl!.contains('drive.google') ||
                                      project.liveUrl!.contains('youtube') ||
                                      project.liveUrl!.contains('video')
                                  ? 'Video Preview'
                                  : 'Preview',
                              style: AppTypography.button.copyWith(
                                color: AppColors.accent,
                                fontSize: isMobile ? 13 : 14,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.accent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 10 : 12,
                              ),
                            ),
                          ),
                      ],
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
}
