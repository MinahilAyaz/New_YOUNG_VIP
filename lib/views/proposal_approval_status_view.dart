import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'build_it_view.dart';
import 'expert_studio_view.dart';
import 'main_navigation_view.dart';

enum ProposalReviewStage {
  inReview,
  approved,
  revisionsRequested,
}

class ProposalApprovalStatusView extends StatefulWidget {
  final String proposalId;
  final String labTitle;
  final String authorName;
  final ProposalReviewStage initialStage;

  const ProposalApprovalStatusView({
    super.key,
    this.proposalId = 'PROP-LAB-2026-904',
    this.labTitle = 'Adversarial Jailbreak Defense in Multi-Agent Swarms',
    this.authorName = 'Dr. Sarah Lin',
    this.initialStage = ProposalReviewStage.inReview,
  });

  @override
  State<ProposalApprovalStatusView> createState() =>
      _ProposalApprovalStatusViewState();
}

class _ProposalApprovalStatusViewState
    extends State<ProposalApprovalStatusView> {
  late ProposalReviewStage _currentStage;
  bool _isRefreshing = false;
  String _lastUpdatedText = 'Just now';
  final Set<int> _expandedNotes = {0};

  @override
  void initState() {
    super.initState();
    _currentStage = widget.initialStage;
  }

  Future<void> _handleRefresh() async {
    HapticFeedback.lightImpact();
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(milliseconds: 650));
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
                  'Proposal review status is up to date.',
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

  void _copyProposalId() {
    Clipboard.setData(ClipboardData(text: widget.proposalId));
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.copy_rounded, color: Colors.white, size: 16.0),
            const SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'Proposal ID ${widget.proposalId} copied to clipboard',
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

  void _showFullProposalModal() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 24.0,
                offset: Offset(0, -6),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38.0,
                    height: 4.5,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Lab Proposal Artifact',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 16.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '5-Stage Curriculum Specifications & Compute Profile',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded,
                          color: AppColors.deepInk, size: 20.0),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildArtifactSection(
                          step: '01',
                          title: 'Build It — Multi-Agent Architecture',
                          desc:
                              'Deploy a LangGraph multi-agent cluster with isolated memory pools, strict message schema validation, and segregated state graphs to isolate tool calls.',
                        ),
                        const SizedBox(height: 12.0),
                        _buildArtifactSection(
                          step: '02',
                          title: 'Break It — Indirect Prompt Injection',
                          desc:
                              'Inject an adversarial canary payload into external RAG retrieval contexts to hijack sub-agent roles and force unauthorized tool invocation.',
                        ),
                        const SizedBox(height: 12.0),
                        _buildArtifactSection(
                          step: '03',
                          title: 'Understand It — Root-Cause Forensics',
                          desc:
                              'Inspect state transition DAGs, token attention weights, and message provenance to isolate the compromised graph edge in real-time.',
                        ),
                        const SizedBox(height: 12.0),
                        _buildArtifactSection(
                          step: '04',
                          title: 'Advise Better — Enterprise Advisory',
                          desc:
                              'Formulate automated client remediation advisory including canary signature diffs, defense-in-depth policies, and cryptographically signed audit logs.',
                        ),
                        const SizedBox(height: 12.0),
                        _buildArtifactSection(
                          step: '05',
                          title: 'Contextual Connection — Threat Matrix',
                          desc:
                              'Map the vulnerability directly to MITRE ATLAS framework (AML.T0051) and NIST AI Risk Management Framework 1.0 specifications.',
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PROVISIONED RUNTIME ENVIRONMENT',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                  color: Color(0xFF475569),
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '• Dual NVIDIA A100 (80GB) Cluster\n• vLLM 0.6.2 runtime + LangGraph 0.2.14\n• Isolated Qdrant Vector Store with token firewalls',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.deepInk,
                                  height: 1.45,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildArtifactSection({
    required String step,
    required String title,
    required String desc,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
                decoration: BoxDecoration(
                  color: AppColors.bananiLavender,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'STAGE $step',
                  style: const TextStyle(
                    color: AppColors.bananiPrimary,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            desc,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  void _showCommitteeContactModal() {
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
                            'Lab Governance Committee',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Direct communication with assigned technical fellows',
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
                _buildContactOptionTile(
                  icon: Icons.mark_email_read_outlined,
                  title: 'Email Review Fellows',
                  subtitle: 'fellows@youngvip.ai (direct review thread)',
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copied review thread address: fellows@youngvip.ai'),
                        backgroundColor: AppColors.deepInk,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                _buildContactOptionTile(
                  icon: Icons.alt_route_rounded,
                  title: 'Submit Compute Calibration Request',
                  subtitle: 'Request additional GPU nodes or vector clusters',
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Compute adjustment request dispatched to cluster ops.'),
                        backgroundColor: AppColors.deepInk,
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

  Widget _buildContactOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.0, color: AppColors.bananiPrimary),
            const SizedBox(width: 12.0),
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
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 13.0, color: Color(0xFF94A3B8)),
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
            constraints: const BoxConstraints(maxWidth: 820.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 20.0),
                  _buildHeroHeader(),
                  const SizedBox(height: 18.0),
                  _buildStageSwitcher(),
                  const SizedBox(height: 18.0),
                  _buildProposalMetaCard(),
                  const SizedBox(height: 22.0),
                  _buildSectionTitle(
                    title: 'Evaluation Pipeline',
                    subtitle: 'Multi-tiered technical review & sandbox validation',
                  ),
                  const SizedBox(height: 12.0),
                  _buildTimelineCard(),
                  const SizedBox(height: 22.0),
                  _buildSectionTitle(
                    title: 'Governance Scorecard',
                    subtitle: 'Peer-reviewed pedagogical & security scores',
                  ),
                  const SizedBox(height: 12.0),
                  _buildScorecardGrid(),
                  const SizedBox(height: 22.0),
                  _buildSectionTitle(
                    title: 'Committee Feedback',
                    subtitle: 'Direct reviews from assigned technical fellows',
                  ),
                  const SizedBox(height: 12.0),
                  _buildFellowFeedbackList(),
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
        // Live Review Status Badge
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: _buildStatusBadge(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    switch (_currentStage) {
      case ProposalReviewStage.inReview:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFFDE68A), width: 1.0),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hourglass_top_rounded,
                  size: 11.0, color: Color(0xFFD97706)),
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
        );
      case ProposalReviewStage.approved:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F4EC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFA7F3D0), width: 1.0),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_rounded,
                  size: 11.0, color: Color(0xFF059669)),
              SizedBox(width: 5.0),
              Text(
                'PROPOSAL RATIFIED & APPROVED',
                style: TextStyle(
                  color: Color(0xFF065F46),
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        );
      case ProposalReviewStage.revisionsRequested:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEE2E2),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFFECACA), width: 1.0),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.pending_actions_rounded,
                  size: 11.0, color: Color(0xFFDC2626)),
              SizedBox(width: 5.0),
              Text(
                'REVISIONS REQUESTED',
                style: TextStyle(
                  color: Color(0xFF991B1B),
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        );
    }
  }

  // ---------------------------------------------------------------------------
  // Hero Header
  // ---------------------------------------------------------------------------
  Widget _buildHeroHeader() {
    String headline;
    String description;

    switch (_currentStage) {
      case ProposalReviewStage.inReview:
        headline = 'Lab Proposal Under Review';
        description =
            'Your lab proposal has passed initial curriculum scrutiny and is currently undergoing automated Docker container build and A100 GPU compute validation.';
        break;
      case ProposalReviewStage.approved:
        headline = 'Lab Proposal Approved & Ratified!';
        description =
            'The Governance Council has ratified your proposal. A dedicated Dual A100 sandbox cluster has been provisioned, and 70% revenue share escrow is active.';
        break;
      case ProposalReviewStage.revisionsRequested:
        headline = 'Revisions Requested';
        description =
            'The technical fellows have requested minor calibrations to your Break It canary payload before cluster deployment can proceed.';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: AppColors.bananiLavender,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.fact_check_outlined,
                          size: 13.0,
                          color: AppColors.bananiPrimary,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'PROPOSAL REVIEW STATE',
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
              ),
            ),
            const SizedBox(width: 8.0),
            // Refresh Button
            GestureDetector(
              onTap: _isRefreshing ? null : _handleRefresh,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColors.cardBorder,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isRefreshing
                        ? const SizedBox(
                            width: 11.0,
                            height: 11.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.bananiPrimary),
                            ),
                          )
                        : const Icon(
                            Icons.refresh_rounded,
                            size: 13.0,
                            color: AppColors.deepInk,
                          ),
                    const SizedBox(width: 4.0),
                    Text(
                      _lastUpdatedText,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          headline,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          description,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Interactive Stage Switcher (Preview Different Review States)
  // ---------------------------------------------------------------------------
  Widget _buildStageSwitcher() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStageSwitchOption(
              stage: ProposalReviewStage.inReview,
              label: 'In Review',
              icon: Icons.hourglass_empty_rounded,
            ),
          ),
          Expanded(
            child: _buildStageSwitchOption(
              stage: ProposalReviewStage.approved,
              label: 'Approved',
              icon: Icons.check_circle_outline_rounded,
            ),
          ),
          Expanded(
            child: _buildStageSwitchOption(
              stage: ProposalReviewStage.revisionsRequested,
              label: 'Revisions',
              icon: Icons.rule_folder_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageSwitchOption({
    required ProposalReviewStage stage,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _currentStage == stage;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _currentStage = stage);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pureWhite : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 4.0,
                    offset: Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 13.0,
                color: isSelected ? AppColors.deepInk : const Color(0xFF64748B),
              ),
              const SizedBox(width: 5.0),
              Text(
                label,
                style: TextStyle(
                  color:
                      isSelected ? AppColors.deepInk : const Color(0xFF64748B),
                  fontSize: 11.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Proposal Meta Card
  // ---------------------------------------------------------------------------
  Widget _buildProposalMetaCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Proposal ID + Copy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Text(
                            widget.proposalId,
                            style: const TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'monospace',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: _copyProposalId,
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.copy_rounded,
                              size: 14.0,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: AppColors.bananiLavender,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Cohort 4 Track',
                      style: TextStyle(
                        color: AppColors.bananiPrimary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Lab Title
          Text(
            widget.labTitle,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 15.5,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12.0),

          const Divider(color: Color(0xFFF1F5F9), height: 1.0),
          const SizedBox(height: 12.0),

          // Key-Value Grid
          _buildMetaRow(
            label: 'Author / Architect',
            value: widget.authorName,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 8.0),
          _buildMetaRow(
            label: 'Curriculum Tier',
            value: 'Master Architect · 90 Min',
            icon: Icons.workspace_premium_outlined,
          ),
          const SizedBox(height: 8.0),
          _buildMetaRow(
            label: 'Compute Environment',
            value: 'Dual A100 GPU (vLLM + LangGraph)',
            icon: Icons.memory_rounded,
          ),
          const SizedBox(height: 8.0),
          _buildMetaRow(
            label: 'Assigned Fellows',
            value: 'Dr. Thorne & E. Rostova',
            icon: Icons.group_work_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14.0, color: AppColors.textSecondary),
        const SizedBox(width: 7.0),
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 5,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Evaluation Pipeline (4 Stages)
  // ---------------------------------------------------------------------------
  Widget _buildTimelineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          _buildTimelineItem(
            stepNumber: '1',
            title: '5-Stage Curriculum Review',
            subtitle: 'Pedagogical structure & MITRE ATLAS alignment',
            statusText: 'Verified · Passed 100%',
            isCompleted: true,
            isActive: false,
            isLast: false,
          ),
          _buildTimelineItem(
            stepNumber: '2',
            title: 'Sandbox Container & GPU Profiling',
            subtitle:
                'vLLM 0.6.2 memory footprint & LangGraph cluster test',
            statusText: _currentStage == ProposalReviewStage.approved
                ? 'Provisioned & Healthy'
                : (_currentStage == ProposalReviewStage.revisionsRequested
                    ? 'Calibration Needed'
                    : 'In Progress · 78% complete'),
            isCompleted: _currentStage == ProposalReviewStage.approved,
            isActive: _currentStage == ProposalReviewStage.inReview ||
                _currentStage == ProposalReviewStage.revisionsRequested,
            isLast: false,
          ),
          _buildTimelineItem(
            stepNumber: '3',
            title: 'Adversarial Red-Team Benchmark',
            subtitle: 'Automated jailbreak canary triggers & safety containment',
            statusText: _currentStage == ProposalReviewStage.approved
                ? 'Zero Escape Confirmed'
                : 'Queued for Evaluation',
            isCompleted: _currentStage == ProposalReviewStage.approved,
            isActive: false,
            isLast: false,
          ),
          _buildTimelineItem(
            stepNumber: '4',
            title: 'Council Ratification & Royalties',
            subtitle: '70% revenue share escrow & platform sprint schedule',
            statusText: _currentStage == ProposalReviewStage.approved
                ? 'Ratified by Dr. Thorne'
                : 'Pending Stage 3',
            isCompleted: _currentStage == ProposalReviewStage.approved,
            isActive: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String stepNumber,
    required String title,
    required String subtitle,
    required String statusText,
    required bool isCompleted,
    required bool isActive,
    required bool isLast,
  }) {
    Color stepColor;
    Color iconColor;
    Widget iconWidget;

    if (isCompleted) {
      stepColor = const Color(0xFF059669);
      iconColor = Colors.white;
      iconWidget = const Icon(Icons.check_rounded, size: 14.0, color: Colors.white);
    } else if (isActive) {
      if (_currentStage == ProposalReviewStage.revisionsRequested) {
        stepColor = const Color(0xFFDC2626);
        iconColor = Colors.white;
        iconWidget = const Icon(Icons.priority_high_rounded,
            size: 14.0, color: Colors.white);
      } else {
        stepColor = AppColors.bananiPrimary;
        iconColor = Colors.white;
        iconWidget = const Icon(Icons.sync_rounded,
            size: 14.0, color: Colors.white);
      }
    } else {
      stepColor = const Color(0xFFCBD5E1);
      iconColor = const Color(0xFF64748B);
      iconWidget = Text(
        stepNumber,
        style: TextStyle(
          color: iconColor,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: stepColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: iconWidget,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    color: isCompleted
                        ? const Color(0xFF059669).withValues(alpha: 0.3)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12.0),
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
                        flex: 6,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            statusText,
                            style: TextStyle(
                              color: isCompleted
                                  ? const Color(0xFF059669)
                                  : (isActive
                                      ? (_currentStage ==
                                              ProposalReviewStage
                                                  .revisionsRequested
                                          ? const Color(0xFFDC2626)
                                          : AppColors.bananiPrimary)
                                      : const Color(0xFF94A3B8)),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
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
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Governance Scorecard Grid
  // ---------------------------------------------------------------------------
  Widget _buildScorecardGrid() {
    final List<Map<String, dynamic>> metrics = [
      {
        'title': 'Innovation Index',
        'score': '98 / 100',
        'badge': 'Top 2%',
        'icon': Icons.auto_awesome_rounded,
        'color': const Color(0xFF7C3AED),
        'bg': const Color(0xFFF3E8FF),
      },
      {
        'title': 'Pedagogical Rigor',
        'score': '95 / 100',
        'badge': 'Exemplary',
        'icon': Icons.psychology_rounded,
        'color': const Color(0xFF059669),
        'bg': const Color(0xFFE6F4EC),
      },
      {
        'title': 'Sandbox Isolation',
        'score': 'Grade A+',
        'badge': 'Zero Escape',
        'icon': Icons.shield_rounded,
        'color': const Color(0xFF2563EB),
        'bg': const Color(0xFFEFF6FF),
      },
      {
        'title': 'Projected Rating',
        'score': '4.9 ★',
        'badge': 'High Yield',
        'icon': Icons.star_rounded,
        'color': const Color(0xFFD97706),
        'bg': const Color(0xFFFEF3C7),
      },
    ];

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 500) {
        return Row(
          children: [
            Expanded(child: _buildMetricTile(metrics[0])),
            const SizedBox(width: 8.0),
            Expanded(child: _buildMetricTile(metrics[1])),
            const SizedBox(width: 8.0),
            Expanded(child: _buildMetricTile(metrics[2])),
            const SizedBox(width: 8.0),
            Expanded(child: _buildMetricTile(metrics[3])),
          ],
        );
      }
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildMetricTile(metrics[0])),
              const SizedBox(width: 8.0),
              Expanded(child: _buildMetricTile(metrics[1])),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(child: _buildMetricTile(metrics[2])),
              const SizedBox(width: 8.0),
              Expanded(child: _buildMetricTile(metrics[3])),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildMetricTile(Map<String, dynamic> m) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: m['bg'] as Color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  m['icon'] as IconData,
                  size: 15.0,
                  color: m['color'] as Color,
                ),
              ),
              const SizedBox(width: 4.0),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: (m['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      m['badge'] as String,
                      style: TextStyle(
                        color: m['color'] as Color,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              m['score'] as String,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.4,
              ),
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            m['title'] as String,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Committee Feedback
  // ---------------------------------------------------------------------------
  Widget _buildFellowFeedbackList() {
    return Column(
      children: [
        _buildFellowFeedbackCard(
          fellowName: 'Dr. Marcus Thorne',
          role: 'Lead Technical Fellow · Autonomous Systems',
          avatarInitials: 'MT',
          avatarColor: AppColors.bananiLavender,
          avatarTextColor: AppColors.bananiPrimary,
          ratingTag: 'Approved with Commendation',
          feedbackText:
              'The curriculum progression from LangGraph message isolation to live vector RAG canary defense is exemplary. Docker specs align with our 80GB A100 memory requirements. Author has full greenlight.',
          index: 0,
        ),
        const SizedBox(height: 10.0),
        _buildFellowFeedbackCard(
          fellowName: 'Elena Rostova',
          role: 'Governance Fellow · Adversarial Red-Team',
          avatarInitials: 'ER',
          avatarColor: const Color(0xFFFEF3C7),
          avatarTextColor: const Color(0xFF92400E),
          ratingTag: _currentStage == ProposalReviewStage.revisionsRequested
              ? 'Calibrate Stage 2 Payload'
              : 'Container Hardening Passed',
          feedbackText: _currentStage == ProposalReviewStage.revisionsRequested
              ? 'Please tighten the indirect prompt payload string in Stage 2 to prevent tokenizer truncation in vLLM 0.6.2. Once updated, resubmit for immediate cluster sign-off.'
              : 'Isolated container network limits confirmed. Canary signature does not escape sandbox namespaces. Ready for platform scheduling.',
          index: 1,
        ),
      ],
    );
  }

  Widget _buildFellowFeedbackCard({
    required String fellowName,
    required String role,
    required String avatarInitials,
    required Color avatarColor,
    required Color avatarTextColor,
    required String ratingTag,
    required String feedbackText,
    required int index,
  }) {
    final isExpanded = _expandedNotes.contains(index);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: avatarColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  avatarInitials,
                  style: TextStyle(
                    color: avatarTextColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fellowName,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1.5),
                    Text(
                      role,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6.0),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      ratingTag,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            feedbackText,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 11.5,
              height: 1.4,
            ),
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                if (isExpanded) {
                  _expandedNotes.remove(index);
                } else {
                  _expandedNotes.add(index);
                }
              });
            },
            child: Text(
              isExpanded ? 'Show less' : 'Read full note',
              style: const TextStyle(
                color: AppColors.bananiPrimary,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
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
        // Primary Button
        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              if (_currentStage == ProposalReviewStage.approved) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BuildItView()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExpertStudioView()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bananiPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _currentStage == ProposalReviewStage.approved
                        ? Icons.play_arrow_rounded
                        : Icons.auto_stories_outlined,
                    size: 17.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    _currentStage == ProposalReviewStage.approved
                        ? 'Launch Lab in Sandbox'
                        : 'Open in Expert Studio',
                    style: const TextStyle(
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

        // Secondary: View Full 5-Stage Proposal Artifact
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton(
            onPressed: _showFullProposalModal,
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
                    'Inspect 5-Stage Proposal Artifact',
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

        // Tertiary: Contact Committee
        SizedBox(
          width: double.infinity,
          height: 44.0,
          child: TextButton(
            onPressed: _showCommitteeContactModal,
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.support_agent_rounded,
                      size: 15.0, color: AppColors.textSecondary),
                  SizedBox(width: 6.0),
                  Text(
                    'Contact Review Committee',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
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
