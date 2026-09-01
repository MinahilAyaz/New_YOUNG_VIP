import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../views/expert_studio_view.dart';
import '../views/messages_view.dart';
import '../views/profile_view.dart';
import 'custom_card.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.warmIvory,
      surfaceTintColor: Colors.transparent,
      elevation: 8.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24.0),
              _buildUserProfileCard(context),
              const SizedBox(height: 28.0),
              const Padding(
                padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
                child: Text(
                  'NAVIGATION',
                  style: TextStyle(
                    color: AppColors.blueGray,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              _buildDrawerItem(
                context: context,
                icon: Icons.person_outline_rounded,
                title: 'Profile',
                subtitle: 'Personal stats & builds',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Messages',
                subtitle: 'Peer conversations & threads',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MessagesView()),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              _buildDrawerItem(
                context: context,
                icon: Icons.auto_awesome_outlined,
                title: 'Build Expert Studio',
                subtitle: 'Creator access & lab drafts',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ExpertStudioView()),
                  );
                },
              ),
              const Spacer(),
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
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              color: AppColors.porcelain,
              borderRadius: BorderRadius.circular(10.0),
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
              decoration: const BoxDecoration(
                color: AppColors.lightLavender,
                shape: BoxShape.circle,
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
                    'Legal Professional',
                    style: TextStyle(
                      color: AppColors.blueGray,
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
                      color: AppColors.youngVipGold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Fluency: Builder',
                      style: TextStyle(
                        color: AppColors.youngVipGold,
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
              color: AppColors.blueGray,
              size: 20.0,
            ),
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
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.porcelain,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: AppColors.lightLavender.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                icon,
                color: AppColors.royalIndigo,
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
                      color: AppColors.blueGray,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.royalIndigo,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text(
        'YOUNG VIP · Experiential Labs',
        style: TextStyle(
          color: AppColors.blueGray,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
