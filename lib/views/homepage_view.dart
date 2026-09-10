import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'create_account_view.dart';
import 'main_navigation_view.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : screenWidth * 0.055;

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
                vertical: 14.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPublicHeader(context),
                    const SizedBox(height: 24.0),
                    _buildHeroSection(context),
                    const SizedBox(height: 22.0),
                    _buildMetricsCard(),
                    const SizedBox(height: 26.0),
                    _buildSectionHeader('Why Builders Choose Young VIP'),
                    const SizedBox(height: 14.0),
                    _buildValueProps(),
                    const SizedBox(height: 26.0),
                    _buildSectionHeader('Explore Interactive Tracks'),
                    const SizedBox(height: 14.0),
                    _buildTracksCarousel(context),
                    const SizedBox(height: 26.0),
                    _buildHowItWorksCard(),
                    const SizedBox(height: 24.0),
                    _buildTestimonialCard(),
                    const SizedBox(height: 26.0),
                    _buildCallToActionCard(context),
                    const SizedBox(height: 20.0),
                    _buildFooter(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPublicHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainNavigationView()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: AppColors.buttonShadow,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Enter App',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 6.0),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.deepInk,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: AppColors.pastelPeach,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'AI EXPERIENTIAL LEARNING PLATFORM',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Understand AI\nby Building It',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 32.0,
              fontWeight: FontWeight.w900,
              height: 1.15,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Interactive sandboxes for modern builders, legal architects & enterprise innovators. No lectures, no boilerplate—pure hands-on fluency.',
            style: TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 13.5,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 22.0),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CreateAccountView()),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.pastelPeach,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: AppColors.buttonShadow,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Start Free',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MainNavigationView(initialIndex: 1)),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.peachBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: AppColors.deepInk.withValues(alpha: 0.15),
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Browse Labs',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricItem('40+', 'Interactive Labs'),
          _buildDivider(),
          _buildMetricItem('98%', 'Fluency Score'),
          _buildDivider(),
          _buildMetricItem('12k+', 'AI Builders'),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E8D88),
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1.0,
      height: 32.0,
      color: const Color(0x1AD59D88),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 16.5,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildValueProps() {
    final props = [
      {
        'title': 'Live Interactive Sandboxes',
        'desc': 'Test LLM function calling, multi-agent loops, and retrieval chains in secure real-time containers.',
        'icon': Icons.science_rounded,
        'color': AppColors.pastelPeach,
      },
      {
        'title': 'Real-Time Peer Code Rooms',
        'desc': 'Collaborate with other professionals, share architectural decisions, and review builds together.',
        'icon': Icons.forum_rounded,
        'color': AppColors.pastelLilac,
      },
      {
        'title': 'Verified Fluency Engine',
        'desc': 'Demonstrate quantifiable mastery with verifiable competency tiers and portfolio credentials.',
        'icon': Icons.workspace_premium_rounded,
        'color': AppColors.periwinkle,
      },
    ];

    return Column(
      children: props.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(22.0),
            boxShadow: AppColors.softShadow,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46.0,
                height: 46.0,
                decoration: BoxDecoration(
                  color: item['color'] as Color,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: AppColors.deepInk,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      item['desc'] as String,
                      style: const TextStyle(
                        color: Color(0xFF7A7972),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTracksCarousel(BuildContext context) {
    final tracks = [
      {
        'title': 'AI Agents &\nWorkflows',
        'labs': '14 Labs',
        'icon': Icons.bolt_rounded,
        'bgColor': AppColors.pastelPeach,
      },
      {
        'title': 'RAG & Vector\nPipelines',
        'labs': '12 Labs',
        'icon': Icons.lightbulb_rounded,
        'bgColor': AppColors.pastelLilac,
      },
      {
        'title': 'Security &\nSandboxes',
        'labs': '8 Labs',
        'icon': Icons.security_rounded,
        'bgColor': AppColors.periwinkle,
      },
      {
        'title': 'Autonomous\nAutomation',
        'labs': '6 Labs',
        'icon': Icons.settings_rounded,
        'bgColor': AppColors.blushPink,
      },
    ];

    return SizedBox(
      height: 195.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: tracks.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14.0),
        itemBuilder: (context, index) {
          final track = tracks[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const MainNavigationView(initialIndex: 1)),
              );
            },
            child: Container(
              width: 165.0,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: track['bgColor'] as Color,
                borderRadius: BorderRadius.circular(26.0),
                boxShadow: AppColors.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Icon(
                      track['icon'] as IconData,
                      color: AppColors.deepInk,
                      size: 20.0,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track['title'] as String,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        track['labs'] as String,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHowItWorksCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'HOW IT WORKS',
            style: TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildStepRow('01', 'Choose a Domain',
              'Select AI Agents, RAG Pipelines, or Prompt Security.'),
          const SizedBox(height: 14.0),
          _buildStepRow('02', 'Build, Break & Evaluate',
              'Experiment in live sandboxes with automated stress-testing.'),
          const SizedBox(height: 14.0),
          _buildStepRow('03', 'Master & Earn Recognition',
              'Advance your fluency score and showcase verified credentials.'),
        ],
      ),
    );
  }

  Widget _buildStepRow(String step, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34.0,
          height: 34.0,
          decoration: BoxDecoration(
            color: AppColors.peachBackground,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                desc,
                style: const TextStyle(
                  color: Color(0xFF7A7972),
                  fontSize: 12.0,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pastelLilac.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(26.0),
        border: Border.all(
          color: AppColors.pastelLilac.withValues(alpha: 0.7),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.format_quote_rounded, color: AppColors.deepInk, size: 28.0),
          SizedBox(height: 8.0),
          Text(
            '"Young VIP gave our legal tech team the hands-on intuition to deploy autonomous AI agents with security, rigor, and compliance."',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 13.5,
              height: 1.45,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Sarah Chen · Head of AI Architecture, Apex Legal',
            style: TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateAccountView()),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: AppColors.softShadow,
        ),
        child: Column(
          children: [
            const Text(
              'EXPLORE THE APP NOW',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 15.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Join thousands of verified builders & practitioners',
              style: TextStyle(
                color: Color(0xFF8E8D88),
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text(
        'YOUNG VIP · Experiential AI Platform · 2026',
        style: TextStyle(
          color: Color(0xFF8E8D88),
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
