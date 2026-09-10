import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/navigation/tab_navigation_service.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_complete_model.dart';
import '../viewmodels/lab_complete_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'profile_view.dart';

class LabCompleteView extends StatelessWidget {
  final bool isRootTab;

  const LabCompleteView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LabCompleteViewModel>(
      create: (_) => LabCompleteViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.peachBackground,
        drawer: const CustomDrawer(),
        body: Consumer<LabCompleteViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final data = viewModel.completionData;

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
                          _buildHeroCelebration(data),
                          const SizedBox(height: 20.0),
                          _buildScoreHighlightsCard(data),
                          const SizedBox(height: 20.0),
                          _buildStagesRecapCard(data),
                          const SizedBox(height: 20.0),
                          _buildCredentialCard(context, viewModel, data),
                          const SizedBox(height: 20.0),
                          _buildNextSprintCard(context, data),
                          const SizedBox(height: 24.0),
                          _buildActionButtons(context),
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
                currentIndex: 1,
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
                  Icons.close_rounded,
                  color: AppColors.deepInk,
                  size: 18.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
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
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Lab completion link copied to clipboard!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
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
              Icons.share_outlined,
              color: AppColors.deepInk,
              size: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCelebration(LabCompleteModel data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        children: [
          Container(
            width: 72.0,
            height: 72.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFEF3C7),
                  Color(0xFFFDE68A),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD97706).withValues(alpha: 0.25),
                  blurRadius: 20.0,
                  offset: const Offset(0, 8.0),
                ),
              ],
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: Color(0xFFD97706),
              size: 40.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'LAB COMPLETE • 100% MASTERY',
              style: TextStyle(
                color: Color(0xFF059669),
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            data.labTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              color: AppColors.deepInk,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'You have successfully conquered all 4 stages of experiential builder learning.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreHighlightsCard(LabCompleteModel data) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricTile(
            label: 'EXPERIENCE',
            value: '+${data.xpEarned} XP',
            color: const Color(0xFFD97706),
            bgColor: const Color(0xFFFFFBEB),
            icon: Icons.bolt_rounded,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildMetricTile(
            label: 'FLUENCY GAIN',
            value: '+${data.fluencyGain}',
            color: const Color(0xFF7C3AED),
            bgColor: const Color(0xFFF5F3FF),
            icon: Icons.auto_graph_rounded,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildMetricTile(
            label: 'STAGES DONE',
            value: '4 / 4',
            color: const Color(0xFF059669),
            bgColor: const Color(0xFFECFDF5),
            icon: Icons.check_circle_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required Color color,
    required Color bgColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.0),
          const SizedBox(height: 6.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStagesRecapCard(LabCompleteModel data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '4-STAGE LEARNING SPRINT COMPLETED',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14.0),
          ...data.stages.map((stage) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF059669),
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Stage ${stage.stageNumber}: ${stage.title}',
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.deepInk,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          stage.summary,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCredentialCard(
    BuildContext context,
    LabCompleteViewModel viewModel,
    LabCompleteModel data,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1E1E).withValues(alpha: 0.25),
            blurRadius: 20.0,
            offset: const Offset(0, 8.0),
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
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'VERIFIED CREDENTIAL ISSUED',
                  style: TextStyle(
                    color: Color(0xFFFDE68A),
                    fontSize: 9.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const Icon(
                Icons.verified_rounded,
                color: Color(0xFFF59E0B),
                size: 20.0,
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            data.credentialName,
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'ID: ${data.credentialId}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                '•',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
              const SizedBox(width: 8.0),
              Text(
                data.issuedDate,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              viewModel.toggleSaveCredential();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(viewModel.isCredentialSaved
                      ? 'Credential verified & pinned to your Builder Profile!'
                      : 'Credential unpinned.'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              decoration: BoxDecoration(
                color: viewModel.isCredentialSaved
                    ? const Color(0xFF059669)
                    : const Color(0xFF2E2E2A),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    viewModel.isCredentialSaved
                        ? Icons.check_circle_rounded
                        : Icons.badge_outlined,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    viewModel.isCredentialSaved
                        ? 'Pinned to Profile ✓'
                        : 'Pin Credential to Builder Profile',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextSprintCard(BuildContext context, LabCompleteModel data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Color(0xFF6366F1),
                  size: 16.0,
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                'RECOMMENDED NEXT SPRINT',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            data.nextLabTitle,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: AppColors.deepInk,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            data.nextLabSubtitle,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              TabNavigationService.switchToTab(context, 1);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Explore Next Sprint →',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            TabNavigationService.switchToTab(context, 1);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: AppColors.deepInk,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.deepInk.withValues(alpha: 0.22),
                  blurRadius: 18.0,
                  offset: const Offset(0, 6.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Back to Labs Overview',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            TabNavigationService.switchToTab(context, 3);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: AppColors.pastelLavender,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: AppColors.buttonShadow,
            ),
            alignment: Alignment.center,
            child: const Text(
              'View in My Builds',
              style: TextStyle(
                color: AppColors.pastelLavenderText,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileView()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.2,
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'View My Builder Profile',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
