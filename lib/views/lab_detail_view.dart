import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/lab_detail_model.dart';
import '../viewmodels/lab_detail_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import 'break_it_view.dart';

class LabDetailView extends StatelessWidget {
  const LabDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LabDetailViewModel>(
      create: (_) => LabDetailViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: Consumer<LabDetailViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final detail = viewModel.labDetail;

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
                          _buildHeader(detail),
                          const SizedBox(height: 36.0),
                          _buildStageGrid(detail.stages),
                          const SizedBox(height: 28.0),
                          _buildSummaryCard(context, detail),
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

  Widget _buildHeader(LabDetailModel detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.title,
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
            horizontal: 12.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightLavender,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            detail.tagLabel,
            style: const TextStyle(
              color: AppColors.royalIndigo,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          detail.description,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.blueGray,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildStageGrid(List<LabStageModel> stages) {
    if (stages.length < 4) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStageCard(stages[0])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildStageCard(stages[1])),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _buildStageCard(stages[2])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildStageCard(stages[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildStageCard(LabStageModel stage) {
    return CustomCard(
      backgroundColor: stage.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stage.label,
            style: TextStyle(
              color: stage.textColor,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, LabDetailModel detail) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.softGreen.withValues(alpha: 0.12),
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${detail.professionalsCount} professionals in this Lab',
              style: AppTextStyles.headingSmall.copyWith(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: AppColors.deepInk,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0),
            Text(
              detail.unlockNote,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.blueGray,
                fontSize: 12.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20.0),
            // TODO: This currently jumps straight to the Break It stage. Once the Build It stage screen exists, re-wire this to navigate to Build It first, and have Break It reached from there instead.
            CustomButton(
              label: 'Start This Lab',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BreakItView(),
                  ),
                );
              },
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
