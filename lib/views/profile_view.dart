import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/user_profile_model.dart';
import '../viewmodels/profile_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import 'expert_studio_view.dart';

class ProfileView extends StatelessWidget {
  final bool isRootTab;

  const ProfileView({
    super.key,
    this.isRootTab = false,
  });

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
                          _buildProfileHeroCard(context, profileData),
                          const SizedBox(height: 20.0),
                          _buildSectionHeader('Weekly Activity'),
                          const SizedBox(height: 12.0),
                          _buildWeeklyActivityCard(),
                          const SizedBox(height: 20.0),
                          _buildSectionHeader('Preferences & Security'),
                          const SizedBox(height: 12.0),
                          _buildMenuOptions(context),
                          const SizedBox(height: 16.0),
                          _buildEditProfilePill(context),
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
          'Profile',
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
          'Manage your builder credentials & settings',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeroCard(BuildContext context, UserProfileModel profileData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: const BoxDecoration(
                  color: AppColors.avatarBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  profileData.initials,
                  style: const TextStyle(
                    color: AppColors.avatarText,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileData.name,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      profileData.profession,
                      style: const TextStyle(
                        color: AppColors.roomCardSubtext,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pastelLavender,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.military_tech_rounded,
                            color: AppColors.pastelLavenderText,
                            size: 12.0,
                          ),
                          SizedBox(width: 3.0),
                          Text(
                            'LEVEL 4 · ARCHITECT',
                            style: TextStyle(
                              color: AppColors.pastelLavenderText,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: AppColors.warmIvory,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('14', 'Builds Deployed'),
                Container(width: 1.0, height: 28.0, color: const Color(0xFFE2DCE8)),
                _buildStatItem('8', 'Labs Verified'),
                Container(width: 1.0, height: 28.0, color: const Color(0xFFE2DCE8)),
                _buildStatItem('99.4%', 'Fluency Score'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyActivityCard() {
    final activity = [
      {'day': 'Mon', 'height': 24.0, 'icon': Icons.bolt_rounded},
      {'day': 'Tue', 'height': 38.0, 'icon': Icons.lightbulb_rounded},
      {'day': 'Wed', 'height': 48.0, 'icon': Icons.local_fire_department_rounded},
      {'day': 'Thu', 'height': 32.0, 'icon': Icons.security_rounded},
      {'day': 'Fri', 'height': 42.0, 'icon': Icons.settings_rounded},
      {'day': 'Sat', 'height': 20.0, 'icon': Icons.eco_rounded},
      {'day': 'Sun', 'height': 16.0, 'icon': Icons.auto_awesome_rounded},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: activity.map((item) {
          final isMax = item['day'] == 'Wed';
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item['icon'] as IconData,
                size: 14.0,
                color: isMax ? AppColors.deepInk : AppColors.mutedPurple,
              ),
              const SizedBox(height: 6.0),
              Container(
                width: 16.0,
                height: item['height'] as double,
                decoration: BoxDecoration(
                  color: isMax ? AppColors.deepInk : AppColors.pastelLavender,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                item['day'] as String,
                style: const TextStyle(
                  color: AppColors.roomCardSubtext,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        }).toList(),
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

  Widget _buildMenuOptions(BuildContext context) {
    final options = [
      {
        'icon': Icons.notifications_none_rounded,
        'title': 'Notifications & Alerts',
        'subtitle': 'Push & email active',
        'color': AppColors.pastelLavender,
        'onTap': () {},
      },
      {
        'icon': Icons.workspace_premium_rounded,
        'title': 'Creator Studio',
        'subtitle': 'Publish interactive labs',
        'color': AppColors.pastelSand,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ExpertStudioView()),
          );
        },
      },
      {
        'icon': Icons.security_rounded,
        'title': 'Security & API Credentials',
        'subtitle': 'Anthropic & OpenAI configured',
        'color': AppColors.pastelSage,
        'onTap': () {},
      },
      {
        'icon': Icons.help_outline_rounded,
        'title': 'Help & Documentation',
        'subtitle': 'Architecture guides & FAQs',
        'color': AppColors.pastelCoral,
        'onTap': () {},
      },
    ];

    return Column(
      children: options.map((opt) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: GestureDetector(
            onTap: opt['onTap'] as VoidCallback,
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: const Color(0xFFEDE7F2),
                  width: 1.0,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: opt['color'] as Color,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      opt['icon'] as IconData,
                      size: 18.0,
                      color: AppColors.deepInk,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opt['title'] as String,
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
                          opt['subtitle'] as String,
                          style: const TextStyle(
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
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.roomCardSubtext,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEditProfilePill(BuildContext context) {
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
        child: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.pureWhite,
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
