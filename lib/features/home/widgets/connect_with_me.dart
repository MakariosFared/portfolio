import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/utils/responsive/size_config.dart';

class ConnectWithMe extends StatelessWidget {
  const ConnectWithMe({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isMobile = SizeConfig.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      color: AppColors.surfaceDark.withValues(alpha: 0.3),
      child: Column(
        children: [
          SectionHeader(title: 'Get In Touch'),
          const SizedBox(height: 15),
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            delay: const Duration(milliseconds: 200),
            child: Text(
              "Let's build something amazing together.",
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    ScrollReveal(
                      type: ScrollRevealType.fadeSlideUp,
                      delay: const Duration(milliseconds: 300),
                      child: _buildContactInfo(),
                    ),
                    const SizedBox(height: 40),
                    ScrollReveal(
                      type: ScrollRevealType.zoomFade,
                      delay: const Duration(milliseconds: 400),
                      child: _buildSocialLinks(),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ScrollReveal(
                        type: ScrollRevealType.fadeSlideUp,
                        delay: const Duration(milliseconds: 300),
                        child: _buildContactInfo(),
                      ),
                    ),
                    Expanded(
                      child: ScrollReveal(
                        type: ScrollRevealType.zoomFade,
                        delay: const Duration(milliseconds: 400),
                        child: _buildSocialLinks(),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _ContactItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'makarios.fared7@gmail.com',
          onTap: () => launchUrl(Uri.parse('mailto:makarios.fared7@gmail.com')),
        ),
        const SizedBox(height: 20),
        _ContactItem(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: 'Cairo, Egypt',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon:
              'assets/icons/linkedin.png', // Placeholder, use icon if png not available
          label: 'LinkedIn',
          onTap: () {},
        ),
        const SizedBox(width: 25),
        _SocialIcon(
          icon: 'assets/icons/github.png',
          label: 'GitHub',
          onTap: () {},
        ),
        const SizedBox(width: 25),
        _SocialIcon(
          icon: 'assets/icons/twitter.png',
          label: 'Twitter',
          onTap: () {},
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryLight, size: 24),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.primary : AppColors.surfaceDark,
            shape: BoxShape.circle,
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Icon(
            _getIconForLabel(widget.label),
            color: isHovered ? Colors.white : AppColors.textLight,
            size: 28,
          ),
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label.toLowerCase()) {
      case 'linkedin':
        return Icons.link;
      case 'github':
        return Icons.code;
      case 'twitter':
        return Icons.alternate_email;
      default:
        return Icons.share;
    }
  }
}
