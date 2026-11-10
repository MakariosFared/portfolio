import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/utils/responsive/size_config.dart';
import 'projects/fego_flagship_card.dart';
import 'projects/project_card.dart';
import 'projects/project_model.dart';

class FeaturedProjects extends StatefulWidget {
  const FeaturedProjects({super.key});

  @override
  State<FeaturedProjects> createState() => _FeaturedProjectsState();
}

class _FeaturedProjectsState extends State<FeaturedProjects> {
  String _selectedCategory = 'All';

  List<ProjectItem> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return otherProjectsList;
    }
    return otherProjectsList
        .where((project) => project.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isMobile = SizeConfig.isMobile;
    final textPrimary = AppColors.getTextPrimary(context);
    final textSecondary = AppColors.getTextSecondary(context);
    final surfaceColor = AppColors.getSurface(context);
    final borderColor = AppColors.getBorder(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Featured Projects'),
          const SizedBox(height: 40),

          // 🌟 Flagship Project Showcase: FeGo Platform
          const ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            child: FeGoFlagshipCard(),
          ),

          const SizedBox(height: 60),

          // Subheader for Other Core Projects
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Other Core Projects',
                  style: AppTypography.h3.copyWith(
                    color: textPrimary,
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Category Filter Chips
          ScrollReveal(
            type: ScrollRevealType.fadeSlideUp,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: projectCategories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        fontSize: isMobile ? 12 : 13.5,
                      ),
                      backgroundColor: surfaceColor,
                      selectedColor: AppColors.primary,
                      showCheckmark: false,
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primaryLight
                            : borderColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 10 : 14,
                        vertical: isMobile ? 6 : 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Other Projects Grid (Filtered)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _filteredProjects.isEmpty
                ? Center(
                    key: const ValueKey('empty'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'No projects in this category.',
                        style: AppTypography.bodyMedium.copyWith(color: textSecondary),
                      ),
                    ),
                  )
                : Builder(
                    key: ValueKey(_selectedCategory),
                    builder: (context) {
                      if (isMobile) {
                        return Column(
                          children: List.generate(_filteredProjects.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: ScrollReveal(
                                type: ScrollRevealType.fadeSlideUp,
                                delay: Duration(milliseconds: 150 * index),
                                child: ProjectCard(project: _filteredProjects[index]),
                              ),
                            );
                          }),
                        );
                      }

                      // Desktop/Tablet: Dynamic responsive 2-column grid
                      final List<Widget> rows = [];
                      for (int i = 0; i < _filteredProjects.length; i += 2) {
                        final hasSecond = i + 1 < _filteredProjects.length;
                        rows.add(
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: i + 2 < _filteredProjects.length ? 35 : 0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ScrollReveal(
                                    type: ScrollRevealType.fadeSlideUp,
                                    delay: Duration(milliseconds: 100 * (i % 4)),
                                    child: ProjectCard(project: _filteredProjects[i]),
                                  ),
                                ),
                                const SizedBox(width: 35),
                                Expanded(
                                  child: hasSecond
                                      ? ScrollReveal(
                                          type: ScrollRevealType.fadeSlideUp,
                                          delay: Duration(
                                            milliseconds: 100 * ((i + 1) % 4),
                                          ),
                                          child: ProjectCard(project: _filteredProjects[i + 1]),
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Column(children: rows);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
