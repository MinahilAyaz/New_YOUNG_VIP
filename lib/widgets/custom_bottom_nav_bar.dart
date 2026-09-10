import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      {
        'icon': Icons.explore_rounded,
        'label': 'Discover',
        'hasBadge': false,
      },
      {
        'icon': Icons.science_rounded,
        'label': 'Labs',
        'hasBadge': true,
      },
      {
        'icon': Icons.groups_rounded,
        'label': 'Rooms',
        'hasBadge': false,
      },
      {
        'icon': Icons.construction_rounded,
        'label': 'Builds',
        'hasBadge': false,
      },
      {
        'icon': Icons.trending_up_rounded,
        'label': 'Fluency',
        'hasBadge': false,
      },
    ];

    Widget navDock = Container(
      height: 58.0,
      margin: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.bananiInk.withValues(alpha: 0.08),
            blurRadius: 28.0,
            offset: const Offset(0, 10.0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.bananiPrimary.withValues(alpha: 0.06),
            blurRadius: 14.0,
            offset: const Offset(0, 4.0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(
                color: AppColors.bananiBorder.withValues(alpha: 0.85),
                width: 1.2,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const double horizontalPadding = 6.0;
                const double verticalPadding = 6.0;
                final double usableWidth =
                    constraints.maxWidth - (horizontalPadding * 2);
                final double itemWidth = usableWidth / navItems.length;

                return Stack(
                  children: [
                    // Smooth sliding active pill indicator
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      left: horizontalPadding + (currentIndex * itemWidth),
                      top: verticalPadding,
                      bottom: verticalPadding,
                      width: itemWidth,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.bananiInk,
                              Color(0xFF222C42),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(26.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.bananiInk.withValues(alpha: 0.28),
                              blurRadius: 10.0,
                              offset: const Offset(0, 3.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Tab item tap targets and icons
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding),
                      child: Row(
                        children: List.generate(navItems.length, (index) {
                          final bool isSelected = currentIndex == index;
                          final item = navItems[index];
                          final bool hasBadge = item['hasBadge'] == true;

                          return Expanded(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Tooltip(
                                message: item['label'] as String,
                                waitDuration: const Duration(milliseconds: 600),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    if (onTap != null) {
                                      onTap!(index);
                                    } else {
                                      handleNavigation(
                                          context, index, currentIndex);
                                    }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      switchInCurve: Curves.easeOut,
                                      switchOutCurve: Curves.easeIn,
                                      child: isSelected
                                          ? FittedBox(
                                              key: ValueKey('sel_$index'),
                                              fit: BoxFit.scaleDown,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      item['icon'] as IconData,
                                                      size: 15.0,
                                                      color: AppColors.pureWhite,
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                      item['label'] as String,
                                                      style: const TextStyle(
                                                        color:
                                                            AppColors.pureWhite,
                                                        fontSize: 11.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 0.1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Stack(
                                              key: ValueKey('unsel_$index'),
                                              clipBehavior: Clip.none,
                                              children: [
                                                Icon(
                                                  item['icon'] as IconData,
                                                  size: 19.0,
                                                  color: AppColors.textSecondary,
                                                ),
                                                if (hasBadge)
                                                  Positioned(
                                                    top: -1.0,
                                                    right: -2.0,
                                                    child: Container(
                                                      width: 6.0,
                                                      height: 6.0,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors.coral,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                    ),
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
          ),
        ),
      ),
    );

    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520.0),
          child: navDock,
        ),
      ),
    );
  }
}
