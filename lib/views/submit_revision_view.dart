import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'lab_builder_view.dart';
import 'lab_preview_view.dart';
import 'main_navigation_view.dart';

/// Screen allowing Build Experts and authors to submit labs, review peer-review
/// feedback, track actionable revision requests, record changelog responses,
/// and re-submit revised versions for governance board approval.
class SubmitRevisionView extends StatefulWidget {
  final String labId;
  final String labTitle;
  final String domainTrack;
  final String initialVersion;

  const SubmitRevisionView({
    super.key,
    this.labId = 'LAB-SUB-2026-772',
    this.labTitle = 'Adversarial Jailbreak Defense in Multi-Agent Swarms',
    this.domainTrack = 'Autonomous Agents & LLM Safety',
    this.initialVersion = 'v1.2',
  });

  @override
  State<SubmitRevisionView> createState() => _SubmitRevisionViewState();
}

class _SubmitRevisionViewState extends State<SubmitRevisionView> {
  // Submission Lifecycle Status:
  // 0: Revisions Requested (Active cycle)
  // 1: Re-Submitted (Pending committee re-audit)
  // 2: Ratified & Approved
  int _lifecycleStatus = 0;

  late TextEditingController _authorNotesController;

  // Actionable revision checklist items from the committee
  late List<Map<String, dynamic>> _revisionItems;

  // Revision change tags selected by author
  final List<String> _selectedChangeTags = [
    'Canary Assertions Updated',
    'Pedagogical Hints Refined',
    'VRAM Bounds Validated',
  ];

  @override
  void initState() {
    super.initState();
    _authorNotesController = TextEditingController(
      text:
          'Adjusted token entropy ceiling in Stage 2 (Break It) assertions to 0.72 threshold. Updated scaffolding hint #3 in Stage 1 to focus on SVD explained variance rather than giving away raw configuration values. Re-ran automated test suite across dual A100 GPU pods with 0 failures.',
    );

    _revisionItems = [
      {
        'id': 'REV-01',
        'reviewer': 'Elena Rostova (Adversarial Fellow)',
        'reviewerRole': 'Lead Security Auditor',
        'severity': 'HIGH PRIORITY',
        'severityColor': const Color(0xFFDC2626),
        'severityBg': const Color(0xFFFEF2F2),
        'comment':
            'In Stage 2 (Break It), the token entropy ceiling should trigger at p95 instead of p99 to avoid silent prompt leakage.',
        'actionTask':
            'Lower token entropy threshold to 0.72 in PyTest canary assertions',
        'stage': 'Stage 2 · Break It',
        'isDone': true,
      },
      {
        'id': 'REV-02',
        'reviewer': 'Dr. Marcus Thorne (Lead Systems Fellow)',
        'reviewerRole': 'Curriculum Reviewer',
        'severity': 'MEDIUM',
        'severityColor': const Color(0xFFD97706),
        'severityBg': const Color(0xFFFEF3C7),
        'comment':
            'Scaffolding hint #3 gives away the entire LoRA rank parameter without explaining the rank energy decomposition.',
        'actionTask':
            'Reword Scaffolding Hint #3 in Stage 1 to focus on SVD variance explanation',
        'stage': 'Stage 1 · Build It',
        'isDone': true,
      },
      {
        'id': 'REV-03',
        'reviewer': 'Elena Rostova (Adversarial Fellow)',
        'reviewerRole': 'Sandbox Hardware Auditor',
        'severity': 'RECOMMENDED',
        'severityColor': const Color(0xFF2563EB),
        'severityBg': const Color(0xFFEFF6FF),
        'comment':
            'Add explicit memory safeguard in the starter script to prevent CUDA OOM on unpadded batches > 32 tokens.',
        'actionTask':
            'Add gradient checkpointing safeguard in Stage 2 starter code snippet',
        'stage': 'Stage 2 · Break It',
        'isDone': false,
      },
    ];
  }

  @override
  void dispose() {
    _authorNotesController.dispose();
    super.dispose();
  }

  int get _resolvedCount =>
      _revisionItems.where((item) => item['isDone'] == true).length;
  double get _resolvedProgress =>
      _revisionItems.isEmpty ? 1.0 : _resolvedCount / _revisionItems.length;

