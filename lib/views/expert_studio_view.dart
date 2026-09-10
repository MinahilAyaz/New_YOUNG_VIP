import 'package:flutter/material.dart';
import '../widgets/young_vip_wordmark.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/expert_studio_model.dart';
import '../viewmodels/expert_studio_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';

class ExpertStudioView extends StatelessWidget {
  final bool isRootTab;

  const ExpertStudioView({
    super.key,
    this.isRootTab = false,
  });

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
                          _buildHeroCreatorCard(studioData),
                          const SizedBox(height: 20.0),
                          _buildSectionHeader('Creator Tools'),
                          const SizedBox(height: 12.0),
                          _buildCreatorToolsGrid(context),
                          const SizedBox(height: 22.0),
                          _buildSectionHeader('My Authored Labs (${studioData.authoredLabs.length})'),
                          const SizedBox(height: 12.0),
                          _buildAuthoredLabsList(studioData.authoredLabs),
                          const SizedBox(height: 16.0),
                          _buildActionPill(context, studioData.buttonLabel),
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
                currentIndex: 3,
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
            if (Navigator.canPop(context)) ...[
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
            ],
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

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Expert Studio',
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
          'Author, stress-test & publish interactive labs',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCreatorCard(ExpertStudioModel studioData) {
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.pastelLilac,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Text(
                  studioData.tagLabel,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const Text(
                '1.4k Learners',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          const Text(
            'Author Interactive AI Labs',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 19.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            studioData.description,
            style: const TextStyle(
              color: AppColors.roomCardSubtext,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: studioData.statusItems.map((item) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors.peachBackground.withValues(alpha: 0.40),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${item.count}',
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: AppColors.roomCardSubtext,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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

  Widget _buildCreatorToolsGrid(BuildContext context) {
    final tools = [
      {
        'title': 'Scenario Editor',
        'subtitle': 'Draft interactive workflows',
        'icon': Icons.edit_note_rounded,
        'color': AppColors.pastelLavender,
        'textColor': AppColors.pastelLavenderText,
      },
      {
        'title': 'Stress-Test Suite',
        'subtitle': 'Run prompt injections & evals',
        'icon': Icons.biotech_rounded,
        'color': AppColors.pastelSage,
        'textColor': AppColors.pastelSageText,
      },
      {
        'title': 'Builder Analytics',
        'subtitle': 'Engagement & completion stats',
        'icon': Icons.insights_rounded,
        'color': AppColors.pastelCoral,
        'textColor': AppColors.pastelCoralText,
      },
      {
        'title': 'Peer Reviews',
        'subtitle': 'Community Q&A & feedback',
        'icon': Icons.people_alt_rounded,
        'color': AppColors.pastelSand,
        'textColor': AppColors.pastelSandText,
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 1.35,
      children: tools.map((tool) {
        return Container(
          decoration: BoxDecoration(
            color: tool['color'] as Color,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: AppColors.buttonShadow,
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Icon(
                  tool['icon'] as IconData,
                  size: 18.0,
                  color: tool['textColor'] as Color,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tool['title'] as String,
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    tool['subtitle'] as String,
                    style: TextStyle(
                      color: (tool['textColor'] as Color).withValues(alpha: 0.85),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAuthoredLabsList(List<AuthoredLabModel> labs) {
    return Column(
      children: labs.map((lab) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(22.0),
              boxShadow: AppColors.softShadow,
            ),
            padding: const EdgeInsets.all(14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: lab.statusBg,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    lab.icon,
                    size: 22.0,
                    color: lab.statusText,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: lab.statusBg,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              lab.status,
                              style: TextStyle(
                                color: lab.statusText,
                                fontSize: 9.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            lab.rating,
                            style: const TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        lab.title,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        lab.learnersCount,
                        style: const TextStyle(
                          color: AppColors.roomCardSubtext,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                        ),
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
                    'Edit →',
                    style: TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionPill(BuildContext context, String buttonLabel) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 8.0,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.open_in_browser_rounded, color: AppColors.pureWhite, size: 16.0),
            const SizedBox(width: 6.0),
            Text(
              buttonLabel,
              style: const TextStyle(
                color: AppColors.pureWhite,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
