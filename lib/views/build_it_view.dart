import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/lab_stage_screen_model.dart';
import '../viewmodels/build_it_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'break_it_view.dart';

class BuildItView extends StatelessWidget {
  final bool isRootTab;

  const BuildItView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuildItViewModel>(
      create: (_) => BuildItViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.peachBackground,
        drawer: const CustomDrawer(),
        body: Consumer<BuildItViewModel>(
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
                          _buildObjectiveCard(stageData.objective),
                          const SizedBox(height: 18.0),
                          _buildStepper(context, stageData.steps),
                          const SizedBox(height: 20.0),
                          _buildConfigQuickToggles(context, viewModel),
                          const SizedBox(height: 20.0),
                          _buildContentBlocks(context, viewModel, stageData.contentBlocks),
                          const SizedBox(height: 18.0),
                          _buildCodeManifestPreview(context, viewModel),
                          const SizedBox(height: 24.0),
                          _buildProceedPill(context),
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

  Widget _buildHeader(BuildItStageModel stageData) {
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
                color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                'ACTIVE SPRINT',
                style: TextStyle(
                  color: Color(0xFF4F46E5),
                  fontSize: 9.5,
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
            color: AppColors.pastelSage,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            stageData.labTagLabel,
            style: const TextStyle(
              color: AppColors.pastelSageText,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildObjectiveCard(String objective) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.track_changes_rounded,
              color: Color(0xFF4F46E5),
              size: 18.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STAGE OBJECTIVE',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  objective,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: AppColors.deepInk,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                // If tapping Break It stage, navigate to it
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BreakItView(),
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
                          : (index == 1
                              ? const Color(0xFFD49B85)
                              : AppColors.borderLight),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    step.label,
                    style: TextStyle(
                      color: isCurrent
                          ? AppColors.deepInk
                          : (index == 1
                              ? const Color(0xFFD49B85)
                              : AppColors.roomCardSubtext),
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

  Widget _buildConfigQuickToggles(
      BuildContext context, BuildItViewModel viewModel) {
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
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 6.0,
            children: [
              const Text(
                'AGENT RUNTIME CONFIG',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'SANDBOX READY',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _buildToggleRow(
            icon: Icons.memory_rounded,
            title: 'Vector Knowledge Memory',
            subtitle: 'Embeds multi-document context buffer',
            value: viewModel.isVectorMemoryEnabled,
            onChanged: (_) => viewModel.toggleVectorMemory(),
          ),
          const Divider(height: 18.0, color: Color(0xFFF1F5F9)),
          _buildToggleRow(
            icon: Icons.replay_circle_filled_rounded,
            title: 'Deterministic Auto-Retry',
            subtitle: 'Graceful fallback on tool timeout or schema error',
            value: viewModel.isAutoFallbackEnabled,
            onChanged: (_) => viewModel.toggleAutoFallback(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18.0, color: AppColors.deepInk),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepInk,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            activeThumbColor: AppColors.deepInk,
            activeTrackColor: const Color(0xFFDDC6F5),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildContentBlocks(
    BuildContext context,
    BuildItViewModel viewModel,
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
                              'CONFIGURED',
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
                              : '${block.title} configured successfully!'),
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
                        isDone ? 'Configured ✓' : block.buttonLabel,
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

  Widget _buildCodeManifestPreview(
      BuildContext context, BuildItViewModel viewModel) {
    const yamlCode = '''
agent:
  id: "contract_auditor_v1"
  model: "gemini-1.5-pro"
  temperature: 0.20
  system_instructions: |
    You are an expert enterprise legal contract auditor.
    Verify clauses, extract obligations, and flag indemnity risks.
  tools:
    - name: "vector_knowledge_retrieval"
      type: "semantic_search"
    - name: "clause_risk_analyzer"
      type: "schema_validator"
  guardrails:
    max_output_tokens: 2048
    pii_redaction: true
    deterministic_fallback: true''';

    const pythonCode = '''
from young_vip.labs import AgentRunner, ToolRouter

class ContractAuditor(AgentRunner):
    model = "gemini-1.5-pro"
    temperature = 0.2
    
    def setup_tools(self):
        self.tools = ToolRouter([
            "vector_knowledge_retrieval",
            "clause_risk_analyzer"
        ])
        
    async def run_benchmark(self, prompt: str):
        return await self.execute(prompt)''';

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
                    'BUILD RUNNER SCAFFOLD',
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
                  _buildCodeTabButton(
                    label: 'YAML',
                    isSelected: viewModel.activeCodeTab == 0,
                    onTap: () => viewModel.setCodeTab(0),
                  ),
                  const SizedBox(width: 6.0),
                  _buildCodeTabButton(
                    label: 'Python',
                    isSelected: viewModel.activeCodeTab == 1,
                    onTap: () => viewModel.setCodeTab(1),
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
                viewModel.activeCodeTab == 0 ? yamlCode : pythonCode,
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

  Widget _buildCodeTabButton({
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

  Widget _buildProceedPill(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
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
            horizontal: 24.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.deepInk,
            borderRadius: BorderRadius.circular(28.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepInk.withValues(alpha: 0.22),
                blurRadius: 18.0,
                offset: const Offset(0, 6.0),
              ),
            ],
          ),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Complete Stage & Proceed to Break It →',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
