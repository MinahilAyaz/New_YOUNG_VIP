import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/discover_category_model.dart';
import '../viewmodels/discover_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_field.dart';
import 'lab_room_view.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

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
                      vertical: 20.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 28.0),
                          _buildHeading(),
                          const SizedBox(height: 20.0),
                          _buildSearchField(viewModel),
                          const SizedBox(height: 20.0),
                          _buildCategoryGrid(viewModel),
                          const SizedBox(height: 20.0),
                          _buildPromoBanner(),
                          const SizedBox(height: 16.0),
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
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 0,
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

  Widget _buildHeading() {
    return Text(
      'What do you want to understand?',
      style: AppTextStyles.headingMedium.copyWith(
        fontSize: 21.0,
        letterSpacing: -0.4,
      ),
      maxLines: 1,
    );
  }

  Widget _buildSearchField(DiscoverViewModel viewModel) {
    final controller = TextEditingController(text: viewModel.searchQuery);
    return CustomTextField(
      hintText: 'Search Labs or technologies...',
      controller: controller,
      prefixIcon: Icons.search,
    );
  }

  Widget _buildCategoryGrid(DiscoverViewModel viewModel) {
    final categories = viewModel.categories;
    if (categories.length < 4) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildCategoryCard(categories[0])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildCategoryCard(categories[1])),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _buildCategoryCard(categories[2])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildCategoryCard(categories[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(DiscoverCategoryModel category) {
    return CustomCard(
      backgroundColor: category.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const SizedBox(height: 14.0),
          Text(
            'Explore →',
            style: TextStyle(
              color: category.accentColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.royalIndigo,
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'FREE FIRST LAB',
                style: TextStyle(
                  color: AppColors.softGreen,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            Text(
              'Build & Stress-Test Your\nFirst AI Workflow',
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.pureWhite,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Build - Break - Understand - Advise',
              style: TextStyle(
                color: AppColors.pureWhite.withValues(alpha: 0.75),
                fontSize: 11.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 18.0),
            CustomButton(
              label: 'Start Free',
              onPressed: () {},
              backgroundColor: AppColors.pureWhite,
              textColor: AppColors.royalIndigo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentRoomCard(
      BuildContext context, DiscoverViewModel viewModel) {
    final room = viewModel.currentRoom;
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.lightLavender,
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    room.label,
                    style: const TextStyle(
                      color: AppColors.royalIndigo,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    room.title,
                    style: AppTextStyles.headingSmall.copyWith(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepInk,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    room.subtitle,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11.5,
                      color: AppColors.blueGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14.0),
            CustomButton(
              label: 'Open Room',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LabRoomView(),
                  ),
                );
              },
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }
}
