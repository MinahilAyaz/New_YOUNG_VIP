import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/lab_detail_model.dart';
import '../viewmodels/lab_detail_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'break_it_view.dart';

class LabDetailView extends StatelessWidget {
  final bool isRootTab;

  const LabDetailView({
    super.key,
    this.isRootTab = false,
  });

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
                      vertical: 12.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 18.0),
                          _buildHeader(detail),
                          const SizedBox(height: 24.0),
                          _buildStageGrid(detail.stages),
                          const SizedBox(height: 20.0),
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
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
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
                  Icons.arrow_back_rounded,
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

  Widget _buildHeader(LabDetailModel detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.title,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
            height: 1.25,
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
            color: AppColors.pastelLavender,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            detail.tagLabel,
            style: const TextStyle(
              color: AppColors.pastelLavenderText,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          detail.description,
          style: const TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildStageGrid(List<LabStageModel> stages) {
    if (stages.length < 4) return const SizedBox.shrink();

    final icons = [
      Icons.build_rounded,
      Icons.bug_report_rounded,
      Icons.psychology_rounded,
      Icons.gavel_rounded,
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStageCard(stages[0], icons[0])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildStageCard(stages[1], icons[1])),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _buildStageCard(stages[2], icons[2])),
            const SizedBox(width: 12.0),
            Expanded(child: _buildStageCard(stages[3], icons[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildStageCard(LabStageModel stage, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: stage.backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
      child: Row(
        children: [
          Icon(icon, size: 18.0, color: stage.textColor),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
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
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, LabDetailModel detail) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pastelSage,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${detail.professionalsCount} professionals in this Lab',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.deepInk,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          Text(
            detail.unlockNote,
            style: const TextStyle(
              color: AppColors.pastelSageText,
              fontSize: 12.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BreakItView(),
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 8.5,
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
              child: const Text(
                'Start This Lab →',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
