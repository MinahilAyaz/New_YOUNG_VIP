import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/assessment_result_model.dart';
import '../viewmodels/assessment_result_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'build_it_view.dart';
import 'fluency_assessment_view.dart';
import 'main_navigation_view.dart';
import 'profile_view.dart';

class AssessmentResultView extends StatelessWidget {
  const AssessmentResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AssessmentResultViewModel>(
      create: (_) => AssessmentResultViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.peachBackground,
        drawer: const CustomDrawer(),
        body: Consumer<AssessmentResultViewModel>(
          builder: (context, vm, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 28.0 : screenWidth * 0.055;
            final data = vm.resultData;

            return SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 14.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 20.0),
                          _buildHeroScoreCard(context, data),
                          const SizedBox(height: 18.0),
                          _buildMetricsRow(data),
                          const SizedBox(height: 22.0),
                          _buildTabBar(context, vm),
                          const SizedBox(height: 18.0),
                          if (vm.activeTab == 0) ...[
                            _buildDomainCompetencyOverview(data),
                            const SizedBox(height: 20.0),
                            _buildStrengthsCard(data),
                            const SizedBox(height: 20.0),
                            _buildRecommendationsCard(data),
                          ] else if (vm.activeTab == 1) ...[
                            _buildDetailedDomainsCard(data),
                          ] else ...[
                            _buildActionPlanCard(context, data),
                          ],
                          const SizedBox(height: 20.0),
                          _buildCredentialCard(context, vm, data),
                          const SizedBox(height: 20.0),
                          _buildNextLabCard(context, data),
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
              onTap: () => Navigator.pop(context),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.bananiCard,
                  borderRadius: BorderRadius.circular(9.0),
                  border: Border.all(
                    color: AppColors.bananiBorder,
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bananiInk.withValues(alpha: 0.04),
                      blurRadius: 8.0,
                      offset: const Offset(0, 2.0),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.bananiInk,
                  size: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Builder(
              builder: (ctx) => GestureDetector(
                onTap: () => Scaffold.of(ctx).openDrawer(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: AppColors.bananiCard,
                    borderRadius: BorderRadius.circular(9.0),
                    border: Border.all(
                      color: AppColors.bananiBorder,
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bananiInk.withValues(alpha: 0.04),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2.0),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.bananiInk,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),

        const Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: YoungVipWordmark(),
          ),
        ),

        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.bananiPrimary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                content: const Row(
                  children: [
                    Icon(Icons.share_rounded, color: AppColors.pureWhite, size: 18.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Verified Score Link copied to clipboard!',
                      style: TextStyle(color: AppColors.pureWhite),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: AppColors.bananiCard,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.bananiBorder,
                width: 1.0,
              ),
            ),
            child: const Icon(
              Icons.share_outlined,
              color: AppColors.deepInk,
              size: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroScoreCard(BuildContext context, AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 6.0,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiLavender,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: AppColors.royalIndigo,
                        size: 13.0,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'BENCHMARK VERIFIED',
                        style: TextStyle(
                          color: AppColors.royalIndigo,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiSuccessSoft,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  'PASSED',
                  style: TextStyle(
                    color: AppColors.softGreen,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),

          // Big Score Display
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${data.overallScore}',
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 68.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2.0,
                    height: 1.0,
                  ),
                ),
                const Text(
                  '%',
                  style: TextStyle(
                    color: AppColors.royalIndigo,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text(
                  '/ 100',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),

          // Fluency Tier Badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF7E6),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: AppColors.youngVipGold.withValues(alpha: 0.4),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.workspace_premium_rounded,
                    color: AppColors.youngVipGold,
                    size: 15.0,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    data.fluencyTier,
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),

          Text(
            data.assessmentTitle,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 17.0,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            data.assessmentSubtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          CustomButton(
            label: 'Continue to Discover ➔',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainNavigationView(initialIndex: 0),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsRow(AssessmentResultModel data) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricTile(
            icon: Icons.public_rounded,
            label: 'GLOBAL STANDING',
            value: data.percentileText,
            color: AppColors.royalIndigo,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildMetricTile(
            icon: Icons.timer_outlined,
            label: 'TIME RECORD',
            value: data.timeSpent,
            color: AppColors.youngVipGold,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildMetricTile(
            icon: Icons.task_alt_rounded,
            label: 'ACCURACY',
            value: '${data.correctAnswers}/${data.totalQuestions}',
            color: AppColors.softGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.bananiInk.withValues(alpha: 0.03),
            blurRadius: 8.0,
            offset: const Offset(0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 16.0),
          const SizedBox(height: 6.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 2.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, AssessmentResultViewModel vm) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isCompact = screenWidth < 400;
    final tabs = isCompact
        ? ['Overview', 'Breakdown', 'Action Plan']
        : ['Overview', 'Competency Breakdown', 'Action Plan'];

    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = vm.activeTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => vm.setActiveTab(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.royalIndigo
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.pureWhite
                          : AppColors.textSecondary,
                      fontSize: 11.5,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDomainCompetencyOverview(AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Domain Competency Breakdown',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14.0),
          ...data.domainScores.map((domain) => _buildDomainProgressBar(domain)),
        ],
      ),
    );
  }

  Widget _buildDomainProgressBar(DomainScoreModel domain) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(domain.icon, size: 15.0, color: domain.accentColor),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        domain.domainName,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: domain.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      domain.proficiencyLevel,
                      style: TextStyle(
                        color: domain.accentColor,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    '${domain.score}%',
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: LinearProgressIndicator(
              value: domain.score / 100.0,
              minHeight: 7.0,
              backgroundColor: AppColors.bananiBackground,
              valueColor: AlwaysStoppedAnimation<Color>(domain.accentColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedDomainsCard(AssessmentResultModel data) {
    return Column(
      children: data.domainScores.map((domain) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: AppColors.softShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: domain.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(domain.icon, color: domain.accentColor, size: 22.0),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      domain.domainName,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Proficiency: ${domain.proficiencyLevel} • Verified Milestone',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${domain.score}%',
                style: TextStyle(
                  color: domain.accentColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStrengthsCard(AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_rounded,
                    color: AppColors.softGreen, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'Validated Competency Strengths',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          ...data.topStrengths.map((str) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6.0, right: 8.0),
                    width: 5.0,
                    height: 5.0,
                    decoration: const BoxDecoration(
                      color: AppColors.softGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      str,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard(AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lightbulb_outline_rounded,
                    color: AppColors.youngVipGold, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'High-Yield Growth Vectors',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          ...data.growthRecommendations.map((rec) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6.0, right: 8.0),
                    width: 5.0,
                    height: 5.0,
                    decoration: const BoxDecoration(
                      color: AppColors.youngVipGold,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rec,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionPlanCard(
      BuildContext context, AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended 30-Day Masterclass Plan',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12.0),
          _buildActionStep(
            number: '01',
            title: 'Complete Autonomous Topology Lab',
            desc:
                'Cement your 95% Agent Orchestration score by configuring live dual-agent supervisors.',
            isDone: false,
          ),
          const SizedBox(height: 10.0),
          _buildActionStep(
            number: '02',
            title: 'Benchmark Latency SLAs under Concurrency',
            desc:
                'Simulate 100 concurrent agent tool calls with token budgeting.',
            isDone: false,
          ),
          const SizedBox(height: 10.0),
          _buildActionStep(
            number: '03',
            title: 'Earn Principal Architect Credential',
            desc:
                'Target the Level 15 Principal tier by completing 2 more verified enterprise labs.',
            isDone: false,
          ),
        ],
      ),
    );
  }

  Widget _buildActionStep({
    required String number,
    required String title,
    required String desc,
    required bool isDone,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: AppColors.bananiLavender,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: AppColors.royalIndigo,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                desc,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialCard(
      BuildContext context, AssessmentResultViewModel vm, AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: AppColors.youngVipGold.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 6.0,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF7E6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: AppColors.youngVipGold,
                        size: 18.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text(
                      'OFFICIAL VIP CREDENTIAL',
                      style: TextStyle(
                        color: AppColors.youngVipGold,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiBackground,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Text(
                  data.credentialId,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            data.credentialName,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Cryptographically verified on-chain • Hash: ${data.verificationHash}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    vm.toggleSaveCredential();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.bananiPrimary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        content: Text(
                          vm.isCredentialSaved
                              ? 'Credential added to your public profile!'
                              : 'Credential removed from profile.',
                          style: const TextStyle(color: AppColors.pureWhite),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    vm.isCredentialSaved
                        ? Icons.bookmark_added_rounded
                        : Icons.bookmark_add_outlined,
                    size: 16.0,
                  ),
                  label: Text(
                    vm.isCredentialSaved
                        ? 'Saved to Profile'
                        : 'Add to Profile',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: vm.isCredentialSaved
                        ? AppColors.bananiSuccessSoft
                        : AppColors.royalIndigo,
                    foregroundColor: vm.isCredentialSaved
                        ? AppColors.softGreen
                        : AppColors.pureWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileView()),
                  );
                },
                icon: const Icon(Icons.person_rounded, size: 16.0),
                label: const Text(
                  'View Profile',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.deepInk,
                  side: const BorderSide(color: AppColors.borderLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 12.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNextLabCard(
      BuildContext context, AssessmentResultModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended Next Step',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            data.recommendedLabTitle,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            data.recommendedLabSubtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
          CustomButton(
            label: 'Continue to Discover ➔',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainNavigationView(initialIndex: 0),
                ),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BuildItView()),
                );
              },
              icon: const Icon(Icons.rocket_launch_rounded, size: 16.0),
              label: const Text(
                'Launch Recommended Lab',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.deepInk,
                side: const BorderSide(color: AppColors.borderLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FluencyAssessmentView(),
                  ),
                );
              },
              icon: const Icon(Icons.refresh_rounded, size: 16.0),
              label: const Text(
                'Retake Diagnostic Assessment',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.bananiPrimary,
                side: const BorderSide(color: AppColors.bananiPrimary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
