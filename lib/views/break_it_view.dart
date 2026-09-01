import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/lab_stage_screen_model.dart';
import '../viewmodels/break_it_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class BreakItView extends StatelessWidget {
  const BreakItView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BreakItViewModel>(
      create: (_) => BreakItViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: Consumer<BreakItViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final stageData = viewModel.stageData;

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
                          _buildTopBar(),
                          const SizedBox(height: 28.0),
                          _buildHeader(stageData),
                          const SizedBox(height: 24.0),
                          _buildStepper(stageData.steps),
                          const SizedBox(height: 28.0),
                          _buildContentBlocks(stageData.contentBlocks),
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
          currentIndex: 1,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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

  Widget _buildHeader(BreakItStageModel stageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stageData.stageTitle,
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: AppColors.deepInk,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.coral.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            stageData.labTagLabel,
            style: const TextStyle(
              color: AppColors.coral,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepper(List<StageStepModel> steps) {
    return Row(
      children: steps.map((step) {
        return Expanded(
          child: Column(
            children: [
              if (step.isActive)
                Container(
                  width: 13.0,
                  height: 13.0,
                  decoration: const BoxDecoration(
                    color: AppColors.coral,
                    shape: BoxShape.circle,
                  ),
                )
              else
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blueGray.withValues(alpha: 0.25),
                  ),
                ),
              const SizedBox(height: 6.0),
              Text(
                step.label,
                style: TextStyle(
                  color: step.isActive ? AppColors.coral : AppColors.blueGray,
                  fontSize: 11.0,
                  fontWeight:
                      step.isActive ? FontWeight.bold : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContentBlocks(List<ContentBlockModel> blocks) {
    return Column(
      children: blocks.map((block) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildContentCard(block),
        );
      }).toList(),
    );
  }

  Widget _buildBlockIcon(ContentBlockModel block) {
    if (block.tagLabel == 'SCENARIO') {
      return Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 4.0),
        child: Transform.rotate(
          angle: 0.785398, // 45 degrees
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              border: Border.all(color: block.accentColor, width: 1.5),
            ),
          ),
        ),
      );
    } else if (block.tagLabel == 'QUIZ') {
      return Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 4.0),
        child: Text(
          '?',
          style: TextStyle(
            color: block.accentColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else {
      return Icon(
        Icons.play_arrow,
        size: 19.0,
        color: block.accentColor,
      );
    }
  }

  Widget _buildContentCard(ContentBlockModel block) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: block.cardBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                block.tagLabel,
                style: TextStyle(
                  color: block.accentColor,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            Row(
              children: [
                _buildBlockIcon(block),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    block.title,
                    style: AppTextStyles.headingSmall.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepInk,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              block.description,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.blueGray,
                fontSize: 12.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14.0),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                label: block.buttonLabel,
                onPressed: () {},
                isPrimary: false,
                textColor: block.accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
