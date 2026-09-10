import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'expert_studio_view.dart';
import 'main_navigation_view.dart';

class BuildExpertApprovedView extends StatefulWidget {
  final String creatorId;
  final String creatorName;
  final String approvedTrackTitle;

  const BuildExpertApprovedView({
    super.key,
    this.creatorId = 'EXP-AUTH-2026-COH4',
    this.creatorName = 'Dr. Sarah Lin',
    this.approvedTrackTitle =
        'Dynamic Prompt Injection Defense & Multi-Agent Guardrails',
  });

  @override
  State<BuildExpertApprovedView> createState() =>
      _BuildExpertApprovedViewState();
}

class _BuildExpertApprovedViewState extends State<BuildExpertApprovedView> {
  bool _payoutConfigured = false;
  bool _sandboxInitialized = false;
  bool _calibrationScheduled = false;

  void _copyCreatorId() {
    Clipboard.setData(ClipboardData(text: widget.creatorId));
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.verified_rounded, color: Colors.white, size: 16.0),
            const SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'Creator ID ${widget.creatorId} copied to clipboard',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
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

  void _showAgreementModal() {
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
                        color: const Color(0xFFE6F4EC),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF059669),
                        size: 22.0,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Creator Agreement & Terms',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Young VIP Build Expert Fellowship · Cohort 4',
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
                _buildAgreementTermTile(
                  icon: Icons.percent_rounded,
                  title: '70% Revenue Share',
                  description:
                      'You receive 70% of gross proceeds from student track sprint passes and proportional enterprise team seats.',
                ),
                const SizedBox(height: 10.0),
                _buildAgreementTermTile(
                  icon: Icons.memory_rounded,
                  title: 'Cloud Compute Subsidy',
                  description:
                      'Young VIP covers 100% of dedicated A100 GPU sandbox compute costs incurred during student lab execution.',
                ),
                const SizedBox(height: 10.0),
                _buildAgreementTermTile(
                  icon: Icons.shield_outlined,
                  title: 'Intellectual Property & Licensing',
                  description:
                      'You retain 100% ownership of your proprietary syllabus, code repositories, and educational frameworks.',
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 46.0,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepInk,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Close Terms Overview',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAgreementTermTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.0, color: const Color(0xFF059669)),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.0,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 14.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 18.0),
                  _buildCelebrationHeader(),
                  const SizedBox(height: 18.0),
                  _buildAccreditationCard(),
                  const SizedBox(height: 22.0),
                  _buildSectionTitle(
                    title: 'Unlocked Creator Privileges',
                    subtitle: 'Active fellowship benefits and author resources',
                  ),
                  const SizedBox(height: 12.0),
                  _buildPrivilegesGrid(),
                  const SizedBox(height: 22.0),
                  _buildSectionTitle(
                    title: 'Creator Launchpad Checklist',
                    subtitle: 'Essential setup steps before Cohort 4 student kickoff',
                  ),
                  const SizedBox(height: 12.0),
                  _buildChecklistCard(),
                  const SizedBox(height: 24.0),
                  _buildActionButtons(context),
                  const SizedBox(height: 48.0),
                ],
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
        // Official Accreditation Badge
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4EC),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFA7F3D0),
                  width: 1.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 11.0,
                    color: Color(0xFF059669),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'ACCREDITED CREATOR · COHORT 4',
                    style: TextStyle(
                      color: Color(0xFF065F46),
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
  // Celebratory Hero Banner
  // ---------------------------------------------------------------------------
  Widget _buildCelebrationHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6F4EC), Color(0xFFD1FAE5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFA7F3D0), width: 1.0),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Color(0xFF059669),
                  size: 26.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EC),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 11.0,
                              color: Color(0xFF059669),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'GOVERNANCE RATIFICATION COMPLETE',
                              style: TextStyle(
                                color: Color(0xFF065F46),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Welcome to the Fellowship',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            "You're Approved as a Build Expert!",
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Congratulations, ${widget.creatorName}! The Young VIP Governance Council has ratified your application for Cohort 4. Your verified author privileges, dedicated GPU sandbox compute cluster, and 70% revenue share terms are now active.',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Accreditation Certificate & ID Card
  // ---------------------------------------------------------------------------
  Widget _buildAccreditationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'ACCREDITATION CREDENTIAL',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4EC),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_clock_outlined,
                          size: 11.0, color: Color(0xFF059669)),
                      SizedBox(width: 4.0),
                      Text(
                        'RATIFIED & ACTIVE',
                        style: TextStyle(
                          color: Color(0xFF065F46),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Creator ID with Copy Button
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
                        'CREATOR AUTHOR ID',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        widget.creatorId,
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
                  onTap: _copyCreatorId,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: const Color(0xFFCBD5E1), width: 1.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy_rounded,
                            size: 12.5, color: AppColors.deepInk),
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
          const SizedBox(height: 14.0),

          // Certificate Breakdown Rows
          _buildCertificateRow(
            label: 'Accredited Author',
            value: widget.creatorName,
          ),
          const SizedBox(height: 8.0),
          _buildCertificateRow(
            label: 'Author Specialization',
            value: 'Autonomous Agents & LLM Safety',
          ),
          const SizedBox(height: 8.0),
          _buildCertificateRow(
            label: 'Approved Track',
            value: widget.approvedTrackTitle,
          ),
          const SizedBox(height: 8.0),
          _buildCertificateRow(
            label: 'Certified Fluency Index',
            value: '98 / 100 · Elite AI Architect',
            valueColor: const Color(0xFF059669),
          ),
          const SizedBox(height: 8.0),
          _buildCertificateRow(
            label: 'Governance Fellows',
            value: 'Dr. Thorne & E. Rostova',
          ),
          const SizedBox(height: 8.0),
          _buildCertificateRow(
            label: 'Fellowship Term',
            value: 'Cohort 4 · Oct 2026 – Oct 2027',
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateRow({
    required String label,
    required String value,
    Color valueColor = AppColors.deepInk,
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
  // Unlocked Privileges Grid (4 Cards)
  // ---------------------------------------------------------------------------
  Widget _buildPrivilegesGrid() {
    final privileges = [
      {
        'icon': Icons.monetization_on_outlined,
        'title': '70% Direct Revenue Share',
        'desc': 'Disbursed monthly on student pass sales and team licenses',
        'color': const Color(0xFF059669),
        'bg': const Color(0xFFE6F4EC),
      },
      {
        'icon': Icons.memory_rounded,
        'title': 'Dedicated Cloud GPU Sandbox',
        'desc': 'A100 compute cluster access pre-provisioned for your lab',
        'color': AppColors.bananiPrimary,
        'bg': AppColors.bananiLavender,
      },
      {
        'icon': Icons.auto_stories_outlined,
        'title': 'Expert Studio Authoring Suite',
        'desc': 'Publish, version, and stress-test interactive 5-stage sprints',
        'color': const Color(0xFF2563EB),
        'bg': const Color(0xFFEFF6FF),
      },
      {
        'icon': Icons.verified_user_outlined,
        'title': 'Verified Author Crest & Profile',
        'desc': 'Global Fluency accreditation visible across the network',
        'color': const Color(0xFFD97706),
        'bg': const Color(0xFFFEF3C7),
      },
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final isTwoColumn = constraints.maxWidth >= 480;

      if (isTwoColumn) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildPrivilegeTile(privileges[0])),
                const SizedBox(width: 10.0),
                Expanded(child: _buildPrivilegeTile(privileges[1])),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(child: _buildPrivilegeTile(privileges[2])),
                const SizedBox(width: 10.0),
                Expanded(child: _buildPrivilegeTile(privileges[3])),
              ],
            ),
          ],
        );
      }

      return Column(
        children: privileges
            .map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildPrivilegeTile(p),
                ))
            .toList(),
      );
    });
  }

  Widget _buildPrivilegeTile(Map<String, dynamic> p) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              color: p['bg'] as Color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              p['icon'] as IconData,
              size: 18.0,
              color: p['color'] as Color,
            ),
          ),
          const SizedBox(height: 10.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              p['title'] as String,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            p['desc'] as String,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.0,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Creator Launchpad Checklist
  // ---------------------------------------------------------------------------
  Widget _buildChecklistCard() {
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
        children: [
          _buildChecklistItem(
            title: 'Configure Creator Payouts (Stripe Connect)',
            subtitle: 'Link bank account or corporate entity for 70% disbursements',
            isChecked: _payoutConfigured,
            onToggle: (v) {
              HapticFeedback.selectionClick();
              setState(() => _payoutConfigured = v);
            },
          ),
          const Divider(color: Color(0xFFF1F5F9), height: 18.0),
          _buildChecklistItem(
            title: 'Initialize Sprint in Expert Studio',
            subtitle: 'Configure the 5 lab workflow steps and dynamic canary prompts',
            isChecked: _sandboxInitialized,
            onToggle: (v) {
              HapticFeedback.selectionClick();
              setState(() => _sandboxInitialized = v);
            },
          ),
          const Divider(color: Color(0xFFF1F5F9), height: 18.0),
          _buildChecklistItem(
            title: 'Schedule Fellow Calibration Call',
            subtitle: '30-min technical review session with Dr. Thorne before launch',
            isChecked: _calibrationScheduled,
            onToggle: (v) {
              HapticFeedback.selectionClick();
              setState(() => _calibrationScheduled = v);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem({
    required String title,
    required String subtitle,
    required bool isChecked,
    required ValueChanged<bool> onToggle,
  }) {
    return GestureDetector(
      onTap: () => onToggle(!isChecked),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22.0,
            height: 22.0,
            margin: const EdgeInsets.only(top: 2.0),
            decoration: BoxDecoration(
              color: isChecked ? const Color(0xFF059669) : AppColors.pureWhite,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: isChecked
                    ? const Color(0xFF059669)
                    : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check_rounded,
                    size: 15.0,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isChecked
                        ? const Color(0xFF059669)
                        : AppColors.deepInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Action Buttons
  // ---------------------------------------------------------------------------
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Primary: Launch Expert Studio
        SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExpertStudioView()),
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
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_stories_outlined, size: 17.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Launch Expert Studio',
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

        // Secondary: View Agreement & Royalties
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton(
            onPressed: _showAgreementModal,
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
                  Icon(Icons.description_outlined, size: 16.0),
                  SizedBox(width: 8.0),
                  Text(
                    'View Creator Agreement & Royalties',
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

        // Tertiary: Return to Platform
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
