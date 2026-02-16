import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/widgets/scroll_reveal.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final String email = "your_email@example.com";
  final String whatsappNumber = "201000000000";
  final String linkedInUrl = "https://linkedin.com/in/your-profile";
  final String githubUrl = "https://github.com/your-username";
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
                  onTap: () => _launch("mailto:$email"),
                ),
                _SocialButton(
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: () => _launch("https://wa.me/$whatsappNumber"),
                ),
                _SocialButton(
                  icon: FontAwesomeIcons.linkedin,
                  onTap: () => _launch(linkedInUrl),
                ),
                _SocialButton(
                  icon: FontAwesomeIcons.github,
                  onTap: () => _launch(githubUrl),
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

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
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
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: isMobile ? 24 : 28,
          ),
        ),
      ),
    );
  }
}
