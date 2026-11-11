import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/responsive/size_config.dart';
import '../../../../core/widgets/quick_meeting_modal.dart';
import '../../../../core/widgets/scroll_reveal.dart';

class ConnectWithMe extends StatefulWidget {
  const ConnectWithMe({super.key});

  @override
  State<ConnectWithMe> createState() => _ConnectWithMeState();
}

class _ConnectWithMeState extends State<ConnectWithMe> {
  final String email = AppConfig.developerEmail;
  final String whatsappNumber = AppConfig.developerWhatsApp;
  final String linkedInUrl = AppConfig.developerLinkedIn;
  final String githubUrl = AppConfig.developerGithub;

  void _openContactDialog(BuildContext context) {
    final nameController = TextEditingController();
    final contactController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = AppColors.getSurface(context);
    final bgColor = AppColors.getBackground(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

    showDialog(
      context: context,
      builder: (dialogCtx) => Dialog(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark ? AppColors.primary.withValues(alpha: 0.35) : borderColor,
            width: 1.5,
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Send a Message',
                              style: AppTypography.h3.copyWith(
                                color: textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(dialogCtx),
                          icon: Icon(Icons.close_rounded, color: textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Have an opportunity or inquiry? Send me a quick note directly.',
                      style: AppTypography.bodySmall.copyWith(
                        color: textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name Field
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(color: textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        labelStyle: TextStyle(color: textSecondary.withValues(alpha: 0.8)),
                        prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.primary, size: 20),
                        filled: true,
                        fillColor: bgColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty) ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 14),

                    // Contact Info
                    TextFormField(
                      controller: contactController,
                      style: TextStyle(color: textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Your Email / Phone',
                        labelStyle: TextStyle(color: textSecondary.withValues(alpha: 0.8)),
                        prefixIcon: const Icon(Icons.alternate_email_rounded, color: AppColors.primary, size: 20),
                        filled: true,
                        fillColor: bgColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty) ? 'Please enter your contact info' : null,
                    ),
                    const SizedBox(height: 14),

                    // Message Field
                    TextFormField(
                      controller: messageController,
                      maxLines: 4,
                      style: TextStyle(color: textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Message / Project Details',
                        labelStyle: TextStyle(color: textSecondary.withValues(alpha: 0.8)),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: bgColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty) ? 'Please enter a message' : null,
                    ),
                    const SizedBox(height: 22),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                final name = Uri.encodeComponent(nameController.text.trim());
                                final contact = Uri.encodeComponent(contactController.text.trim());
                                final message = Uri.encodeComponent(messageController.text.trim());
                                final subject = Uri.encodeComponent('Portfolio Contact from $name');
                                final body = Uri.encodeComponent(
                                    'Sender: $name\nContact: $contact\n\nMessage:\n$message');
                                launchLink('mailto:$email?subject=$subject&body=$body');
                                Navigator.pop(dialogCtx);
                              }
                            },
                            icon: const Icon(Icons.email_outlined, size: 18),
                            label: const Text('Send via Email'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                final name = nameController.text.trim();
                                final message = messageController.text.trim();
                                final fullText = Uri.encodeComponent(
                                    'Hello Makarios, my name is $name.\n\n$message');
                                launchLink('https://wa.me/$whatsappNumber?text=$fullText');
                                Navigator.pop(dialogCtx);
                              }
                            },
                            icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18),
                            label: const Text('Via WhatsApp'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF25D366),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isMobile = SizeConfig.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor = AppColors.getSurface(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 30,
        vertical: isMobile ? 40 : 60,
      ),
      decoration: BoxDecoration(
        color: surfaceColor.withValues(alpha: isDark ? 0.4 : 0.8),
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: Text(
              "Let's Connect",
              style: AppTypography.h2.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 26 : 34,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "Interested in working together or have an exciting project in mind? Feel free to reach out via message, WhatsApp, or explore my resume.",
                style: AppTypography.bodyLarge.copyWith(
                  color: textSecondary,
                  fontSize: isMobile ? 14 : 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 32),

          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                // 📅 Book a 15-Min Intro Call (Standout CTA)
                ElevatedButton.icon(
                  onPressed: () => showQuickMeetingDialog(context),
                  icon: const Icon(Icons.calendar_month_rounded, size: 20),
                  label: Text('Book a 15-Min Call', style: AppTypography.button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: const Color(0xFF6366F1).withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),

                // Quick Message Form CTA
                ElevatedButton.icon(
                  onPressed: () => _openContactDialog(context),
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: Text('Send a Message', style: AppTypography.button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),

                // Direct WhatsApp Chat CTA
                ElevatedButton.icon(
                  onPressed: () => launchLink("https://wa.me/$whatsappNumber"),
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: Text('Chat on WhatsApp', style: AppTypography.button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),

                // Download CV
                OutlinedButton.icon(
                  onPressed: downloadCV,
                  icon: Icon(
                    Icons.download_rounded,
                    size: 20,
                    color: isDark ? Colors.white : textPrimary,
                  ),
                  label: Text(
                    'Download CV',
                    style: AppTypography.button.copyWith(
                      color: isDark ? Colors.white : textPrimary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),

                // Copy Email with Toast
                OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: email));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Email copied to clipboard! ($email)',
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: surfaceColor,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: AppColors.primary.withValues(alpha: 0.5),
                          ),
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: isDark ? Colors.white : textPrimary,
                  ),
                  label: Text(
                    'Copy Email',
                    style: AppTypography.button.copyWith(
                      color: isDark ? Colors.white : textPrimary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: borderColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          /// SOCIAL ICONS ROW
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 25,
              runSpacing: 25,
              children: [
                _SocialButton(
                  icon: FontAwesomeIcons.envelope,
                  onTap: () => launchLink("mailto:$email"),
                ),
                _SocialButton(
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: () => launchLink("https://wa.me/$whatsappNumber"),
                ),
                _SocialButton(
                  icon: FontAwesomeIcons.linkedin,
                  onTap: () => launchLink(linkedInUrl),
                ),
                _SocialButton(
                  icon: FontAwesomeIcons.github,
                  onTap: () => launchLink(githubUrl),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// FOOTER TEXT
          Text(
            "© ${DateTime.now().year} Makarios Fared. All rights reserved.",
            style: AppTypography.bodySmall.copyWith(
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final FaIconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = SizeConfig.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isMobile ? 55 : 65,
          height: isMobile ? 55 : 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isMobile
                ? Border.all(color: AppColors.primary)
                : Border.all(
                    color: isHovered
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.primary.withValues(alpha: 0.4)
                            : const Color(0xFFCBD5E1)),
                  ),
            color: isMobile
                ? AppColors.primary
                : isHovered
                    ? AppColors.primary
                    : (isDark ? Colors.transparent : Colors.white),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              color: isHovered || isMobile
                  ? Colors.white
                  : (isDark ? Colors.white : AppColors.primary),
              size: isMobile ? 24 : 28,
            ),
          ),
        ),
      ),
    );
  }
}
