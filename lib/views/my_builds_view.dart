import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/my_builds_model.dart';
import '../viewmodels/my_builds_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';

class MyBuildsView extends StatelessWidget {
  const MyBuildsView({super.key});

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
                      vertical: 20.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 28.0),
                          _buildHeading(buildsData.title),
                          const SizedBox(height: 24.0),
                          _buildStatsGrid(buildsData.stats),
                          const SizedBox(height: 28.0),
                          _buildBuildItemsList(buildsData.buildItems),
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
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 3,
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.menu_rounded,
                color: AppColors.deepInk,
                size: 26.0,
              ),
            ),
          ),
        ),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'YOUNG ',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              TextSpan(
                text: 'VIP',
                style: TextStyle(
                  color: AppColors.youngVipGold,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36.0,
          height: 36.0,
          decoration: const BoxDecoration(
            color: AppColors.lightLavender,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'AV',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading(String title) {
    return Text(
      title,
      style: AppTextStyles.headingLarge.copyWith(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: AppColors.deepInk,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildStatsGrid(List<BuildStatModel> stats) {
    if (stats.length < 4) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard(stats[0])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildStatCard(stats[1])),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _buildStatCard(stats[2])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildStatCard(stats[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildStatModel stat) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.value,
              style: TextStyle(
                color: stat.color,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6.0),
            Text(
              stat.label,
              style: const TextStyle(
                color: AppColors.blueGray,
                fontSize: 12.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildItemsList(List<BuildItemModel> items) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: _buildBuildItemCard(item),
        );
      }).toList(),
    );
  }

  Widget _buildBuildItemCard(BuildItemModel item) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: item.backgroundColor,
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 4.0),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: AppColors.blueGray,
                      fontSize: 12.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '→',
              style: TextStyle(
                color: AppColors.royalIndigo,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
