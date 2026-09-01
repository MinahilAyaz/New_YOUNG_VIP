import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/my_fluency_model.dart';
import '../viewmodels/my_fluency_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';

class MyFluencyView extends StatelessWidget {
  const MyFluencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyFluencyViewModel>(
      create: (_) => MyFluencyViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<MyFluencyViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final fluencyData = viewModel.fluencyData;

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
                          _buildHeading(fluencyData.title),
                          const SizedBox(height: 20.0),
                          _buildLevelBanner(fluencyData),
                          const SizedBox(height: 24.0),
                          _buildSkillsList(fluencyData.skills),
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
          currentIndex: 4,
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

  Widget _buildLevelBanner(MyFluencyModel fluencyData) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.royalIndigo,
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fluencyData.levelTitle,
              style: const TextStyle(
                color: AppColors.youngVipGold,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              fluencyData.levelSubtitle,
              style: TextStyle(
                color: AppColors.pureWhite.withValues(alpha: 0.8),
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsList(List<FluencySkillModel> skills) {
    return Column(
      children: skills.map((skill) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: _buildSkillCard(skill),
        );
      }).toList(),
    );
  }

  Widget _buildSkillCard(FluencySkillModel skill) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skill.title,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: LinearProgressIndicator(
                      value: skill.progress,
                      minHeight: 8.0,
                      backgroundColor: const Color(0xFFF2EFE9),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.royalIndigo,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightLavender,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    skill.badgeLabel,
                    style: const TextStyle(
                      color: AppColors.royalIndigo,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
