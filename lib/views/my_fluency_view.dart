import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/my_fluency_model.dart';
import '../viewmodels/my_fluency_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';

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
                          _buildHeroLevelCard(fluencyData),
                          const SizedBox(height: 22.0),
                          _buildSectionHeader('Competency Domains (${fluencyData.skills.length})'),
                          const SizedBox(height: 12.0),
                          _buildSkillsList(fluencyData.skills),
                          const SizedBox(height: 20.0),
                          _buildSectionHeader('Verified Credentials'),
                          const SizedBox(height: 12.0),
                          _buildCertificateCard(context),
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
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
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
                    Icons.menu_rounded,
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

  Widget _buildHeroLevelCard(MyFluencyModel fluencyData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.heroCardPurple,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroCardPurple.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 6.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF857A9D),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.military_tech_rounded,
                      color: Colors.white,
                      size: 13.0,
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      'VIP FLUENCY TIER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '84% Overall',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            fluencyData.levelTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: const LinearProgressIndicator(
              value: 0.84,
              minHeight: 6.0,
              backgroundColor: Color(0xFF857A9D),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            fluencyData.levelSubtitle,
            style: const TextStyle(
              color: AppColors.heroCardSubtext,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
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
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: skill.bgColor,
                  borderRadius: BorderRadius.circular(12.0),
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
                    backgroundColor: const Color(0xFFF1EDF5),
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
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: AppColors.pastelSand,
              borderRadius: BorderRadius.circular(12.0),
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
              horizontal: 12.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.roomCardBg,
              borderRadius: BorderRadius.circular(20.0),
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
