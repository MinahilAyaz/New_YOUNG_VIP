import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/lab_stage_screen_model.dart';
import '../viewmodels/advise_better_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'break_it_view.dart';
import 'build_it_view.dart';
import 'lab_complete_view.dart';
import 'understand_it_view.dart';
import 'contextual_connection_view.dart';

class AdviseBetterView extends StatelessWidget {
  final bool isRootTab;

  const AdviseBetterView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdviseBetterViewModel>(
      create: (_) => AdviseBetterViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.peachBackground,
        drawer: const CustomDrawer(),
        body: Consumer<AdviseBetterViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final stageData = viewModel.stageData;

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
                          _buildHeader(stageData),
                          const SizedBox(height: 16.0),
                          _buildAdvisorySummaryCard(stageData),
                          const SizedBox(height: 18.0),
                          _buildStepper(context, stageData.steps),
                          const SizedBox(height: 20.0),
                          _buildDeliverablesConsoleCard(context, viewModel),
                          const SizedBox(height: 20.0),
                          _buildContentBlocks(
                              context, viewModel, stageData.contentBlocks),
                          const SizedBox(height: 18.0),
                          _buildGovernanceChecklistCard(context, viewModel),
                          const SizedBox(height: 24.0),
                          _buildCompletionPill(context),
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
                  Icons.arrow_back_rounded,
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38.0,
              height: 38.0,
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
                    size: 18.0,
                  ),
                  Positioned(
                    top: 8.0,
                    right: 9.0,
                    child: Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: AppColors.avatarBg,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: AppColors.buttonShadow,
              ),
              alignment: Alignment.center,
              child: const Text(
                'AV',
                style: TextStyle(
                  color: AppColors.avatarText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader(AdviseBetterStageModel stageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10.0,
          runSpacing: 6.0,
          children: [
            Text(
              stageData.stageTitle,
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w800,
                color: AppColors.deepInk,
                letterSpacing: -0.4,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
                vertical: 3.5,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                'EXECUTIVE STRATEGY',
                style: TextStyle(
                  color: Color(0xFF059669),
                  fontSize: 9.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            stageData.labTagLabel,
            style: const TextStyle(
              color: Color(0xFF92400E),
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdvisorySummaryCard(AdviseBetterStageModel stageData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 6.0,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF059669).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: Color(0xFF059669),
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    'BOARD-LEVEL BRIEF',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7.0, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'FINAL STAGE',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            stageData.advisorySummary,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: AppColors.deepInk,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper(BuildContext context, List<StageStepModel> steps) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isCurrent = step.isActive;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BuildItView(),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BreakItView(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UnderstandItView(),
                    ),
                  );
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  Container(
                    width: isCurrent ? 12.0 : 8.0,
                    height: isCurrent ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? AppColors.deepInk
                          : const Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    step.label,
                    style: TextStyle(
                      color: isCurrent
                          ? AppColors.deepInk
                          : const Color(0xFF10B981),
                      fontSize: 10.5,
                      fontWeight:
                          isCurrent ? FontWeight.bold : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDeliverablesConsoleCard(
      BuildContext context, AdviseBetterViewModel viewModel) {
    const executiveBrief = '''
EXECUTIVE RISK MEMORANDUM
TO: Chief Executive Officer, Chief Information Security Officer
FROM: Lead AI Systems Architect
RE: Autonomous Contract Auditor — Hardened Governance Protocol

1. INCIDENT FINDINGS (STAGES 1-3):
   During stress-testing in Stage 2, unhardened prompt injection bypassed
   authorization boundaries, initiating an unapproved database schema dump.
   Root cause: direct prompt contamination without cryptographic XML fences.

2. HARDENING SPECIFICATION IMPLEMENTED:
   • Layer 1: Input Syntactic Fencing (<user_input_untrusted> tags).
   • Layer 2: Dual-Agent Verifier Topology (Zero-tool oversight model).
   • Layer 3: Hardened Execution SLAs (5-iteration budget, cold audit log).

3. ESTIMATED RISK MITIGATION:
   Reduces unauthorized data egress vulnerability by 99.8%.
   Full compliance with ISO/IEC 42001 & EU AI Act Article 14.''';

    const topologyRfc = '''
RFC-042: PRODUCTION HARDENED TOPOLOGY
Status: APPROVED FOR DEPLOYMENT

Components:
  1. Input-Gatekeeper:
     - Sanitizes delimiters and enforces 2048 token envelope
  2. Orchestrator-Agent (Gemini 1.5 Pro):
     - Operates with strict zero-write permissions
  3. Action-Verifier-Guard:
     - Independent model verifying tool signature integrity
  4. Execution-Sandbox:
     - Ephemeral container with strict egress proxy whitelist''';

    const slaMatrix = '''
OPERATIONAL SLA & GOVERNANCE MATRIX:

Metric                     Target SLA         Violation Penalty
─────────────────────────────────────────────────────────────
Execution Timeout          < 4.5 seconds      Automatic Rollback
Tool Call Authorization    100% Policy Match  Immediate Halt
Audit Trail Retention      7 Years Encrypted  Compliance Incident
Human Approval on Writes   Mandatory (Tier 1) Block Execution''';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 10.0,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 9.0,
                    height: 9.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 9.0,
                    height: 9.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 9.0,
                    height: 9.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    'CLIENT ADVISORY DELIVERABLE',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabButton(
                    label: 'Memo',
                    isSelected: viewModel.activeDeliverableTab == 0,
                    onTap: () => viewModel.setDeliverableTab(0),
                  ),
                  const SizedBox(width: 6.0),
                  _buildTabButton(
                    label: 'RFC',
                    isSelected: viewModel.activeDeliverableTab == 1,
                    onTap: () => viewModel.setDeliverableTab(1),
                  ),
                  const SizedBox(width: 6.0),
                  _buildTabButton(
                    label: 'SLA Matrix',
                    isSelected: viewModel.activeDeliverableTab == 2,
                    onTap: () => viewModel.setDeliverableTab(2),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1.0,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                viewModel.activeDeliverableTab == 0
                    ? executiveBrief
                    : (viewModel.activeDeliverableTab == 1
                        ? topologyRfc
                        : slaMatrix),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  height: 1.5,
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF383832) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF94A3B8),
            fontSize: 10.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildContentBlocks(
    BuildContext context,
    AdviseBetterViewModel viewModel,
    List<ContentBlockModel> blocks,
  ) {
    return Column(
      children: blocks.map((block) {
        final bool isDone = viewModel.completedActions.contains(block.title);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: block.cardBackgroundColor,
              borderRadius: BorderRadius.circular(22.0),
              boxShadow: AppColors.softShadow,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        block.tagLabel,
                        style: TextStyle(
                          color: block.accentColor,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    if (isDone)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_rounded,
                                size: 12.0, color: Color(0xFF059669)),
                            SizedBox(width: 4.0),
                            Text(
                              'APPROVED',
                              style: TextStyle(
                                color: Color(0xFF059669),
                                fontSize: 9.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Icon(block.icon, size: 18.0, color: block.accentColor),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        block.title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepInk,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  block.description,
                  style: const TextStyle(
                    color: AppColors.roomCardSubtext,
                    fontSize: 12.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      viewModel.markActionDone(block.title);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isDone
                              ? '${block.title} reset.'
                              : '${block.title} completed and added to client packet!'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 6.5,
                      ),
                      decoration: BoxDecoration(
                        color: isDone ? block.accentColor : AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: isDone
                              ? block.accentColor
                              : const Color(0xFFEDE7F2),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        isDone ? 'Approved ✓' : block.buttonLabel,
                        style: TextStyle(
                          color: isDone ? Colors.white : block.accentColor,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGovernanceChecklistCard(
      BuildContext context, AdviseBetterViewModel viewModel) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.playlist_add_check_circle_rounded,
                  color: Color(0xFF059669),
                  size: 16.0,
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                'PRODUCTION HARDENING CHECKLIST',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          ...viewModel.governanceChecklist.entries.map((entry) {
            final isChecked = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  viewModel.toggleChecklistItem(entry.key);
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      margin: const EdgeInsets.only(top: 1.0),
                      decoration: BoxDecoration(
                        color: isChecked
                            ? const Color(0xFF059669)
                            : Colors.transparent,
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
                              color: Colors.white,
                              size: 14.0,
                            )
                          : null,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.4,
                          color: AppColors.deepInk,
                          fontWeight:
                              isChecked ? FontWeight.w600 : FontWeight.normal,
                          decoration: isChecked
                              ? TextDecoration.none
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCompletionPill(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ContextualConnectionView()),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 13.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.royalIndigo,
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: AppColors.buttonShadow,
              ),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.hub_rounded,
                        color: AppColors.pureWhite, size: 18.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Next: Contextual Connection ➔',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextButton.icon(
          onPressed: () {
            HapticFeedback.heavyImpact();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LabCompleteView()),
            );
          },
          icon: const Icon(Icons.emoji_events_rounded,
              size: 15.0, color: AppColors.softGreen),
          label: const Text(
            'Skip directly to Lab Complete (+50 XP)',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
