import 'package:flutter/material.dart';
import '../core/navigation/tab_navigation_service.dart';
import '../core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  static void handleNavigation(
      BuildContext context, int targetIndex, int currentIndex) {
    if (targetIndex == currentIndex) return;
    TabNavigationService.switchToTab(context, targetIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.explore_rounded, 'label': 'Discover'},
      {'icon': Icons.science_rounded, 'label': 'Labs'},
      {'icon': Icons.forum_rounded, 'label': 'Rooms'},
      {'icon': Icons.widgets_rounded, 'label': 'Builds'},
      {'icon': Icons.workspace_premium_rounded, 'label': 'Fluency'},
    ];

    Widget navDock = Container(
      height: 52.0,
      margin: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F1A24).withValues(alpha: 0.07),
            blurRadius: 20.0,
            offset: const Offset(0, 6.0),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double horizontalPadding = 5.0;
          const double verticalPadding = 5.0;
          final double usableWidth = constraints.maxWidth - (horizontalPadding * 2);
          final double itemWidth = usableWidth / navItems.length;

          return Stack(
            children: [
              // Smooth sliding pill indicator
              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOutCubic,
                left: horizontalPadding + (currentIndex * itemWidth),
                top: verticalPadding,
                bottom: verticalPadding,
                width: itemWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.deepInk,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              // Tab item tap targets and icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: List.generate(navItems.length, (index) {
                    final bool isSelected = currentIndex == index;
                    final item = navItems[index];

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (onTap != null) {
                            onTap!(index);
                          } else {
                            handleNavigation(context, index, currentIndex);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: isSelected
                                ? FittedBox(
                                    key: ValueKey('sel_$index'),
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            item['icon'] as IconData,
                                            size: 15.0,
                                            color: AppColors.pureWhite,
                                          ),
                                          const SizedBox(width: 4.5),
                                          Text(
                                            item['label'] as String,
                                            style: const TextStyle(
                                              color: AppColors.pureWhite,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Icon(
                                    key: ValueKey('unsel_$index'),
                                    item['icon'] as IconData,
                                    size: 17.5,
                                    color: AppColors.mutedPurple,
                                  ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );

    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540.0),
          child: navDock,
        ),
      ),
    );
  }
}
