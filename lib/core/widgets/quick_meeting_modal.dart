import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_config.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../utils/functions.dart';
import '../utils/responsive/size_config.dart';

void showQuickMeetingDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Schedule a Call',
    barrierColor: Colors.black.withValues(alpha: 0.75),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (dialogContext, anim1, anim2) {
      return const Center(
        child: QuickMeetingModal(),
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

class QuickMeetingModal extends StatelessWidget {
  const QuickMeetingModal({super.key});

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

    final double modalMaxWidth = isMobile ? (context.screenWidth * 0.94) : 560;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: modalMaxWidth,
        constraints: BoxConstraints(maxHeight: context.screenHeight * 0.88),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? AppColors.primary.withValues(alpha: 0.4) : borderColor,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: isDark ? 0.3 : 0.15),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Banner & Header
                Container(
                  padding: EdgeInsets.all(isMobile ? 20 : 26),
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'QUICK 15-MINUTE INTRO CHAT',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.5,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Book a 15-Min Meeting',
                              style: AppTypography.h3.copyWith(
                                color: textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 18 : 22,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Pick the quickest way to connect for an introduction or technical interview.',
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

                // Channels List
                Padding(
                  padding: EdgeInsets.all(isMobile ? 18 : 26),
                  child: Column(
                    children: [
                      // Channel 1: Calendly / Cal.com (Recommended)
                      _MeetingOptionCard(
                        title: 'Book on Calendar',
                        subtitle: 'Select an available date & time slot directly on Calendly.',
                        badge: 'Recommended',
                        badgeColor: AppColors.primary,
                        iconWidget: const Icon(
                          Icons.event_available_rounded,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        buttonLabel: 'Open Calendar',
                        onTap: () {
                          launchLink(AppConfig.developerMeetingUrl);
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(height: 14),

                      // Channel 2: WhatsApp Quick Chat
                      _MeetingOptionCard(
                        title: 'Fast WhatsApp Chat',
                        subtitle: 'Send an instant message proposing a meeting time.',
                        badge: 'Fast Response',
                        badgeColor: const Color(0xFF25D366),
                        iconWidget: const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Color(0xFF25D366),
                          size: 22,
                        ),
                        buttonLabel: 'Chat via WhatsApp',
                        onTap: () {
                          const message =
                              'Hello Makarios, I saw your portfolio and would like to schedule a 15-minute intro chat about an opportunity. Are you available this week?';
                          launchLink(
                            'https://wa.me/${AppConfig.developerWhatsApp}?text=${Uri.encodeComponent(message)}',
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(height: 14),

                      // Channel 3: Email Slot Proposal
                      _MeetingOptionCard(
                        title: 'Propose Slots via Email',
                        subtitle: 'Send meeting details and proposed times directly to my inbox.',
                        badge: 'Direct Inbox',
                        badgeColor: AppColors.accent,
                        iconWidget: const Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.accent,
                          size: 24,
                        ),
                        buttonLabel: 'Send Email',
                        onTap: () {
                          const subject = 'Request for 15-Minute Intro Call';
                          const body =
                              'Hi Makarios,\n\nI reviewed your portfolio and would like to arrange a 15-minute introductory call regarding an opportunity.\n\nProposed times/dates:\n- \n- \n\nBest regards,';
                          launchLink(
                            'mailto:${AppConfig.developerEmail}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MeetingOptionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String badge;
  final Color badgeColor;
  final Widget iconWidget;
  final String buttonLabel;
  final VoidCallback onTap;

  const _MeetingOptionCard({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
    required this.iconWidget,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  State<_MeetingOptionCard> createState() => _MeetingOptionCardState();
}

class _MeetingOptionCardState extends State<_MeetingOptionCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = AppColors.getBackground(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? widget.badgeColor.withValues(alpha: 0.8)
                : (isDark ? borderColor : borderColor.withValues(alpha: 0.6)),
            width: isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: widget.badgeColor.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: widget.iconWidget,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.title,
                          style: AppTypography.bodyMedium.copyWith(
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: widget.badgeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.badge,
                          style: AppTypography.caption.copyWith(
                            color: widget.badgeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: textSecondary,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: widget.onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.badgeColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.buttonLabel,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
