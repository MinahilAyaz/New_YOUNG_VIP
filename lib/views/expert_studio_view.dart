import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/expert_studio_model.dart';
import '../viewmodels/expert_studio_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';

class ExpertStudioView extends StatelessWidget {
  const ExpertStudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpertStudioViewModel>(
      create: (_) => ExpertStudioViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<ExpertStudioViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final studioData = viewModel.studioData;

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
                          _buildHeader(studioData),
                          const SizedBox(height: 32.0),
                          _buildStatusList(studioData.statusItems),
                          const SizedBox(height: 24.0),
                          _buildActionButton(studioData.buttonLabel),
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

  Widget _buildHeader(ExpertStudioModel studioData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          studioData.screenTitle,
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: AppColors.deepInk,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.youngVipGold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            studioData.tagLabel,
            style: const TextStyle(
              color: AppColors.youngVipGold,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          studioData.description,
          style: const TextStyle(
            color: AppColors.blueGray,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusList(List<StudioStatusItemModel> statusItems) {
    return Column(
      children: statusItems.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: _buildStatusCard(item),
        );
      }).toList(),
    );
  }

  Widget _buildStatusCard(StudioStatusItemModel item) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${item.count}',
              style: TextStyle(
                color: item.countColor,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String buttonLabel) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.royalIndigo,
          foregroundColor: AppColors.pureWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
        ),
        child: Text(
          buttonLabel,
          style: const TextStyle(
            color: AppColors.pureWhite,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
