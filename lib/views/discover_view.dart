import 'package:flutter/material.dart';
import '../core/navigation/tab_navigation_service.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/yv_header.dart';
import '../widgets/yv_lab_row.dart';
import '../widgets/yv_room_post.dart';
import 'advise_better_view.dart';
import 'break_it_view.dart';
import 'build_it_view.dart';
import 'lab_room_view.dart';
import 'peers_view.dart';
import 'premium_locked_gate_view.dart';
import 'profile_view.dart';
import 'understand_it_view.dart';

class DiscoverView extends StatefulWidget {
  final bool isRootTab;

  const DiscoverView({
    super.key,
    this.isRootTab = false,
  });

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _connectedUsers = {};
  String? _selectedTopic;

  final List<String> _topicPills = [
    'Cybersecurity',
    'Automation',
    'Privacy & Data Flows',
    'Digital Identity',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleConnect(String userName) {
    setState(() {
      if (_connectedUsers.contains(userName)) {
        _connectedUsers.remove(userName);
      } else {
        _connectedUsers.add(userName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 24.0 : screenWidth * 0.055;

    return Scaffold(
      backgroundColor: AppColors.bananiBackground,
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
                    // 1. Header (YVHeader matching @components/YVHeader.jsx)
                    Builder(
                      builder: (ctx) => YVHeader(
                        onOpenDrawer: () => Scaffold.of(ctx).openDrawer(),
                        onNotificationTap: () => _showNotificationSheet(context),
                        onAvatarTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ProfileView()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18.0),

                    // 2. Hero & Search Section
                    _buildHeroSection(context),
                    const SizedBox(height: 28.0),

                    // 3. Continue Lab Card (Dark obsidian card with 4-stage progress)
                    _buildContinueLabSection(context),
                    const SizedBox(height: 32.0),

                    // 4. Recommended Labs (Featured Big Card + 2 Lab Rows)
                    _buildRecommendedLabsSection(context),
                    const SizedBox(height: 32.0),

                    // 5. Explore Technology (2x2 Grid + Filter Chips)
                    _buildExploreTechnologySection(context),
                    const SizedBox(height: 32.0),

                    // 6. Who else is building this? (Overlapping avatars + Connect rows)
                    _buildPeersSection(context),
                    const SizedBox(height: 32.0),

                    // 7. Lab Room Activity (Posts + All Access Membership Banner)
                    _buildLabRoomActivitySection(context),
                    const SizedBox(height: 88.0), // Spacing for floating dock
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
              currentIndex: 0,
            ),
    );
  }

  // ==========================================
  // 2. HERO & SEARCH SECTION
  // ==========================================
  Widget _buildHeroSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subtitle badge with gold bar
        Row(
          children: [
            Container(
              width: 36.0,
              height: 2.0,
              decoration: BoxDecoration(
                color: AppColors.bananiAccent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 10.0),
            const Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'THE TECHNOLOGY LAB FOR LAWYERS',
                  style: TextStyle(
                    color: AppColors.bananiSlate,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),

        // Hero Title
        const Text(
          'What do you want to understand today?',
          style: TextStyle(
            color: AppColors.bananiInk,
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10.0),

        // Hero Tagline
        const Text(
          'Build it. Break it. Understand it. Advise better.',
          style: TextStyle(
            color: AppColors.bananiSlate,
            fontSize: 15.5,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18.0),

        // Search Bar Card
        CustomCard(
          backgroundColor: AppColors.bananiCard,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.bananiBorder,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.bananiInk.withValues(alpha: 0.07),
              blurRadius: 32.0,
              offset: const Offset(0, 12.0),
              spreadRadius: 0,
            ),
          ],
          padding: const EdgeInsets.fromLTRB(14.0, 6.0, 8.0, 6.0),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                color: AppColors.bananiSlate,
                size: 20.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(
                    color: AppColors.bananiInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search Labs, technologies, topics…',
                    hintStyle: TextStyle(
                      color: AppColors.bananiSlate,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  TabNavigationService.switchToTab(context, 1); // Switch to Labs
                },
                child: Container(
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.bananiLavender,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: AppColors.bananiPrimary,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
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

  // ==========================================
  // 3. CONTINUE LAB SECTION (Dark Obsidian Card)
  // ==========================================
  Widget _buildContinueLabSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Continue Lab',
                style: TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                TabNavigationService.switchToTab(context, 1);
              },
              child: const Text(
                'All activity',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),

        // Dark Ink Card with Ambient Deco
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.bananiInk,
            ),
            child: Stack(
              children: [
                // Ambient Glow Circle
                Positioned(
                  top: -40.0,
                  right: -40.0,
                  child: Container(
                    width: 176.0,
                    height: 176.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bananiPrimary.withValues(alpha: 0.25),
                    ),
                  ),
                ),
                // Amber accent vertical line
                Positioned(
                  top: 36.0,
                  right: 32.0,
                  child: Container(
                    width: 1.5,
                    height: 64.0,
                    color: AppColors.bananiAccent.withValues(alpha: 0.7),
                  ),
                ),

                // Card Content
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Row: "02 · BREAK IT" + Category
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Text(
                              '02 · BREAK IT',
                              style: TextStyle(
                                color: AppColors.bananiCoral,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Text(
                            'RAG / Knowledge',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),

                      // Lab Title
                      const Text(
                        'Hallucinations on Record',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Lab Subtitle / Instruction
                      Text(
                        'You built the pipeline. Now remove the source filter and watch it confidently fail.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 18.0),

                      // 4-Bar Segmented Progress Indicator
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5.5,
                              decoration: BoxDecoration(
                                color: AppColors.bananiSuccess,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Container(
                              height: 5.5,
                              decoration: BoxDecoration(
                                color: AppColors.bananiCoral,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Container(
                              height: 5.5,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Container(
                              height: 5.5,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),

                      // Progress Label & Percentage
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Build done · Break in progress',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.55),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          const Text(
                            '48%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),

                      // Continue Lab Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BreakItView(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bananiPrimary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Continue Lab',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 4. RECOMMENDED LABS (Featured + Rows)
  // ==========================================
  Widget _buildRecommendedLabsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Recommended Labs',
                style: TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                TabNavigationService.switchToTab(context, 1);
              },
              child: const Text(
                'View all',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Hands-on experiences, not lectures. Pick one and start building.',
          style: TextStyle(
            color: AppColors.bananiSlate,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16.0),

        // Featured Big Card: "When Agents Act Without You"
        _buildFeaturedLabCard(context),
        const SizedBox(height: 16.0),

        // Lab Row 1: Hallucinations on Record
        YVLabRow(
          imageUrl:
              'https://storage.googleapis.com/banani-generated-images/generated-images/8e61209b-5eca-4613-bd1c-c35252a0e38c.jpg',
          category: 'RAG / Knowledge',
          tierText: 'Free',
          isPremium: false,
          title: 'Hallucinations on Record',
          level: 'Beginner',
          duration: '35 min',
          buildersCount: '412',
          onStartLab: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuildItView()),
            );
          },
        ),
        const SizedBox(height: 14.0),

        // Lab Row 2: The Face as Evidence
        YVLabRow(
          imageUrl:
              'https://storage.googleapis.com/banani-generated-images/generated-images/13f8900c-d2e2-4244-85f3-594bb4e16edb.jpg',
          category: 'Biometrics',
          tierText: 'Premium',
          isPremium: true,
          title: 'The Face as Evidence',
          level: 'Advanced',
          duration: '55 min',
          buildersCount: '264',
          onStartLab: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PremiumLockedGateView(
                  contentTitle: 'The Face as Evidence: Neural Forensics',
                  category: 'Biometrics & AI Ethics',
                  level: 'Advanced Architecture',
                  duration: '55 min',
                  buildersCount: '264 active builders',
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedLabCard(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.bananiCard,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: AppColors.bananiBorder,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.bananiInk.withValues(alpha: 0.07),
          blurRadius: 32.0,
          offset: const Offset(0, 12.0),
          spreadRadius: 0,
        ),
      ],
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 16:9 Image with Floating Badge
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    'https://storage.googleapis.com/banani-generated-images/generated-images/8dce4596-317c-4bfe-bfb8-6856e9551e6e.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.bananiLavender,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.precision_manufacturing_rounded,
                          color: AppColors.bananiPrimary,
                          size: 48.0,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 14.0,
                  left: 14.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2.0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.0,
                          height: 6.0,
                          decoration: const BoxDecoration(
                            color: AppColors.bananiAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6.5),
                        const Text(
                          'AI Agents · Intermediate',
                          style: TextStyle(
                            color: AppColors.bananiInk,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags: Premium Lab & Live Builders
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.workspace_premium_rounded,
                            color: AppColors.bananiAccent,
                            size: 14.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Premium Lab',
                            style: TextStyle(
                              color: AppColors.bananiAccent,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDotSeparator(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.people_outline_rounded,
                            color: AppColors.bananiSlate,
                            size: 14.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '318 building now',
                            style: TextStyle(
                              color: AppColors.bananiSlate,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Title
                const Text(
                  'When Agents Act Without You',
                  style: TextStyle(
                    color: AppColors.bananiInk,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8.0),

                // Description
                const Text(
                  'Give an agent real tools, let it overstep its mandate, then trace where liability actually lands.',
                  style: TextStyle(
                    color: AppColors.bananiSlate,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18.0),

                // LAB PLAYER · 4 STAGES Inner Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.bananiBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: AppColors.bananiBorder,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LAB PLAYER · 4 STAGES',
                        style: TextStyle(
                          color: AppColors.bananiSlate,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12.0),

                      // Stage 1: Build it (Done) -> tap opens BuildItView
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BuildItView(),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: const BoxDecoration(
                                color: AppColors.bananiSuccess,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 14.0,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            const Expanded(
                              child: Text(
                                'Build it',
                                style: TextStyle(
                                  color: AppColors.bananiInk,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Text(
                              'Done',
                              style: TextStyle(
                                color: AppColors.bananiSuccess,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // Stage 2: Break it (Next - Coral soft highlighted) -> tap opens BreakItView
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
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.bananiCoralSoft,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color:
                                  AppColors.bananiCoral.withValues(alpha: 0.25),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.bananiCoral,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '2',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              const Expanded(
                                child: Text(
                                  'Break it',
                                  style: TextStyle(
                                    color: AppColors.bananiInk,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Text(
                                'Next',
                                style: TextStyle(
                                  color: AppColors.bananiCoral,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // Stage 3: Understand it (12 min) -> tap opens UnderstandItView
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const UnderstandItView(),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.bananiBorder,
                                  width: 1.2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: AppColors.bananiSlate,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            const Expanded(
                              child: Text(
                                'Understand it',
                                style: TextStyle(
                                  color: AppColors.bananiSlate,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Text(
                              '12 min',
                              style: TextStyle(
                                color: AppColors.bananiSlate,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // Stage 4: Advise better (11 min) -> tap opens AdviseBetterView
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdviseBetterView(),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.bananiBorder,
                                  width: 1.2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '4',
                                style: TextStyle(
                                  color: AppColors.bananiSlate,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            const Expanded(
                              child: Text(
                                'Advise better',
                                style: TextStyle(
                                  color: AppColors.bananiSlate,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Text(
                              '11 min',
                              style: TextStyle(
                                color: AppColors.bananiSlate,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),

                // Meta Info: Duration & Activities
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.schedule_rounded,
                            color: AppColors.bananiSlate,
                            size: 14.0,
                          ),
                          SizedBox(width: 4.5),
                          Text(
                            '45 min total',
                            style: TextStyle(
                              color: AppColors.bananiSlate,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDotSeparator(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.science_outlined,
                            color: AppColors.bananiSlate,
                            size: 14.0,
                          ),
                          SizedBox(width: 4.5),
                          Text(
                            '3 practical activities',
                            style: TextStyle(
                              color: AppColors.bananiSlate,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),

                // Action 1: Start Lab Button (Primary)
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BuildItView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bananiPrimary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Start Lab',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),

                // Action 2: Preview Lab Room Button (Outlined)
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LabRoomView(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.bananiPrimary.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Preview Lab Room',
                      style: TextStyle(
                        color: AppColors.bananiPrimary,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 5. EXPLORE TECHNOLOGY SECTION (2x2 Grid + Chips)
  // ==========================================
  Widget _buildExploreTechnologySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Explore technology',
                style: TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                TabNavigationService.switchToTab(context, 1);
              },
              child: const Text(
                'All topics',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // 2x2 Grid of Tech Cards
        Row(
          children: [
            Expanded(
              child: _buildTechCard(
                title: 'AI Agents',
                meta: '6 Labs · 1.2k builders',
                icon: Icons.smart_toy_outlined,
                isFeatured: true,
                onTap: () {
                  TabNavigationService.switchToTab(context, 1);
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _buildTechCard(
                title: 'RAG / Knowledge',
                meta: '4 Labs · 980 builders',
                icon: Icons.storage_rounded,
                isFeatured: false,
                onTap: () {
                  TabNavigationService.switchToTab(context, 1);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildTechCard(
                title: 'Biometrics',
                meta: '3 Labs · 640 builders',
                icon: Icons.fingerprint_rounded,
                isFeatured: false,
                onTap: () {
                  TabNavigationService.switchToTab(context, 1);
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _buildTechCard(
                title: 'AI Governance',
                meta: '5 Labs · 830 builders',
                icon: Icons.shield_outlined,
                isFeatured: false,
                onTap: () {
                  TabNavigationService.switchToTab(context, 1);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),

        // Filter Pills: Cybersecurity, Automation, etc.
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _topicPills.map((topic) {
            final bool isSelected = _selectedTopic == topic;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTopic = isSelected ? null : topic;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 9.0,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.bananiLavender
                      : AppColors.bananiCard,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.bananiPrimary
                        : AppColors.bananiBorder,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  topic,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.bananiPrimary
                        : AppColors.bananiSlate,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTechCard({
    required String title,
    required String meta,
    required IconData icon,
    required bool isFeatured,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        backgroundColor: AppColors.bananiCard,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: isFeatured
              ? AppColors.bananiPrimary.withValues(alpha: 0.3)
              : AppColors.bananiBorder,
          width: 1.0,
        ),
        boxShadow: isFeatured
            ? [
                BoxShadow(
                  color: AppColors.bananiInk.withValues(alpha: 0.07),
                  blurRadius: 32.0,
                  offset: const Offset(0, 12.0),
                ),
              ]
            : null,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: isFeatured
                    ? AppColors.bananiLavender
                    : AppColors.bananiBackground,
                borderRadius: BorderRadius.circular(8.0),
                border: isFeatured
                    ? null
                    : Border.all(
                        color: AppColors.bananiBorder,
                        width: 1.0,
                      ),
              ),
              child: Icon(
                icon,
                color: isFeatured
                    ? AppColors.bananiPrimary
                    : AppColors.bananiInk,
                size: 20.0,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.bananiInk,
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              meta,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.bananiSlate,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 6. WHO ELSE IS BUILDING THIS? SECTION
  // ==========================================
  Widget _buildPeersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Who else is building this?',
                style: TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PeersView()),
                );
              },
              child: const Text(
                'View all peers',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          '318 professionals are working on this Lab right now.',
          style: TextStyle(
            color: AppColors.bananiSlate,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16.0),

        CustomCard(
          backgroundColor: AppColors.bananiCard,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.bananiBorder,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.bananiInk.withValues(alpha: 0.07),
              blurRadius: 32.0,
              offset: const Offset(0, 12.0),
              spreadRadius: 0,
            ),
          ],
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overlapping Avatar Stack
              _buildAvatarStack(),
              const SizedBox(height: 20.0),

              // Divider
              Container(
                height: 1.0,
                color: AppColors.bananiBorder,
              ),
              const SizedBox(height: 18.0),

              // Peer 1: Maya Okafor
              _buildPeerRow(
                name: 'Maya Okafor',
                role: 'Data Protection Associate · Privacy',
                avatarUrl:
                    'https://storage.googleapis.com/banani-avatars/avatar/female/25-35/African/1',
              ),
              const SizedBox(height: 16.0),

              // Peer 2: Daniel Reyes
              _buildPeerRow(
                name: 'Daniel Reyes',
                role: 'Litigation Counsel · Agents',
                avatarUrl:
                    'https://storage.googleapis.com/banani-avatars/avatar/male/35-50/European/8',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    final List<String> avatars = [
      'https://storage.googleapis.com/banani-avatars/avatar/male/25-35/Middle Eastern/1',
      'https://storage.googleapis.com/banani-avatars/avatar/female/25-35/Hispanic/4',
      'https://storage.googleapis.com/banani-avatars/avatar/male/35-50/European/6',
      'https://storage.googleapis.com/banani-avatars/avatar/female/25-35/East Asian/7',
    ];

    return SizedBox(
      height: 40.0,
      child: Stack(
        children: [
          for (int i = 0; i < avatars.length; i++)
            Positioned(
              left: i * 28.0,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    avatars[i],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.bananiLavender,
                    ),
                  ),
                ),
              ),
            ),
          // Counter pill: +314
          Positioned(
            left: avatars.length * 28.0,
            child: Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              decoration: BoxDecoration(
                color: AppColors.bananiInk,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                '+314',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeerRow({
    required String name,
    required String role,
    required String avatarUrl,
  }) {
    final bool isConnected = _connectedUsers.contains(name);

    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 44.0,
            height: 44.0,
            color: AppColors.bananiLavender,
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.bananiLavender,
                alignment: Alignment.center,
                child: Text(
                  name.isNotEmpty ? name[0] : 'U',
                  style: const TextStyle(
                    color: AppColors.bananiPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                role,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.bananiSlate,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _toggleConnect(name),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 40.0,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: isConnected
                  ? AppColors.bananiSuccessSoft
                  : AppColors.bananiLavender,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              isConnected ? 'Connected' : 'Connect',
              style: TextStyle(
                color: isConnected
                    ? AppColors.bananiSuccess
                    : AppColors.bananiPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 7. LAB ROOM ACTIVITY SECTION + ALL ACCESS BANNER
  // ==========================================
  Widget _buildLabRoomActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Lab Room activity',
                style: TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LabRoomView()),
                );
              },
              child: const Text(
                'Open Room',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),

        // Room Post 1: Maya Okafor
        YVRoomPost(
          authorName: 'Maya Okafor',
          authorRole: 'Data Protection Associate',
          avatarUrl:
              'https://storage.googleapis.com/banani-avatars/avatar/female/25-35/African/1',
          badgeText: 'Failure',
          isFailureBadge: true,
          content:
              'Broke the RAG lab on purpose — removed the source filter and it cited a clause that never existed.',
          contextInfo: 'Hallucinations on Record • 12m',
          commentsCount: 24,
          initialLikesCount: 14,
        ),
        const SizedBox(height: 14.0),

        // Room Post 2: Daniel Reyes
        YVRoomPost(
          authorName: 'Daniel Reyes',
          authorRole: 'Litigation Counsel',
          avatarUrl:
              'https://storage.googleapis.com/banani-avatars/avatar/male/25-35/European/8',
          badgeText: 'Insight',
          isFailureBadge: false,
          content:
              'Advise Better prompt that stuck with me: what instruction would you put in writing before delegating to an agent?',
          contextInfo: 'When Agents Act Without You · 32m · 18 replies',
          commentsCount: 24,
          initialLikesCount: 19,
        ),
        const SizedBox(height: 16.0),

        // All Access Membership Banner: $19/mo
        CustomCard(
          backgroundColor: AppColors.bananiCard,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.bananiAccent.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.bananiInk.withValues(alpha: 0.07),
              blurRadius: 32.0,
              offset: const Offset(0, 12.0),
              spreadRadius: 0,
            ),
          ],
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: AppColors.bananiAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'All Access · \$19/mo',
                      style: TextStyle(
                        color: AppColors.bananiInk,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      'Unlock all Labs, failure scenarios & Fluency.',
                      style: TextStyle(
                        color: AppColors.bananiSlate,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PremiumLockedGateView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bananiInk,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(0, 46.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Get',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDotSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: 3.0,
        height: 3.0,
        decoration: const BoxDecoration(
          color: AppColors.bananiBorder,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _showNotificationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          color: AppColors.bananiCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.notifications_active_rounded,
                  color: AppColors.bananiAccent,
                  size: 22.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Lab Notifications',
                  style: TextStyle(
                    color: AppColors.bananiInk,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              '• Alex left an insight on "Hallucinations on Record"\n• 14 peers joined the "AI Agents" sprint\n• New failure benchmark released for Biometrics',
              style: TextStyle(
                color: AppColors.bananiSlate,
                fontSize: 14.0,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 46.0,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bananiPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Dismiss'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
