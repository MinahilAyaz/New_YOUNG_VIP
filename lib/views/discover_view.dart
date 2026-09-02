import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/navigation/tab_navigation_service.dart';
import '../core/theme/app_colors.dart';
import '../data/models/discover_category_model.dart';
import '../viewmodels/discover_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_field.dart';

class DiscoverView extends StatelessWidget {
  final bool isRootTab;

  const DiscoverView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiscoverViewModel>(
      create: (_) => DiscoverViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<DiscoverViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;

            return SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 12.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 18.0),
                          _buildHeading(),
                          const SizedBox(height: 16.0),
                          _buildSearchField(viewModel),
                          const SizedBox(height: 18.0),
                          _buildPromoBanner(context),
                          const SizedBox(height: 18.0),
                          _buildSectionHeader('Explore Domains', onSeeAll: () {
                            TabNavigationService.switchToTab(context, 1);
                          }),
                          const SizedBox(height: 12.0),
                          _buildCategoryGrid(context, viewModel),
                          const SizedBox(height: 18.0),
                          _buildSectionHeader('Live Peer Rooms', onSeeAll: () {
                            TabNavigationService.switchToTab(context, 2);
                          }),
                          const SizedBox(height: 12.0),
                          _buildCurrentRoomCard(context, viewModel),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: isRootTab
            ? null
            : const CustomBottomNavBar(
                currentIndex: 0,
              ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color(0xFFEDE7F2),
                      width: 1.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'YOUNG ',
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                      TextSpan(
                        text: 'VIP',
                        style: TextStyle(
                          color: AppColors.mutedPurple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFEDE7F2),
                  width: 1.0,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                  Positioned(
                    top: 7.0,
                    right: 8.0,
                    child: Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 34.0,
              height: 34.0,
              decoration: const BoxDecoration(
                color: AppColors.avatarBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'AV',
                style: TextStyle(
                  color: AppColors.avatarText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'What do you want to\nunderstand?',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Explore live interactive labs & builder workflows',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(DiscoverViewModel viewModel) {
    final controller = TextEditingController(text: viewModel.searchQuery);
    return CustomTextField(
      hintText: 'Search Labs or technologies...',
      controller: controller,
      prefixIcon: Icons.search_rounded,
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 15.5,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: const Text(
              'See all →',
              style: TextStyle(
                color: AppColors.mutedPurple,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryGrid(BuildContext context, DiscoverViewModel viewModel) {
    final categories = viewModel.categories;
    if (categories.length < 4) return const SizedBox.shrink();

    final icons = [
      Icons.bolt_rounded,
      Icons.lightbulb_rounded,
      Icons.security_rounded,
      Icons.settings_rounded,
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildCategoryCard(context, categories[0], icons[0])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildCategoryCard(context, categories[1], icons[1])),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _buildCategoryCard(context, categories[2], icons[2])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildCategoryCard(context, categories[3], icons[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, DiscoverCategoryModel category, IconData icon) {
    return GestureDetector(
      onTap: () {
        TabNavigationService.switchToTab(context, 1);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: category.accentColor.withValues(alpha: 0.15),
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: category.accentColor,
                size: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              category.title,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Explore →',
              style: TextStyle(
                color: category.accentColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.heroCardPurple,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroCardPurple.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 6.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF857A9D),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Text(
                  'FREE FIRST LAB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  const Text(
                    '34 active now',
                    style: TextStyle(
                      color: AppColors.heroCardSubtext,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Build & Stress-Test Your\nFirst AI Workflow',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 5.0),
          const Text(
            'Build · Break · Understand · Advise',
            style: TextStyle(
              color: AppColors.heroCardSubtext,
              fontSize: 11.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  TabNavigationService.switchToTab(context, 1);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 7.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Start Free →',
                    style: TextStyle(
                      color: Color(0xFF5B4F73),
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                '⏱️ 45 mins',
                style: TextStyle(
                  color: AppColors.heroCardSubtext,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentRoomCard(
      BuildContext context, DiscoverViewModel viewModel) {
    final room = viewModel.currentRoom;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.roomCardBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFFE2DCE8),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                room.label,
                style: const TextStyle(
                  color: AppColors.roomCardSubtext,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Color(0xFF065F46),
                    fontSize: 9.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  room.title,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepInk,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  TabNavigationService.switchToTab(context, 2);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 5.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    border: Border.all(
                      color: const Color(0xFF9E93B0),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Open Room',
                    style: TextStyle(
                      color: Color(0xFF5B4F73),
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            room.subtitle,
            style: const TextStyle(
              fontSize: 11.0,
              color: AppColors.roomCardSubtext,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
