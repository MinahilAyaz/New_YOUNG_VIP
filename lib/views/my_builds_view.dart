import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/my_builds_model.dart';
import '../viewmodels/my_builds_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';

class MyBuildsView extends StatelessWidget {
  final bool isRootTab;

  const MyBuildsView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyBuildsViewModel>(
      create: (_) => MyBuildsViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<MyBuildsViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final buildsData = viewModel.buildsData;

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
                          const SizedBox(height: 18.0),
                          _buildHeroLevelCard(buildsData),
                          const SizedBox(height: 18.0),
                          _buildFilterPills(viewModel),
                          const SizedBox(height: 18.0),
                          _buildSectionHeader('Live Workflows (${viewModel.filteredItems.length})'),
                          const SizedBox(height: 12.0),
                          _buildBuildItemsList(viewModel.filteredItems),
                          const SizedBox(height: 16.0),
                          _buildCreateBuildPill(context),
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
                currentIndex: 3,
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
          'My Builds',
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
          'Autonomous agents, RAG pipelines & deployments',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroLevelCard(MyBuildsModel buildsData) {
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
                  horizontal: 10.0,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF857A9D),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: 13.0,
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      'BUILDER PLATINUM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '780 / 1000 XP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: const LinearProgressIndicator(
              value: 0.78,
              minHeight: 6.0,
              backgroundColor: Color(0xFF857A9D),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildsData.stats.map((stat) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        stat.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        stat.label,
                        style: const TextStyle(
                          color: AppColors.heroCardSubtext,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPills(MyBuildsViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: viewModel.filters.map((filter) {
          final bool isSelected = viewModel.selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => viewModel.setFilter(filter),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 7.0,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.deepInk : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.deepInk
                        : const Color(0xFFEDE7F2),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.pureWhite
                        : AppColors.deepInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 15.5,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildBuildItemsList(List<BuildItemModel> items) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildBuildCard(item),
        );
      }).toList(),
    );
  }

  Widget _buildBuildCard(BuildItemModel item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: item.statusBg,
              borderRadius: BorderRadius.circular(12.0),
            ),
            alignment: Alignment.center,
            child: Icon(
              item.icon,
              size: 22.0,
              color: item.statusText,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: item.statusBg,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        item.status,
                        style: TextStyle(
                          color: item.statusText,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3.0),
                Text(
                  item.metrics,
                  style: const TextStyle(
                    color: AppColors.roomCardSubtext,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 6.5,
            ),
            decoration: BoxDecoration(
              color: AppColors.roomCardBg,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Text(
              'Inspect →',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateBuildPill(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.deepInk,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepInk.withValues(alpha: 0.15),
              blurRadius: 16.0,
              offset: const Offset(0, 4.0),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, color: AppColors.pureWhite, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'Create New Build',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