  void _toggleItem(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _revisionItems[index]['isDone'] = !(_revisionItems[index]['isDone'] as bool);
    });
  }

  void _handleSubmitRevisedLab() {
    HapticFeedback.heavyImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 28.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.0,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                          color: const Color(0xFFA7F3D0), width: 1.0),
                    ),
                    child: const Icon(
                      Icons.published_with_changes_rounded,
                      color: Color(0xFF059669),
                      size: 24.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Submit Revision v1.3',
                          style: TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Send resolved change package to Governance Fellows',
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
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14.0),
                  border:
                      Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                ),
                child: Column(
                  children: [
                    _buildModalInfoRow(
                      label: 'Target Version',
                      value: 'v1.3 · Fast-Track Re-Audit',
                    ),
                    const SizedBox(height: 8.0),
                    _buildModalInfoRow(
                      label: 'Resolved Revisions',
                      value: '$_resolvedCount of ${_revisionItems.length} Checklist Items',
                    ),
                    const SizedBox(height: 8.0),
                    _buildModalInfoRow(
                      label: 'Assigned Fellows',
                      value: 'Dr. Thorne & E. Rostova',
                    ),
                    const SizedBox(height: 8.0),
                    _buildModalInfoRow(
                      label: 'Estimated Re-Audit SLA',
                      value: '12 - 24 Hours Expedited',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() => _lifecycleStatus = 1);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Revision v1.3 submitted successfully! Reviewers notified.'),
                        backgroundColor: Color(0xFF059669),
                        duration: Duration(seconds: 4),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: const Text(
                    'Confirm & Send Revision to Board',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Back to Revision Center',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalInfoRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 6,
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
                  const SizedBox(height: 18.0),
                  _buildHeroHeader(),
                  const SizedBox(height: 16.0),
                  _buildLifecycleTracker(),
                  const SizedBox(height: 16.0),
                  _buildActionableRevisionCenter(),
                  const SizedBox(height: 16.0),
                  _buildAuthorResponseCard(),
                  const SizedBox(height: 16.0),
                  _buildCanaryStatusCard(),
                  const SizedBox(height: 22.0),
                  _buildBottomActionButtons(),
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
  // Top Navigation Bar
  // ---------------------------------------------------------------------------
  Widget _buildTopBar(BuildContext context) {
    String badgeText;
    Color badgeBg;
    Color badgeBorder;
    Color badgeDot;
    Color badgeTextCol;

    if (_lifecycleStatus == 0) {
      badgeText = 'REVISIONS REQUESTED';
      badgeBg = const Color(0xFFFEF3C7);
      badgeBorder = const Color(0xFFFDE68A);
      badgeDot = const Color(0xFFD97706);
      badgeTextCol = const Color(0xFFB45309);
    } else if (_lifecycleStatus == 1) {
      badgeText = 'RE-SUBMITTED · IN REVIEW';
      badgeBg = const Color(0xFFEFF6FF);
      badgeBorder = const Color(0xFFBFDBFE);
      badgeDot = const Color(0xFF2563EB);
      badgeTextCol = const Color(0xFF1D4ED8);
    } else {
      badgeText = 'RATIFIED & PUBLISHED';
      badgeBg = const Color(0xFFECFDF5);
      badgeBorder = const Color(0xFFA7F3D0);
      badgeDot = const Color(0xFF059669);
      badgeTextCol = const Color(0xFF047857);
    }

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
        // Lifecycle Badge
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: badgeBorder,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: badgeDot,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    badgeText,
                    style: TextStyle(
                      color: badgeTextCol,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
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
  // Hero Header & Lab Metadata Card
  // ---------------------------------------------------------------------------
  Widget _buildHeroHeader() {
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
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9.0, vertical: 4.5),
                      decoration: BoxDecoration(
                        color: AppColors.bananiLavender,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.rate_review_rounded,
                            size: 13.0,
                            color: AppColors.bananiPrimary,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'GOVERNANCE & EDITORIAL BOARD · REVISION PIPELINE',
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
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.labId,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Submit & Revision',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Submit lab + handle revision requests',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),

          // Active Lab Content Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.science_outlined,
                              size: 15.0, color: AppColors.bananiPrimary),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              widget.labTitle,
                              style: const TextStyle(
                                color: AppColors.deepInk,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                            horizontal: 7.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: const Color(0xFFDBEAFE), width: 1.0),
                        ),
                        child: Text(
                          '${widget.initialVersion} → v1.3',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 4.0,
                  children: [
                    _buildHeaderMetaTag(
                        Icons.track_changes_rounded, widget.domainTrack),
                    _buildHeaderMetaTag(
                        Icons.people_outline_rounded, 'Dr. Thorne & E. Rostova'),
                    _buildHeaderMetaTag(
                        Icons.alarm_on_rounded, 'Review SLA: 36h Remaining'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderMetaTag(IconData icon, String text) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 240.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.0, color: AppColors.textSecondary),
          const SizedBox(width: 4.0),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lifecycle Timeline Stepper
  // ---------------------------------------------------------------------------
  Widget _buildLifecycleTracker() {
    final steps = [
      {'title': 'Initial Submit', 'isDone': true, 'isCurrent': false},
      {'title': 'Committee Review', 'isDone': true, 'isCurrent': false},
      {
        'title': 'Revision Cycle',
        'isDone': _lifecycleStatus > 0,
        'isCurrent': _lifecycleStatus == 0
      },
      {
        'title': 'Ratification',
        'isDone': _lifecycleStatus == 2,
        'isCurrent': _lifecycleStatus == 1
      },
    ];

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Governance Review Pipeline',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8.0),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _lifecycleStatus == 0
                      ? 'Step 3 of 4 Active'
                      : (_lifecycleStatus == 1 ? 'Step 4 In Progress' : 'Completed'),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: List.generate(steps.length, (idx) {
              final step = steps[idx];
              final isDone = step['isDone'] as bool;
              final isCurrent = step['isCurrent'] as bool;

              Color circleBg;
              Color circleBorder;
              Widget iconWidget;

              if (isDone) {
                circleBg = const Color(0xFF059669);
                circleBorder = const Color(0xFF059669);
                iconWidget =
                    const Icon(Icons.check, size: 11.0, color: Colors.white);
              } else if (isCurrent) {
                circleBg = AppColors.bananiLavender;
                circleBorder = AppColors.bananiPrimary;
                iconWidget = Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: const BoxDecoration(
                    color: AppColors.bananiPrimary,
                    shape: BoxShape.circle,
                  ),
                );
              } else {
                circleBg = const Color(0xFFF1F5F9);
                circleBorder = const Color(0xFFCBD5E1);
                iconWidget = Text(
                  '${idx + 1}',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }

              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: circleBg,
                        shape: BoxShape.circle,
                        border: Border.all(color: circleBorder, width: 1.2),
                      ),
                      child: Center(child: iconWidget),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Text(
                        step['title'] as String,
                        style: TextStyle(
                          color: isCurrent
                              ? AppColors.deepInk
                              : (isDone
                                  ? const Color(0xFF059669)
                                  : AppColors.textSecondary),
                          fontSize: 10.5,
                          fontWeight: isCurrent || isDone
                              ? FontWeight.w800
                              : FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actionable Revision Center (Feedback & Checklists)
  // ---------------------------------------------------------------------------
  Widget _buildActionableRevisionCenter() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requested Revision Items',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Check off each item once updated in the Lab Builder',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.0,
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
                      horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: _resolvedCount == _revisionItems.length
                        ? const Color(0xFFECFDF5)
                        : const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    '$_resolvedCount / ${_revisionItems.length} RESOLVED',
                    style: TextStyle(
                      color: _resolvedCount == _revisionItems.length
                          ? const Color(0xFF059669)
                          : const Color(0xFFD97706),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: _resolvedProgress,
              minHeight: 6.0,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(
                _resolvedProgress == 1.0
                    ? const Color(0xFF059669)
                    : AppColors.bananiPrimary,
              ),
            ),
          ),
          const SizedBox(height: 14.0),

          // Feedback List
          Column(
            children: List.generate(_revisionItems.length, (idx) {
              final item = _revisionItems[idx];
              final isDone = item['isDone'] as bool;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isDone
                        ? const Color(0xFFF8FAFC)
                        : const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isDone
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFFCBD5E1),
                      width: isDone ? 1.0 : 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Reviewer + Severity Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.account_circle_outlined,
                                    size: 14.0, color: AppColors.textSecondary),
                                const SizedBox(width: 6.0),
                                Expanded(
                                  child: Text(
                                    item['reviewer'] as String,
                                    style: const TextStyle(
                                      color: AppColors.deepInk,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                  horizontal: 6.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: item['severityBg'] as Color,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                item['severity'] as String,
                                style: TextStyle(
                                  color: item['severityColor'] as Color,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),

                      // Reviewer Comment
                      Text(
                        item['comment'] as String,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 11.5,
                          height: 1.35,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Actionable Task Checklist Row
                      GestureDetector(
                        onTap: () => _toggleItem(idx),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: isDone
                                ? const Color(0xFFECFDF5)
                                : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: isDone
                                  ? const Color(0xFFA7F3D0)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 18.0,
                                height: 18.0,
                                decoration: BoxDecoration(
                                  color: isDone
                                      ? const Color(0xFF059669)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDone
                                        ? const Color(0xFF059669)
                                        : const Color(0xFF94A3B8),
                                    width: 1.5,
                                  ),
                                ),
                                child: isDone
                                    ? const Icon(Icons.check,
                                        size: 11.0, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  item['actionTask'] as String,
                                  style: TextStyle(
                                    color: isDone
                                        ? const Color(0xFF065F46)
                                        : AppColors.deepInk,
                                    fontSize: 11.5,
                                    fontWeight: isDone
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    decoration: isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  item['stage'] as String,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 9.5,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Author Response & Changelog Notes
  // ---------------------------------------------------------------------------
  Widget _buildAuthorResponseCard() {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Author Changelog & Response',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Explain how the committee comments were addressed in v1.3',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),

          // Change Tags
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List.generate(_selectedChangeTags.length, (idx) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: AppColors.bananiLavender,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.done_all_rounded,
                          size: 11.0, color: AppColors.bananiPrimary),
                      const SizedBox(width: 4.0),
                      Flexible(
                        child: Text(
                          _selectedChangeTags[idx],
                          style: const TextStyle(
                            color: AppColors.bananiPrimary,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10.0),

          // Notes TextField
          TextField(
            controller: _authorNotesController,
            maxLines: 4,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.0,
              height: 1.4,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.all(12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
              ),
              hintText: 'Type your response to the review fellows...',
              hintStyle: const TextStyle(
                  color: AppColors.searchHint, fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Pre-Submission Canary Verification Card
  // ---------------------------------------------------------------------------
  Widget _buildCanaryStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Icon(Icons.terminal_rounded,
                        size: 14.0, color: Color(0xFF4ADE80)),
                    SizedBox(width: 6.0),
                    Flexible(
                      child: Text(
                        'CANARY EVALS VERIFICATION',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          fontFamily: 'monospace',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF059669),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    '100% PASS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFF1E293B), height: 16.0),
          const Text(
            '✓ PyTest Assertion Suite: 14/14 Passed across 5 Stages\n'
            '✓ Memory Bound: 62.8 GB / 80.0 GB Dual A100 Allocated\n'
            '✓ Scaffolding Hints: 15/15 Unlocked & Calibrated\n'
            '✓ Escrow Split: 70% Author Royalties Active',
            style: TextStyle(
              color: Color(0xFF4ADE80),
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Action Buttons
  // ---------------------------------------------------------------------------
  Widget _buildBottomActionButtons() {
    return Column(
      children: [
        // Primary: Submit Revised Lab
        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            onPressed: _lifecycleStatus == 1 ? null : _handleSubmitRevisedLab,
            style: ElevatedButton.styleFrom(
              backgroundColor: _lifecycleStatus == 1
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF059669),
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
                    _lifecycleStatus == 1
                        ? Icons.check_circle_rounded
                        : Icons.send_rounded,
                    size: 16.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    _lifecycleStatus == 1
                        ? 'Revision v1.3 Submitted · In Review'
                        : 'Submit Revised Lab for Review',
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

        // Secondary: Edit Content in Lab Builder
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LabBuilderView(
                    labId: widget.labId,
                    initialTitle: widget.labTitle,
                    domainTrack: widget.domainTrack,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.architecture_rounded, size: 16.0),
            label: const Text(
              'Open in Lab Builder Editor',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.deepInk,
              side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Tertiary: Preview in Lab Preview
        SizedBox(
          width: double.infinity,
          height: 44.0,
          child: OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LabPreviewView(
                    labId: widget.labId,
                    labTitle: widget.labTitle,
                    domainTrack: widget.domainTrack,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.preview_rounded, size: 15.0),
            label: const Text(
              'Inspect in Lab Preview',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.bananiPrimary,
              side: const BorderSide(color: AppColors.bananiLavender, width: 1.2),
              backgroundColor: const Color(0xFFFAF5FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
