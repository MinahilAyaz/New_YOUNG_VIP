import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/lab_stage_screen_model.dart';
import '../viewmodels/break_it_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'understand_it_view.dart';

class BreakItView extends StatelessWidget {
  final bool isRootTab;

  const BreakItView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BreakItViewModel>(
      create: (_) => BreakItViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
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
                      vertical: 12.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 18.0),
                          _buildHeader(stageData),
                          const SizedBox(height: 18.0),
                          _buildStepper(stageData.steps),
                          const SizedBox(height: 20.0),
                          _buildContentBlocks(stageData.contentBlocks),
                          const SizedBox(height: 16.0),
                          _buildProceedPill(context),
                          const SizedBox(height: 88.0),
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
                currentIndex: 1,
              ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: AppColors.buttonShadow,
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.deepInk,
                  size: 18.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Builder(
              builder: (ctx) => GestureDetector(
                onTap: () => Scaffold.of(ctx).openDrawer(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: AppColors.buttonShadow,
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const YoungVipWordmark(),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: AppColors.buttonShadow,
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
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: AppColors.avatarBg,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: AppColors.buttonShadow,
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

  Widget _buildHeader(BreakItStageModel stageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stageData.stageTitle,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
            color: AppColors.deepInk,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 3.5,
          ),
          decoration: BoxDecoration(
            color: AppColors.pastelCoral,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            stageData.labTagLabel,
            style: const TextStyle(
              color: AppColors.pastelCoralText,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepper(List<StageStepModel> steps) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        children: steps.map((step) {
          final isCurrent = step.isActive;
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: isCurrent ? 12.0 : 8.0,
                  height: isCurrent ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    color: isCurrent ? AppColors.deepInk : AppColors.borderLight,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  step.label,
                  style: TextStyle(
                    color: isCurrent ? AppColors.deepInk : AppColors.roomCardSubtext,
                    fontSize: 10.5,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContentBlocks(List<ContentBlockModel> blocks) {
    return Column(
      children: blocks.map((block) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildContentCard(block),
        );
      }).toList(),
    );
  }

  Widget _buildBlockIcon(ContentBlockModel block) {
    if (block.tagLabel == 'SCENARIO') {
      return Icon(Icons.psychology_alt_rounded, size: 18.0, color: block.accentColor);
    } else if (block.tagLabel == 'QUIZ') {
      return Icon(Icons.help_outline_rounded, size: 18.0, color: block.accentColor);
    } else {
      return Icon(Icons.play_circle_outline_rounded, size: 18.0, color: block.accentColor);
    }
  }

  Widget _buildContentCard(ContentBlockModel block) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: block.cardBackgroundColor,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 2.5,
            ),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              block.tagLabel,
              style: TextStyle(
                color: block.accentColor,
                fontSize: 9.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              _buildBlockIcon(block),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  block.title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepInk,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            block.description,
            style: const TextStyle(
              color: AppColors.roomCardSubtext,
              fontSize: 12.0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12.0),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.5,
              ),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color(0xFFEDE7F2),
                  width: 1.0,
                ),
              ),
              child: Text(
                block.buttonLabel,
                style: TextStyle(
                  color: block.accentColor,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedPill(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UnderstandItView(),
            ),
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.deepInk,
            borderRadius: BorderRadius.circular(28.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepInk.withValues(alpha: 0.22),
                blurRadius: 18.0,
                offset: const Offset(0, 6.0),
              ),
            ],
          ),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Complete Stage & Proceed to Understand It →',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
