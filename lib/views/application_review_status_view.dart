import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'build_expert_approved_view.dart';
import 'main_navigation_view.dart';

class ApplicationReviewStatusView extends StatefulWidget {
  final String applicationId;
  final String applicantName;
  final String trackTitle;

  const ApplicationReviewStatusView({
    super.key,
    this.applicationId = 'EXP-2026-COH4-891',
    this.applicantName = 'Dr. Sarah Lin',
    this.trackTitle =
        'Dynamic Prompt Injection Defense & Multi-Agent Guardrails',
  });

  @override
  State<ApplicationReviewStatusView> createState() =>
      _ApplicationReviewStatusViewState();
}

class _ApplicationReviewStatusViewState
    extends State<ApplicationReviewStatusView> {
  bool _isRefreshing = false;
  String _lastUpdatedText = 'Just now';
  final Set<int> _expandedFaqIndices = {0};

  Future<void> _handleRefresh() async {
    HapticFeedback.lightImpact();
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) {
      setState(() {
        _isRefreshing = false;
        _lastUpdatedText = 'Moments ago';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 18.0),
              SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  'Application review status is up to date.',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _copyApplicationId() {
    Clipboard.setData(ClipboardData(text: widget.applicationId));
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.copy_rounded, color: Colors.white, size: 16.0),
            const SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'Application ID ${widget.applicationId} copied to clipboard',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.deepInk,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showGovernanceSupportModal() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 20.0,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36.0,
                    height: 4.0,
                    margin: const EdgeInsets.only(bottom: 18.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: AppColors.bananiLavender,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.support_agent_rounded,
                        color: AppColors.bananiPrimary,
                        size: 22.0,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Governance Council Support',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Direct assistance for applicant inquiries',
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
                const SizedBox(height: 18.0),
                _buildSupportOptionTile(
                  icon: Icons.mark_email_read_outlined,
                  title: 'Email Governance Committee',
                  subtitle: 'governance@youngvip.ai (response in < 12h)',
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Support address copied: governance@youngvip.ai'),
                        backgroundColor: AppColors.deepInk,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                _buildSupportOptionTile(
                  icon: Icons.post_add_rounded,
                  title: 'Submit Supplementary Artifacts',
                  subtitle: 'Add recent papers, benchmarks, or repo links',
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Upload channel active. Check your email confirmation.'),
                        backgroundColor: AppColors.deepInk,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                _buildSupportOptionTile(
                  icon: Icons.cancel_outlined,
                  title: 'Withdraw Application',
                  subtitle: 'Cancel this submission for Cohort 4',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Withdrawal request noted.'),
                        backgroundColor: Color(0xFFDC2626),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSupportOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isDestructive
                ? const Color(0xFFFECACA)
                : const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.0,
              color: isDestructive
                  ? const Color(0xFFDC2626)
                  : AppColors.bananiPrimary,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDestructive
                          ? const Color(0xFFDC2626)
                          : AppColors.deepInk,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
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
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 18.0,
            ),
          ],
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
      backgroundColor: AppColors.warmIvory,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580.0),
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: AppColors.bananiPrimary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 14.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(context),
                    const SizedBox(height: 18.0),
                    _buildHeroHeader(),
                    const SizedBox(height: 16.0),
                    _buildStatusOverviewCard(),
                    const SizedBox(height: 22.0),
                    _buildSectionTitle(
                      title: 'Review Progress',
                      subtitle: 'Multi-stage peer evaluation breakdown',
                    ),
                    const SizedBox(height: 12.0),
                    _buildReviewTimeline(),
                    const SizedBox(height: 22.0),
                    _buildSectionTitle(
                      title: 'Application Snapshot',
                      subtitle: 'Summary of submitted track & author portfolio',
                    ),
                    const SizedBox(height: 12.0),
                    _buildApplicationSnapshotCard(),
                    const SizedBox(height: 22.0),
                    _buildSectionTitle(
                      title: 'Frequently Asked Questions',
                      subtitle: 'Next steps, notifications, and timeline details',
                    ),
                    const SizedBox(height: 12.0),
                    _buildFaqSection(),
                    const SizedBox(height: 24.0),
                    _buildActionButtons(context),
                    const SizedBox(height: 48.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Bar
  // ---------------------------------------------------------------------------
  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainNavigationView(initialIndex: 0),
                    ),
                  );
                }
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
            ),
            const YoungVipWordmark(),
          ],
        ),
        const SizedBox(width: 8.0),
        // Live Review Status Badge
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFFDE68A),
                  width: 1.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.hourglass_top_rounded,
                    size: 10.0,
                    color: Color(0xFFD97706),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'IN REVIEW · STAGE 2 OF 4',
                    style: TextStyle(
                      color: Color(0xFF92400E),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Hero Header
  // ---------------------------------------------------------------------------
  Widget _buildHeroHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.5),
          decoration: BoxDecoration(
            color: AppColors.bananiLavender,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.fact_check_outlined,
                  size: 13.0,
                  color: AppColors.bananiPrimary,
                ),
                SizedBox(width: 5.0),
                Text(
                  'APPLICATION STATUS',
                  style: TextStyle(
                    color: AppColors.bananiPrimary,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Your Application is Under Review',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The Young VIP Governance Council is actively evaluating your curriculum syllabus, technical sandboxing parameters, and verified creator credentials for Cohort 4.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Status Overview Card (Luxury Hero Card)
  // ---------------------------------------------------------------------------
  Widget _buildStatusOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1.5),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: const Icon(
                        Icons.hourglass_bottom_rounded,
                        color: Color(0xFFD97706),
                        size: 17.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Evaluation',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.2,
                            ),
                          ),
                          Text(
                            'Phase 2: Peer Review',
                            style: TextStyle(
                              color: Color(0xFFD97706),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sync_rounded,
                          size: 11.0, color: Color(0xFF64748B)),
                      const SizedBox(width: 4.0),
                      Text(
                        _lastUpdatedText,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Progress Bar (50% complete)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Evaluation Progress',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '50% (2 of 4 Steps)',
                      style: const TextStyle(
                        color: AppColors.bananiPrimary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 7.0,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.bananiPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Divider
          const Divider(color: Color(0xFFF1F5F9), height: 1.0),
          const SizedBox(height: 14.0),

          // Application ID with Copy Action
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'APPLICATION ID',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        widget.applicationId,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: _copyApplicationId,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: const Color(0xFFCBD5E1), width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 4.0,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy_rounded,
                            size: 13.0, color: AppColors.deepInk),
                        SizedBox(width: 4.0),
                        Text(
                          'Copy ID',
                          style: TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Metadata Details Grid
          _buildDetailRow(
            label: 'Estimated Decision Window',
            value: 'Within 48 - 72 Hours',
            valueColor: const Color(0xFF059669),
          ),
          const SizedBox(height: 6.0),
          _buildDetailRow(
            label: 'Assigned Peer Fellows',
            value: 'Dr. Aris Thorne & Elena Rostova',
            valueColor: AppColors.deepInk,
          ),
          const SizedBox(height: 6.0),
          _buildDetailRow(
            label: 'Target Cohort Launch',
            value: 'Cohort 4 · October 2026',
            valueColor: AppColors.deepInk,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Review Timeline (Detailed 4-stage Stepper)
  // ---------------------------------------------------------------------------
  Widget _buildReviewTimeline() {
    final stages = [
      {
        'title': 'Application Submitted & Validated',
        'subtitle': 'Credentials recorded and initial compliance verified',
        'time': 'Oct 24, 2026 · 14:32 UTC',
        'status': 'completed', // completed, active, queued
        'badge': 'VERIFIED',
      },
      {
        'title': 'Peer Review & Syllabus Architecture',
        'subtitle':
            'Governance Council evaluating 5-stage lab design and prompt defense models',
        'time': 'In progress right now',
        'status': 'active',
        'badge': 'IN REVIEW',
      },
      {
        'title': 'Sandbox Security & Guardrail Audit',
        'subtitle':
            'Automated execution tests in isolated GPU sandbox containers',
        'time': 'Est. Oct 26, 2026',
        'status': 'queued',
        'badge': 'QUEUED',
      },
      {
        'title': 'Final Cohort Accreditation & Author Badge',
        'subtitle':
            'Creator contract issued, 70% revenue onboarding, and live sprint publishing',
        'time': 'Est. Oct 27, 2026',
        'status': 'queued',
        'badge': 'UPCOMING',
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: List.generate(stages.length, (index) {
          final s = stages[index];
          final isLast = index == stages.length - 1;
          final isCompleted = s['status'] == 'completed';
          final isActive = s['status'] == 'active';

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline column: Indicator + vertical line
                Column(
                  children: [
                    Container(
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFFE6F4EC)
                            : (isActive
                                ? AppColors.bananiLavender
                                : const Color(0xFFF1F5F9)),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted
                              ? const Color(0xFF059669)
                              : (isActive
                                  ? AppColors.bananiPrimary
                                  : const Color(0xFFCBD5E1)),
                          width: isActive ? 2.0 : 1.5,
                        ),
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check_rounded
                            : (isActive
                                ? Icons.hourglass_top_rounded
                                : Icons.radio_button_unchecked_rounded),
                        size: 13.0,
                        color: isCompleted
                            ? const Color(0xFF059669)
                            : (isActive
                                ? AppColors.bananiPrimary
                                : const Color(0xFF94A3B8)),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.0,
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          color: isCompleted
                              ? const Color(0xFF059669)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12.0),

                // Stage content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0.0 : 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                s['title']!,
                                style: TextStyle(
                                  color: isActive
                                      ? AppColors.deepInk
                                      : (isCompleted
                                          ? AppColors.deepInk
                                          : const Color(0xFF64748B)),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: isCompleted
                                      ? const Color(0xFFE6F4EC)
                                      : (isActive
                                          ? const Color(0xFFFEF3C7)
                                          : const Color(0xFFF1F5F9)),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  s['badge']!,
                                  style: TextStyle(
                                    color: isCompleted
                                        ? const Color(0xFF065F46)
                                        : (isActive
                                            ? const Color(0xFF92400E)
                                            : const Color(0xFF64748B)),
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          s['subtitle']!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11.0,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 11.0,
                              color: isActive
                                  ? const Color(0xFFD97706)
                                  : const Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 4.0),
                            Flexible(
                              child: Text(
                                s['time']!,
                                style: TextStyle(
                                  color: isActive
                                      ? const Color(0xFFD97706)
                                      : const Color(0xFF94A3B8),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Application Snapshot Card
  // ---------------------------------------------------------------------------
  Widget _buildApplicationSnapshotCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34.0,
                height: 34.0,
                decoration: BoxDecoration(
                  color: AppColors.bananiLavender,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: AppColors.bananiPrimary,
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROPOSED SPRINT TRACK',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Dynamic Prompt Injection Defense',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
            ),
            child: Column(
              children: [
                _buildSnapshotRow('Applicant', widget.applicantName),
                const SizedBox(height: 6.0),
                _buildSnapshotRow(
                    'Affiliation', 'Cognitive Systems Institute'),
                const SizedBox(height: 6.0),
                _buildSnapshotRow(
                    'Domain', 'Autonomous Agents & LLM Safety'),
                const SizedBox(height: 6.0),
                _buildSnapshotRow(
                    'Audience Tier', 'Practitioner (Mastery Sprint)'),
                const SizedBox(height: 6.0),
                _buildSnapshotRow('Credentials', '3 Verified Publications'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSnapshotRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Interactive FAQ Section
  // ---------------------------------------------------------------------------
  Widget _buildFaqSection() {
    final faqs = [
      {
        'q': 'How will I be notified when peer review concludes?',
        'a':
            'You will receive an official cryptographic email notification, and your in-app status badge will update immediately with cohort onboarding instructions.',
      },
      {
        'q': 'Can I submit revisions or more artifacts while in review?',
        'a':
            'Yes. Use the "Governance Support" action below to transmit updated preprint links, patents, or repository benchmarks directly to your assigned evaluators.',
      },
      {
        'q': 'What happens once my track is approved?',
        'a':
            'You will be granted immediate access to the Young VIP Expert Studio, where you can author interactive lab steps, configure GPU sandboxes, and receive your 70% revenue share onboarding kit.',
      },
    ];

    return Column(
      children: List.generate(faqs.length, (idx) {
        final item = faqs[idx];
        final isExpanded = _expandedFaqIndices.contains(idx);

        return Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: isExpanded
                  ? AppColors.bananiPrimary.withValues(alpha: 0.3)
                  : AppColors.cardBorder,
              width: 1.0,
            ),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    if (isExpanded) {
                      _expandedFaqIndices.remove(idx);
                    } else {
                      _expandedFaqIndices.add(idx);
                    }
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        isExpanded
                            ? Icons.help_rounded
                            : Icons.help_outline_rounded,
                        size: 16.0,
                        color: isExpanded
                            ? AppColors.bananiPrimary
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          item['q']!,
                          style: TextStyle(
                            color: isExpanded
                                ? AppColors.bananiPrimary
                                : AppColors.deepInk,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xFF94A3B8),
                        size: 18.0,
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, right: 14.0, bottom: 12.0),
                  child: Text(
                    item['a']!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.5,
                      height: 1.45,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------------
  // Action Buttons
  // ---------------------------------------------------------------------------
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Refresh Status Button
        SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton(
            onPressed: _isRefreshing ? null : _handleRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bananiPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: _isRefreshing
                ? const SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh_rounded, size: 17.0),
                        SizedBox(width: 8.0),
                        Text(
                          'Refresh Review Status',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Contact Governance Support Button
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton(
            onPressed: _showGovernanceSupportModal,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.deepInk,
              side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.support_agent_rounded, size: 17.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Governance Council Support',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // View Approved Accreditation Screen
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BuildExpertApprovedView(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF065F46),
              backgroundColor: const Color(0xFFE6F4EC),
              side: const BorderSide(color: Color(0xFFA7F3D0), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_rounded,
                      size: 16.0, color: Color(0xFF059669)),
                  SizedBox(width: 8.0),
                  Text(
                    'View Approved Accreditation Screen',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Return to Platform
        SizedBox(
          width: double.infinity,
          height: 44.0,
          child: TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainNavigationView(initialIndex: 0),
                  ),
                );
              }
            },
            child: const Text(
              'Return to Platform',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section Title Helper
  // ---------------------------------------------------------------------------
  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }
}
