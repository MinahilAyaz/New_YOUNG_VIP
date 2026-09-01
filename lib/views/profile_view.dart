import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/user_profile_model.dart';
import '../viewmodels/profile_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';
import 'expert_studio_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final profileData = viewModel.profileData;

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
                          _buildHeading(),
                          const SizedBox(height: 24.0),
                          _buildProfileHeader(context, profileData),
                          const SizedBox(height: 28.0),
                          _buildStatsRow(profileData.stats),
                          const SizedBox(height: 28.0),
                          _buildRecentBuilds(profileData.recentBuilds),
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

  Widget _buildHeading() {
    return Text(
      'Profile',
      style: AppTextStyles.headingLarge.copyWith(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: AppColors.deepInk,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, UserProfileModel profileData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64.0,
          height: 64.0,
          decoration: const BoxDecoration(
            color: AppColors.lightLavender,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            profileData.initials,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileData.name,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.0),
              Text(
                profileData.profession,
                style: const TextStyle(
                  color: AppColors.blueGray,
                  fontSize: 12.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExpertStudioView(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.youngVipGold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    profileData.fluencyBadge,
                    style: const TextStyle(
                      color: AppColors.youngVipGold,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(List<ProfileStatModel> stats) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(stats[0])),
        const SizedBox(width: 10.0),
        Expanded(child: _buildStatCard(stats[1])),
        const SizedBox(width: 10.0),
        Expanded(child: _buildStatCard(stats[2])),
      ],
    );
  }

  Widget _buildStatCard(ProfileStatModel stat) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.value,
              style: TextStyle(
                color: stat.color,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6.0),
            Text(
              stat.label,
              style: const TextStyle(
                color: AppColors.blueGray,
                fontSize: 11.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBuilds(List<String> recentBuilds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Builds',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14.0),
        ...recentBuilds.map((buildTitle) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              child: CustomCard(
                backgroundColor: AppColors.pureWhite,
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  buildTitle,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
