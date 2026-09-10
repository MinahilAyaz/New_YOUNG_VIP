import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'build_it_view.dart';

class PremiumLockedGateView extends StatefulWidget {
  final String contentTitle;
  final String category;
  final String level;
  final String duration;
  final String buildersCount;
  final String? imageUrl;

  const PremiumLockedGateView({
    super.key,
    this.contentTitle = 'The Face as Evidence: Forensic Biometrics',
    this.category = 'Biometrics & Neural Ethics',
    this.level = 'Advanced Architecture',
    this.duration = '55 min',
    this.buildersCount = '264 active builders',
    this.imageUrl,
  });

  @override
  State<PremiumLockedGateView> createState() => _PremiumLockedGateViewState();
}

class _PremiumLockedGateViewState extends State<PremiumLockedGateView> {
  int _selectedPlanIndex = 0; // 0: Annual (Best Value), 1: Monthly
  bool _isProcessing = false;

  Future<void> _handleUnlock() async {
    HapticFeedback.heavyImpact();
    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _isProcessing = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
          backgroundColor: AppColors.pureWhite,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF3C7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xFFD97706),
                    size: 36.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'VIP Access Activated!',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Your Young VIP Pass has unlocked "${widget.contentTitle}" and all 40+ interactive enterprise sandboxes.',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.0,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bananiSuccessSoft,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        size: 15.0,
                        color: Color(0xFF059669),
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        'Full Sandbox Sandbox Privileges Granted',
                        style: TextStyle(
                          color: Color(0xFF065F46),
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22.0),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogCtx);
                      Navigator.pushReplacement(
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
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Launch Lab Sandbox Now',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Icon(Icons.arrow_forward_rounded, size: 16.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : (screenWidth < 360 ? 14.0 : 20.0);

    return Scaffold(
      backgroundColor: AppColors.bananiBackground,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 18.0),
                  _buildLockedHeroCard(context),
                  const SizedBox(height: 20.0),
                  _buildWhyVipSection(),
                  const SizedBox(height: 22.0),
                  _buildPlanSelector(),
                  const SizedBox(height: 20.0),
                  _buildUnlockButton(context),
                  const SizedBox(height: 12.0),
                  _buildGuaranteeBanner(),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 540.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (canPop)
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 38.0,
                      height: 38.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: AppColors.buttonShadow,
                        border: Border.all(
                          color: AppColors.cardBorder,
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.deepInk,
                        size: 18.0,
                      ),
                    ),
                  )
                else
                  Builder(
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Scaffold.of(ctx).openDrawer();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 38.0,
                        height: 38.0,
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: AppColors.buttonShadow,
                          border: Border.all(
                            color: AppColors.cardBorder,
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.deepInk,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                const YoungVipWordmark(),
              ],
            ),
            // VIP Restricted Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFF59E0B),
                  width: 1.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_rounded,
                    size: 12.0,
                    color: Color(0xFFD97706),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'VIP ONLY',
                    style: TextStyle(
                      color: Color(0xFFB45309),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedHeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.bananiInk.withValues(alpha: 0.08),
            blurRadius: 24.0,
            offset: const Offset(0, 8.0),
          ),
        ],
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Locked Preview Banner with Glowing Padlock
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E1B4B), // Deep royal navy
                  Color(0xFF2E1065), // Rich dark purple
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(21.0),
                topRight: Radius.circular(21.0),
              ),
            ),
            child: Column(
              children: [
                // Glowing Lock Avatar
                Container(
                  width: 58.0,
                  height: 58.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF59E0B),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                        blurRadius: 18.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: Color(0xFFFBBF24),
                    size: 28.0,
                  ),
                ),
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Text(
                    'PREMIUM CONTENT GATEWAY',
                    style: TextStyle(
                      color: Color(0xFFFCD34D),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Exclusive Enterprise Architecture Lab',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'This track contains proprietary production workflows reserved for verified Young VIP members.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.0,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Content Metadata details
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bananiLavender,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        widget.category.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.bananiPrimary,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.workspace_premium_rounded,
                            size: 13.0,
                            color: Color(0xFFD97706),
                          ),
                          SizedBox(width: 3.0),
                          Text(
                            'VIP Pass Tier',
                            style: TextStyle(
                              color: Color(0xFFB45309),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.contentTitle,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 6.0,
                  children: [
                    _buildMetaChip(Icons.stairs_rounded, widget.level),
                    _buildMetaChip(Icons.timer_outlined, widget.duration),
                    _buildMetaChip(
                      Icons.people_outline_rounded,
                      widget.buildersCount,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: AppColors.textSecondary),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyVipSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: AppColors.softShadow,
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WHAT YOU UNLOCK WITH YOUNG VIP',
            style: TextStyle(
              color: AppColors.bananiPrimary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 14.0),
          _buildPerkRow(
            Icons.science_rounded,
            '40+ Interactive Sandboxes',
            'Full unrestricted access to multi-agent debate loops, RAG pipelines & prompt defense harnesses.',
          ),
          const SizedBox(height: 12.0),
          _buildPerkRow(
            Icons.forum_rounded,
            'Live Peer Review Breakout Rooms',
            'Pair-build with senior AI engineering fellows and receive verified feedback on your builds.',
          ),
          const SizedBox(height: 12.0),
          _buildPerkRow(
            Icons.verified_rounded,
            'Cryptographic Credentials & Benchmarks',
            'Earn verified fluency badges and architectural mastery scores for your resume & LinkedIn.',
          ),
          const SizedBox(height: 12.0),
          _buildPerkRow(
            Icons.bolt_rounded,
            'Dedicated Container Compute',
            'Zero wait times and prioritized GPU execution for all automated testing sandboxes.',
          ),
        ],
      ),
    );
  }

  Widget _buildPerkRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34.0,
          height: 34.0,
          decoration: BoxDecoration(
            color: AppColors.bananiLavender,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: AppColors.bananiPrimary, size: 18.0),
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
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlanSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'CHOOSE YOUR MEMBERSHIP TIER',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),

        // Plan 1: Annual (Best Value)
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _selectedPlanIndex = 0);
          },
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: _selectedPlanIndex == 0
                  ? AppColors.bananiLavender
                  : AppColors.pureWhite,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: _selectedPlanIndex == 0
                    ? AppColors.bananiPrimary
                    : AppColors.cardBorder,
                width: _selectedPlanIndex == 0 ? 2.0 : 1.0,
              ),
              boxShadow: _selectedPlanIndex == 0
                  ? [
                      BoxShadow(
                        color: AppColors.bananiPrimary.withValues(alpha: 0.15),
                        blurRadius: 10.0,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : AppColors.buttonShadow,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio
                Container(
                  width: 22.0,
                  height: 22.0,
                  margin: const EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedPlanIndex == 0
                          ? AppColors.bananiPrimary
                          : const Color(0xFFCBD5E1),
                      width: 2.0,
                    ),
                    color: _selectedPlanIndex == 0
                        ? AppColors.bananiPrimary
                        : Colors.transparent,
                  ),
                  child: _selectedPlanIndex == 0
                      ? const Icon(Icons.check, size: 14.0, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6.0,
                        runSpacing: 4.0,
                        children: [
                          const Text(
                            'All-Access VIP Annual',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: const Text(
                              'SAVE 35%',
                              style: TextStyle(
                                color: Color(0xFFB45309),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        '\$149 / year (\$12.42/month equivalent)',
                        style: TextStyle(
                          color: AppColors.bananiPrimary,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      const Text(
                        'Full 40+ labs, sprint breakout rooms, certifications & founder status',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10.0),

        // Plan 2: Monthly Builder Pass
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _selectedPlanIndex = 1);
          },
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: _selectedPlanIndex == 1
                  ? AppColors.bananiLavender
                  : AppColors.pureWhite,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: _selectedPlanIndex == 1
                    ? AppColors.bananiPrimary
                    : AppColors.cardBorder,
                width: _selectedPlanIndex == 1 ? 2.0 : 1.0,
              ),
              boxShadow: _selectedPlanIndex == 1
                  ? [
                      BoxShadow(
                        color: AppColors.bananiPrimary.withValues(alpha: 0.15),
                        blurRadius: 10.0,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : AppColors.buttonShadow,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio
                Container(
                  width: 22.0,
                  height: 22.0,
                  margin: const EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedPlanIndex == 1
                          ? AppColors.bananiPrimary
                          : const Color(0xFFCBD5E1),
                      width: 2.0,
                    ),
                    color: _selectedPlanIndex == 1
                        ? AppColors.bananiPrimary
                        : Colors.transparent,
                  ),
                  child: _selectedPlanIndex == 1
                      ? const Icon(Icons.check, size: 14.0, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Builder Pass',
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '\$19 / month',
                        style: TextStyle(
                          color: AppColors.bananiPrimary,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        'Flexible monthly billing · Cancel anytime with 1 click',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11.5,
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

  Widget _buildUnlockButton(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52.0,
          child: ElevatedButton(
            onPressed: _isProcessing ? null : _handleUnlock,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bananiPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              shadowColor: AppColors.bananiPrimary.withValues(alpha: 0.35),
            ),
            child: _isProcessing
                ? const SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.workspace_premium_rounded,
                          size: 18.0,
                          color: Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          _selectedPlanIndex == 0
                              ? 'Unlock All-Access VIP (\$149/yr) ➔'
                              : 'Unlock Monthly Pass (\$19/mo) ➔',
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Explore Free Community Content Instead',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuaranteeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 15.0,
            color: Color(0xFF059669),
          ),
          SizedBox(width: 6.0),
          Flexible(
            child: Text(
              '14-Day Money-Back Guarantee · Cancel Anytime in 1 Click',
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
