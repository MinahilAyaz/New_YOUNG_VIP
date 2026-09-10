import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'edit_profile_view.dart';
import 'my_builds_view.dart';

class ProfileView extends StatefulWidget {
  final bool isRootTab;

  const ProfileView({
    super.key,
    this.isRootTab = false,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isBuildsExpanded = true;

  final List<Map<String, dynamic>> _profileCards = [
    {
      'type': 'builder_badge',
      'label': 'VIP BUILDER ID',
      'number': '••••  •••  003',
      'amount': 'Level 14',
      'exp': 'Exp 12/2026',
    },
    {
      'type': 'pass_tier',
      'label': 'CREDIT PASS',
      'number': '••••  •••  003',
      'amount': '2,569 pts',
      'exp': 'Tier: Platinum',
    },
    {
      'type': 'fluency_cert',
      'label': 'MASTERY SCORE',
      'number': '••••  •••  779',
      'amount': '98% Fluency',
      'exp': 'Legal AI Track',
    },
  ];

  final List<Map<String, dynamic>> _recentBuildsList = [
    {
      'title': 'Legal AI Document Synthesizer',
      'subtitle': 'Completed Stage 4 in Sandbox Lab',
      'status': 'Mastered',
      'icon': Icons.gavel_rounded,
      'iconColor': const Color(0xFF9C6FE4),
      'bgColor': const Color(0xFFF3EAFE),
    },
    {
      'title': 'Peer Code Review Sprint',
      'subtitle': 'Collaborated with Alex & Sarah in Room 4',
      'status': '+200 XP',
      'icon': Icons.forum_rounded,
      'iconColor': const Color(0xFFE57373),
      'bgColor': const Color(0xFFFFF0ED),
    },
    {
      'title': 'Prompt Security Validator',
      'subtitle': 'Automated vulnerability scan workflow',
      'status': '+150 XP',
      'icon': Icons.security_rounded,
      'iconColor': const Color(0xFF9C6FE4),
      'bgColor': const Color(0xFFF3EAFE),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 24.0 : screenWidth * 0.055;

    return Scaffold(
      backgroundColor: AppColors.peachBackground,
      drawer: const CustomDrawer(),
      body: SafeArea(
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
                    const SizedBox(height: 20.0),
                    _buildHeading(context),
                    const SizedBox(height: 22.0),
                    _buildCardsCarousel(),
                    const SizedBox(height: 24.0),
                    _buildBuildsContainer(context),
                    const SizedBox(height: 20.0),
                    _buildQuickPayBar(context),
                    const SizedBox(height: 88.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.isRootTab
          ? null
          : const CustomBottomNavBar(
              currentIndex: 3,
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
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: AppColors.buttonShadow,
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.deepInk,
                    size: 20.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                const YoungVipWordmark(),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
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
                    size: 20.0,
                  ),
                  Positioned(
                    top: 9.0,
                    right: 9.0,
                    child: Container(
                      width: 7.0,
                      height: 7.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: AppColors.buttonShadow,
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.deepInk,
                size: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Profile',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Hi, good morning',
              style: TextStyle(
                color: Color(0xFF8E8D88),
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Alex Verma · Legal Professional',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileView()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: AppColors.deepInk,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardsCarousel() {
    return SizedBox(
      height: 190.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: _profileCards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16.0),
        itemBuilder: (context, index) {
          final card = _profileCards[index];
          final bool isBadge = card['type'] == 'builder_badge';
          final bool isPass = card['type'] == 'pass_tier';

          return Container(
            width: 175.0,
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header Logo / Icon
                if (isBadge)
                  SizedBox(
                    height: 28.0,
                    child: Stack(
                      children: [
                        Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF9A8A8),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          left: 14.0,
                          child: Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC7B1E6).withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else if (isPass)
                  const Text(
                    'VIP PASS',
                    style: TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else
                  const Text(
                    'YOUNG VIP',
                    style: TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),

                // Masked Number
                Text(
                  card['number'] as String,
                  style: const TextStyle(
                    color: Color(0xFF9E9D96),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),

                // Metric and Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card['amount'] as String,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      card['exp'] as String,
                      style: const TextStyle(
                        color: Color(0xFF9E9D96),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBuildsContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isBuildsExpanded = !_isBuildsExpanded;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Recent Builds',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  _isBuildsExpanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: AppColors.deepInk,
                  size: 22.0,
                ),
              ],
            ),
          ),
          if (_isBuildsExpanded) ...[
            const SizedBox(height: 18.0),
            Column(
              children: _recentBuildsList.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD49B85).withValues(alpha: 0.08),
                        blurRadius: 10.0,
                        offset: const Offset(0, 3.0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42.0,
                        height: 42.0,
                        decoration: BoxDecoration(
                          color: item['bgColor'] as Color,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: item['iconColor'] as Color,
                          size: 20.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                color: AppColors.deepInk,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              item['subtitle'] as String,
                              style: const TextStyle(
                                color: Color(0xFF8E8D88),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: AppColors.peachBackground.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          item['status'] as String,
                          style: const TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickPayBar(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileView()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            decoration: BoxDecoration(
              color: AppColors.pastelPeach,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: AppColors.buttonShadow,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.edit_outlined, color: AppColors.deepInk, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'EDIT PROFILE',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyBuildsView()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: AppColors.softShadow,
            ),
            alignment: Alignment.center,
            child: const Text(
              'VIEW ALL BUILDS & CERTS',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
