import 'package:flutter/material.dart';
import '../widgets/young_vip_wordmark.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/my_fluency_model.dart';
import '../viewmodels/my_fluency_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import 'assessment_result_view.dart';

class MyFluencyView extends StatelessWidget {
  final bool isRootTab;

  const MyFluencyView({
    super.key,
    this.isRootTab = false,
  });

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
                          _buildHeroLevelCard(context, fluencyData),
                          const SizedBox(height: 22.0),
                          _buildSectionHeader('Competency Domains (${fluencyData.skills.length})'),
                          const SizedBox(height: 12.0),
                          _buildSkillsList(fluencyData.skills),
                          const SizedBox(height: 20.0),
                          _buildSectionHeader('Verified Credentials'),
                          const SizedBox(height: 12.0),
                          _buildCertificateCard(context),
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
                currentIndex: 4,
              ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => Scaffold.of(ctx).openDrawer(),
              behavior: HitTestBehavior.opaque,
              child: Row(
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
                    child: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.deepInk,
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: YoungVipWordmark(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
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

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'My Fluency',
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
          'AI engineering competency & verified milestones',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroLevelCard(
      BuildContext context, MyFluencyModel fluencyData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pastelLilac,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.military_tech_rounded,
                          color: AppColors.deepInk,
                          size: 13.0,
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          'VIP FLUENCY TIER',
                          style: TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                '84% Overall',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            fluencyData.levelTitle,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 19.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: const LinearProgressIndicator(
              value: 0.84,
              minHeight: 6.0,
              backgroundColor: Color(0x33D49B85),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepInk),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            fluencyData.levelSubtitle,
            style: const TextStyle(
              color: AppColors.roomCardSubtext,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AssessmentResultView()),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColors.bananiLavender,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: AppColors.royalIndigo.withValues(alpha: 0.2),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.assessment_outlined,
                          size: 16.0,
                          color: AppColors.royalIndigo,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'View Benchmark Assessment Result (91%)',
                            style: TextStyle(
                              color: AppColors.royalIndigo,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12.0,
                    color: AppColors.royalIndigo,
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildSkillsList(List<FluencySkillModel> skills) {
    return Column(
      children: skills.map((skill) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildSkillCard(skill),
        );
      }).toList(),
    );
  }

  Widget _buildSkillCard(FluencySkillModel skill) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: skill.bgColor,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                alignment: Alignment.center,
                child: Icon(
                  skill.icon,
                  size: 22.0,
                  color: skill.textColor,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            skill.title,
                            style: const TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: skill.bgColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            skill.badgeLabel,
                            style: TextStyle(
                              color: skill.textColor,
                              fontSize: 9.0,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      skill.completedCount,
                      style: const TextStyle(
                        color: AppColors.roomCardSubtext,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: LinearProgressIndicator(
                    value: skill.progress,
                    minHeight: 5.5,
                    backgroundColor: AppColors.roomCardBg,
                    valueColor: AlwaysStoppedAnimation<Color>(skill.textColor),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                '${(skill.progress * 100).toInt()}%',
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: AppColors.pastelSand,
              borderRadius: BorderRadius.circular(14.0),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: AppColors.pastelSandText,
              size: 22.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Verified AI Systems Architect',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.0),
                Text(
                  'Young VIP Global Certification · Issued 2026',
                  style: TextStyle(
                    color: AppColors.roomCardSubtext,
                    fontSize: 11.0,
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
              vertical: 7.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.alabaster,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Text(
              'View →',
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
}
