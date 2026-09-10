import 'package:flutter/material.dart';

import '../core/navigation/tab_navigation_service.dart';
import '../core/theme/app_colors.dart';
import '../views/admin_dashboard_view.dart';
import '../views/advise_better_view.dart';
import '../views/all_access_pricing_view.dart';
import '../views/break_it_view.dart';
import '../views/build_it_view.dart';
import '../views/contextual_connection_view.dart';
import '../views/edit_profile_view.dart';
import '../views/expert_studio_view.dart';
import '../views/lab_complete_view.dart';
import '../views/premium_lab_view.dart';
import '../views/premium_locked_gate_view.dart';
import '../views/profile_view.dart';
import '../views/review_experts_view.dart';
import '../views/understand_it_view.dart';
import 'custom_card.dart';
import 'young_vip_wordmark.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.peachBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 8.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20.0),
              _buildUserProfileCard(context),
              const SizedBox(height: 18.0),
              // SECTION 1: CORE PLATFORM
              _buildSectionLabel('CORE PLATFORM'),
              const SizedBox(height: 6.0),

              _buildDrawerItem(
                context: context,
                icon: Icons.explore_rounded,
                title: 'Discover',
                subtitle: 'Explore labs, trends & activities',
                onTap: () {
                  Navigator.pop(context);
                  TabNavigationService.switchToTab(context, 0);
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.science_rounded,
                title: 'Labs',
                subtitle: 'Interactive domains & active sprint',
                onTap: () {
                  Navigator.pop(context);
                  TabNavigationService.switchToTab(context, 1);
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.groups_rounded,
                title: 'Rooms',
                subtitle: 'Live observations & weekly sprint',
                onTap: () {
                  Navigator.pop(context);
                  TabNavigationService.switchToTab(context, 2);
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.construction_rounded,
                title: 'Builds',
                subtitle: 'My configured labs & architectures',
                onTap: () {
                  Navigator.pop(context);
                  TabNavigationService.switchToTab(context, 3);
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.trending_up_rounded,
                title: 'Fluency',
                subtitle: 'Skill matrix & competency progress',
                onTap: () {
                  Navigator.pop(context);
                  TabNavigationService.switchToTab(context, 4);
                },
              ),
              const SizedBox(height: 12.0),

              // SECTION 2: ADMIN & GOVERNANCE (Prominent placement right after Core Platform)
              _buildSectionLabel('ADMIN & GOVERNANCE', badge: 'CONSOLE'),
              const SizedBox(height: 6.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.how_to_reg_outlined,
                title: 'Review Experts',
                subtitle: 'Approve or reject creator applications',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ReviewExpertsView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.dashboard_customize_outlined,
                title: 'Admin Dashboard',
                subtitle: 'Overview stats — members, labs, revenue',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AdminDashboardView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.auto_stories_outlined,
                title: 'Expert Studio',
                subtitle: 'Author, stress-test & publish labs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ExpertStudioView()),
                  );
                },
              ),
              const SizedBox(height: 12.0),

              // SECTION 3: LAB WORKFLOW (5 STAGES)
              _buildSectionLabel('LAB WORKFLOW (5 STAGES)'),
              const SizedBox(height: 6.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.construction_rounded,
                title: 'Build It',
                subtitle: 'Step 1 in lab workflow — build & configure',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BuildItView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.bug_report_outlined,
                title: 'Break It',
                subtitle: 'Step 2 in lab workflow — vulnerability exploit',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BreakItView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.psychology_rounded,
                title: 'Understand It',
                subtitle: 'Step 3 in lab workflow — root cause forensics',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const UnderstandItView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.record_voice_over_rounded,
                title: 'Advise Better',
                subtitle: 'Step 4 in lab workflow — client advisory',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AdviseBetterView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.hub_outlined,
                title: 'Contextual Connection',
                subtitle: 'Step 5 in lab workflow — systemic knowledge',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ContextualConnectionView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.emoji_events_outlined,
                title: 'Lab Complete',
                subtitle: 'Completion screen, XP & credentials',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LabCompleteView()),
                  );
                },
              ),
              const SizedBox(height: 12.0),

              // SECTION 4: MEMBERSHIP & VIP ACCESS
              _buildSectionLabel('MEMBERSHIP & ACCESS'),
              const SizedBox(height: 6.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.sell_outlined,
                title: 'All-Access Pricing',
                subtitle: '\$19/mo or \$149/yr subscription plans',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AllAccessPricingView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.lock_outline_rounded,
                title: 'Premium Locked Gate',
                subtitle: 'Paywall, all-access passes & VIP perks',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PremiumLockedGateView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.workspace_premium_rounded,
                title: 'VIP Pass',
                subtitle: 'All-access passes & membership',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PremiumLabView()),
                  );
                },
              ),
              const SizedBox(height: 12.0),

              // SECTION 5: ACCOUNT
              _buildSectionLabel('ACCOUNT'),
              const SizedBox(height: 6.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.person_outline_rounded,
                title: 'Profile',
                subtitle: 'Builder cards & credentials',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProfileView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.edit_outlined,
                title: 'Edit Profile',
                subtitle: 'Personal info & specializations',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileView()),
                  );
                },
              ),
              const SizedBox(height: 28.0),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const YoungVipWordmark(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Icon(
              Icons.close_rounded,
              color: AppColors.deepInk,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfileCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileView()),
        );
      },
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: AppColors.pastelLilac,
                borderRadius: BorderRadius.circular(14.0),
              ),
              alignment: Alignment.center,
              child: const Text(
                'AV',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alex Verma',
                    style: TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  const Text(
                    'Legal Professional & AI Architect',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.5,
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
                      color: AppColors.pastelPeach.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Fluency: Builder · Level 14',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.deepInk,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title, {String? badge}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: const Color(0xFFFDE68A),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Color(0xFFB45309),
                    fontSize: 9.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.bananiInk.withValues(alpha: 0.04),
              blurRadius: 10.0,
              offset: const Offset(0, 3.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: AppColors.bananiLavender,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                icon,
                color: AppColors.bananiPrimary,
                size: 20.0,
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
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.deepInk,
              size: 13.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text(
        'YOUNG VIP · Experiential Labs Suite',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
