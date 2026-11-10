import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/responsive/size_config.dart';

class FeGoFlagshipCard extends StatefulWidget {
  const FeGoFlagshipCard({super.key});

  @override
  State<FeGoFlagshipCard> createState() => _FeGoFlagshipCardState();
}

class _FeGoFlagshipCardState extends State<FeGoFlagshipCard> {
  bool isHovered = false;

  void _openImagePreview(BuildContext context, String imageUrl, String title) {
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
                child: Image.asset(imageUrl, fit: BoxFit.contain),
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
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = SizeConfig.isMobile;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor = AppColors.getSurface(context);
    final bgColor = AppColors.getBackground(context);
    final borderColor = AppColors.getBorder(context);
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryLight
                : (isDark ? AppColors.primary.withValues(alpha: 0.35) : borderColor),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: isHovered ? 35 : 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 18 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Badge Header
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'FLAGSHIP CASE STUDY',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'TWO-SIDED PLATFORM (PASSENGER + DRIVER)',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Platform Title
                Text(
                  'FeGo – Real-Time Ride-Hailing Platform',
                  style: AppTypography.h2.copyWith(
                    color: textPrimary,
                    fontSize: isMobile ? 22 : 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Platform Summary
                Text(
                  'Production-grade transportation ecosystem built entirely from scratch in Flutter. Connects riders and drivers in real time with bidirectional WebSocket events, live geospatial map tracking, and foreground/background push notifications.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: textSecondary,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 24),

                // Dual Mockups Display
                isMobile
                    ? Column(
                        children: [
                          _buildMockupCard(
                            title: 'FeGo Passenger App',
                            badge: 'Rider Client',
                            image: 'assets/images/fego_user_app.jpg',
                            isMobile: true,
                            bgColor: bgColor,
                            borderColor: borderColor,
                            textPrimary: textPrimary,
                          ),
                          const SizedBox(height: 16),
                          _buildMockupCard(
                            title: 'FeGo Driver App',
                            badge: 'Driver Partner',
                            image: 'assets/images/fego_driver_app.jpg',
                            isMobile: true,
                            bgColor: bgColor,
                            borderColor: borderColor,
                            textPrimary: textPrimary,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildMockupCard(
                              title: 'FeGo Passenger App',
                              badge: 'Rider Client',
                              image: 'assets/images/fego_user_app.jpg',
                              isMobile: false,
                              bgColor: bgColor,
                              borderColor: borderColor,
                              textPrimary: textPrimary,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildMockupCard(
                              title: 'FeGo Driver App',
                              badge: 'Driver Partner',
                              image: 'assets/images/fego_driver_app.jpg',
                              isMobile: false,
                              bgColor: bgColor,
                              borderColor: borderColor,
                              textPrimary: textPrimary,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 28),

                // Key Technical Highlights Section
                Container(
                  padding: EdgeInsets.all(isMobile ? 16 : 22),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.psychology_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Key Engineering Highlights & Problem Solving',
                            style: AppTypography.h4.copyWith(
                              color: textPrimary,
                              fontSize: isMobile ? 15 : 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildHighlightItem(
                        title: 'Live WebSocket Synchronization:',
                        description:
                            'Maintained persistent duplex socket streams for instant ride dispatching, fare negotiations, driver pings, and state recovery upon network reconnect.',
                        isMobile: isMobile,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                      ),
                      const SizedBox(height: 10),
                      _buildHighlightItem(
                        title: 'Geospatial Interpolation:',
                        description:
                            'Integrated Google Maps SDK with coordinate interpolation (lerp) to smoothly animate moving vehicles on the map, eliminating GPS marker jumping.',
                        isMobile: isMobile,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                      ),
                      const SizedBox(height: 10),
                      _buildHighlightItem(
                        title: 'Deterministic State Machine:',
                        description:
                            'Employed Cubit to manage multi-step trip lifecycles (Requesting → Accepted → In-Trip → Completed) with zero state corruption across disconnects.',
                        isMobile: isMobile,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tags Matrix
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Flutter SDK',
                    'Clean Architecture',
                    'Cubit State Machine',
                    'WebSockets (Live Duplex)',
                    'Google Maps SDK',
                    'Firebase Cloud Messaging (FCM)',
                    'Dio / REST APIs',
                    'Foreground GPS Streaming',
                  ].map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                          fontSize: isMobile ? 11 : 13,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Action Buttons Row
                Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => launchLink('demos/fego/'),
                      icon: const Icon(
                        Icons.phone_iphone_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Live Interactive Demo',
                            style: AppTypography.button.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7259AA),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: const Color(0xFF7259AA).withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 24,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => launchLink('https://play.google.com/store/search?q=fego&c=apps'),
                      icon: const FaIcon(
                        FontAwesomeIcons.googlePlay,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Google Play Store',
                        style: AppTypography.button.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 24,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openImagePreview(
                        context,
                        'assets/images/fego_user_app.jpg',
                        'FeGo Passenger App',
                      ),
                      icon: Icon(
                        Icons.fullscreen_rounded,
                        size: 18,
                        color: isDark ? Colors.white : textPrimary,
                      ),
                      label: Text(
                        'Zoom Passenger UI',
                        style: AppTypography.button.copyWith(
                          color: isDark ? Colors.white : textPrimary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 20,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openImagePreview(
                        context,
                        'assets/images/fego_driver_app.jpg',
                        'FeGo Driver App',
                      ),
                      icon: Icon(
                        Icons.fullscreen_rounded,
                        size: 18,
                        color: isDark ? Colors.white : textPrimary,
                      ),
                      label: Text(
                        'Zoom Driver UI',
                        style: AppTypography.button.copyWith(
                          color: isDark ? Colors.white : textPrimary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 20,
                          vertical: isMobile ? 12 : 16,
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
    );
  }

  Widget _buildMockupCard({
    required String title,
    required String badge,
    required String image,
    required bool isMobile,
    required Color bgColor,
    required Color borderColor,
    required Color textPrimary,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _openImagePreview(context, image, title),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: SizedBox(
                height: isMobile ? 180 : 270,
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem({
    required String title,
    required String description,
    required bool isMobile,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Icon(Icons.arrow_right_rounded, color: AppColors.primaryLight, size: 18),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$title ',
              style: AppTypography.bodySmall.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 13 : 14,
              ),
              children: [
                TextSpan(
                  text: description,
                  style: AppTypography.bodySmall.copyWith(
                    color: textSecondary,
                    fontWeight: FontWeight.normal,
                    height: 1.45,
                    fontSize: isMobile ? 12 : 13.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
