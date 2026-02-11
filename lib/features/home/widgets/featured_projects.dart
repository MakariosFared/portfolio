import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class FeaturedProjects extends StatelessWidget {
  const FeaturedProjects({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Row(
              children: [
                Container(width: 50, height: 2, color: AppColors.primary),
                const SizedBox(width: 15),
                Text(
                  'Featured Projects',
                  style: AppTypography.h2.copyWith(
                    color: AppColors.textLight,
                    fontSize: isMobile ? 28 : 36,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: isMobile ? 1.2 : 1.5,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: 200 * index),
                child: _ProjectCard(
                  title: _fakeProjects[index]['title']!,
                  description: _fakeProjects[index]['description']!,
                  tags: _fakeProjects[index]['tags'] as List<String>,
                  imageUrl: _fakeProjects[index]['image']!,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: isHovered
            ? (Matrix4.identity()..translate(0, -10, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: isHovered ? 0.3 : 0.1),
              blurRadius: isHovered ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Project Image Placeholder with Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.backgroundDark.withValues(alpha: 0.8),
                        AppColors.backgroundDark,
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: widget.tags
                          .map(
                            (tag) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primaryLight,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.title,
                      style: AppTypography.h3.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isHovered ? 1.0 : 0.0,
                      child: Row(
                        children: [
                          Text(
                            'View Project',
                            style: AppTypography.button.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: AppColors.accent,
                          ),
                        ],
                      ),
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

final List<Map<String, dynamic>> _fakeProjects = [
  {
    'title': 'E-Commerce Platform',
    'description':
        'A full-featured mobile shopping app built with Flutter and Firebase, featuring real-time updates and secure payments.',
    'image': '',
    'tags': ['Flutter', 'Firebase', 'Stripe'],
  },
  {
    'title': 'Task Management System',
    'description':
        'A collaborative project management tool for teams with drag-and-drop support and detailed analytics.',
    'image': '',
    'tags': ['Riverpod', 'Cloud Firestore', 'CI/CD'],
  },
  {
    'title': 'Health & Fitness Tracker',
    'description':
        'Personalized workout planning and nutrition tracking app with Google Fit integration.',
    'image': '',
    'tags': ['Flutter', 'Local Auth', 'Sqflite'],
  },
  {
    'title': 'AI Chat Companion',
    'description':
        'An intelligent conversational AI assistant powered by Google Gemini API with voice recognition.',
    'image': '',
    'tags': ['Gemini API', 'Speech-to-Text', 'Lottie'],
  },
];
