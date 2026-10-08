import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import 'package:my_portfolio/core/widgets/scroll_reveal.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/responsive/size_config.dart';

class ConnectWithMe extends StatefulWidget {
  const ConnectWithMe({super.key});

  @override
  State<ConnectWithMe> createState() => _ConnectWithMeState();
}

class _ConnectWithMeState extends State<ConnectWithMe> {
  // ================== EDIT YOUR DATA HERE ==================
  final String email = "makarios.fared@gmail.com";
  final String whatsappNumber = "201211544768";
  final String linkedInUrl =
      "https://www.linkedin.com/in/makarios-fared-20aa0a250/";
  final String githubUrl = "https://github.com/MakariosFared";
  // =========================================================

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isMobile = SizeConfig.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 30,
        vertical: isMobile ? 12 : 20,
      ),
      color: AppColors.primaryDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: Text(
              "Let's Connect",
              style: AppTypography.h2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "Interested in working together or have a project in mind? Feel free to reach out.",
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 30),

          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 300),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton.icon(
                  onPressed: downloadCV,
                  icon: const Icon(Icons.download_rounded, size: 20),
                  label: Text('Download CV', style: AppTypography.button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundDark,
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
                        backgroundColor: AppColors.surfaceDark,
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
                  icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.white),
                  label: Text(
                    'Copy Email',
                    style: AppTypography.button.copyWith(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
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
          const SizedBox(height: 30),

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
              color: AppColors.textOnPrimary,
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
                        : AppColors.primary.withValues(alpha: 0.4),
                  ),
            color: isMobile
                ? AppColors.primary
                : isHovered
                ? AppColors.primary
                : Colors.transparent,
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              color: Colors.white,
              size: isMobile ? 24 : 28,
            ),
          ),
        ),
      ),
    );
  }
}
