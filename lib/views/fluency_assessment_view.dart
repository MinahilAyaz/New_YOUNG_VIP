import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/fluency_assessment_model.dart';
import '../viewmodels/fluency_assessment_view_model.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'assessment_result_view.dart';

class FluencyAssessmentView extends StatelessWidget {
  final VoidCallback? onCompleted;

  const FluencyAssessmentView({
    super.key,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FluencyAssessmentViewModel>(
      create: (_) => FluencyAssessmentViewModel(),
      child: const _FluencyAssessmentContent(),
    );
  }
}

class _FluencyAssessmentContent extends StatelessWidget {
  const _FluencyAssessmentContent();

  void _handleComplete(BuildContext context, FluencyAssessmentViewModel vm) {
    HapticFeedback.heavyImpact();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => _CelebrationDialog(
        onViewResults: () {
          Navigator.pop(dialogCtx);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AssessmentResultView(),
            ),
          );
        },
      ),
    );
  }

  void _handleSkip(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AssessmentResultView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : (screenWidth < 360 ? 14.0 : 20.0);
    final vm = context.watch<FluencyAssessmentViewModel>();
    final currentQ = vm.currentQuestion;

    return Scaffold(
      backgroundColor: AppColors.bananiBackground,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620.0),
            child: Column(
              children: [
                // Executive Top Navigation Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 10.0,
                  ),
                  child: _buildExecutiveTopBar(context, vm),
                ),

                // Scrollable Diagnostic Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 6.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDiagnosticHeader(context, vm),
                        const SizedBox(height: 14.0),
                        _buildTelemetryCard(context, vm),
                        const SizedBox(height: 16.0),
                        _buildArchitecturalCaseCard(context, currentQ, vm),
                        const SizedBox(height: 18.0),
                        _buildOptionsSection(context, currentQ, vm),
                        const SizedBox(height: 18.0),
                        _buildQuestionMatrixBar(context, vm),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildExecutiveBottomDock(context, vm),
    );
  }

  Widget _buildExecutiveTopBar(
      BuildContext context, FluencyAssessmentViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            const SizedBox(width: 12.0),
            const YoungVipWordmark(),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bookmark / Flag for Review Chip
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                vm.toggleFlagCurrentQuestion();
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 7.0,
                ),
                decoration: BoxDecoration(
                  color: vm.isCurrentFlagged
                      ? const Color(0xFFFEF3C7)
                      : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: AppColors.buttonShadow,
                  border: Border.all(
                    color: vm.isCurrentFlagged
                        ? const Color(0xFFF59E0B)
                        : AppColors.cardBorder,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      vm.isCurrentFlagged
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 14.0,
                      color: vm.isCurrentFlagged
                          ? const Color(0xFFD97706)
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      vm.isCurrentFlagged ? 'Flagged' : 'Flag for Review',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: vm.isCurrentFlagged
                            ? const Color(0xFFB45309)
                            : AppColors.deepInk,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            // Skip Button with Key
            TextButton(
              key: const Key('fluency_skip_button'),
              onPressed: () => _handleSkip(context),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.pureWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13.0,
                  vertical: 7.0,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(
                    color: AppColors.cardBorder,
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDiagnosticHeader(
      BuildContext context, FluencyAssessmentViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode Badge
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: AppColors.bananiLavender,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColors.bananiPrimary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: const BoxDecoration(
                      color: AppColors.bananiPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Text(
                    'ASSESSMENT MODE · ADAPTIVE BENCHMARK',
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
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'AI Engineering Fluency Diagnostic',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Calibrate your production fluency across Agent Governance, Prompt Forensics & Enterprise RAG.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildTelemetryCard(
      BuildContext context, FluencyAssessmentViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: AppColors.softShadow,
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Telemetry Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
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
                        color: AppColors.bananiPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'QUESTION 0${vm.currentIndex + 1} OF 0${vm.totalQuestions}',
                        style: const TextStyle(
                          color: AppColors.bananiPrimary,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
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
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            size: 13.0,
                            color: Color(0xFFD97706),
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '+150 XP BENCHMARK REWARD',
                            style: TextStyle(
                              color: Color(0xFFB45309),
                              fontSize: 9.5,
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
              const SizedBox(width: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 13.0,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '~${vm.session.estimatedMinutes} min',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Multi-Segment Interactive Progress Track
          Row(
            children: List.generate(vm.totalQuestions, (index) {
              final isCurrent = index == vm.currentIndex;
              final isAnswered = vm.isQuestionAnswered(index);
              final isFlagged = vm.isQuestionFlagged(index);

              Color barColor;
              if (isFlagged) {
                barColor = const Color(0xFFF59E0B);
              } else if (isAnswered) {
                barColor = AppColors.softGreen;
              } else if (isCurrent) {
                barColor = AppColors.bananiPrimary;
              } else {
                barColor = const Color(0xFFE2E8F0);
              }

              return Expanded(
                child: Container(
                  height: 6.0,
                  margin: EdgeInsets.only(
                    right: index < vm.totalQuestions - 1 ? 6.0 : 0.0,
                  ),
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.bananiPrimary.withValues(alpha: 0.35),
                              blurRadius: 4.0,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8.0),

          // Progress Status Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status: ${vm.totalAnsweredCount} of ${vm.totalQuestions} answered',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(vm.progressRatio * 100).toInt()}% completed',
                style: const TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArchitecturalCaseCard(BuildContext context,
      AssessmentQuestion question, FluencyAssessmentViewModel vm) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: AppColors.softShadow,
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Domain Badge & Difficulty Level Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9.0,
                        vertical: 4.5,
                      ),
                      decoration: BoxDecoration(
                        color: question.accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            question.icon,
                            size: 13.0,
                            color: question.accentColor,
                          ),
                          const SizedBox(width: 5.0),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                question.domain.toUpperCase(),
                                style: TextStyle(
                                  color: question.accentColor,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        '${question.difficulty} DIFFICULTY',
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Real-World Scenario Box with Left Accent Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14.0),
              border: const Border(
                left: BorderSide(
                  color: AppColors.bananiPrimary,
                  width: 3.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.architecture_rounded,
                      size: 14.0,
                      color: AppColors.deepInk,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      'REAL-WORLD ENTERPRISE SCENARIO',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7.0),
                Text(
                  question.scenarioText,
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 13.0,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // macOS Styled Code / Schema Box
          if (question.codeSnippet != null) ...[
            const SizedBox(height: 12.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF181B20),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0xFF2D3748),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Code Window Header with 3 dots
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 7.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1F242D),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.0),
                        topRight: Radius.circular(11.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'SYSTEM ARTIFACT INSPECTION',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Code Content
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        question.codeSnippet!,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: Color(0xFF38BDF8),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16.0),

          // Architectural Decision Required Prompt
          const Text(
            'ARCHITECTURAL DECISION REQUIRED:',
            style: TextStyle(
              color: AppColors.bananiPrimary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            question.questionText,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context, AssessmentQuestion question,
      FluencyAssessmentViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'SELECT THE OPTIMAL ARCHITECTURAL STRATEGY',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        ...question.options.map((option) {
          final isSelected = vm.currentSelectedOptionId == option.id;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                vm.selectOption(option.id);
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.bananiLavender
                      : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.bananiPrimary
                        : AppColors.cardBorder,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.bananiPrimary.withValues(alpha: 0.15),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3.0),
                          ),
                        ]
                      : AppColors.buttonShadow,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Option ID Bubble ('A', 'B', 'C', 'D')
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.bananiPrimary
                            : const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.bananiPrimary
                              : const Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        option.id,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF475569),
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        option.text,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.deepInk
                              : const Color(0xFF334155),
                          fontSize: 13.0,
                          height: 1.45,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8.0),
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.bananiPrimary,
                        size: 20.0,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildQuestionMatrixBar(
      BuildContext context, FluencyAssessmentViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Question Navigator:',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: List.generate(vm.totalQuestions, (index) {
              final isCurrent = index == vm.currentIndex;
              final isAnswered = vm.isQuestionAnswered(index);
              final isFlagged = vm.isQuestionFlagged(index);

              Color circleBg;
              Color circleBorder;
              Color textColor;

              if (isCurrent) {
                circleBg = AppColors.bananiPrimary;
                circleBorder = AppColors.bananiPrimary;
                textColor = Colors.white;
              } else if (isFlagged) {
                circleBg = const Color(0xFFFEF3C7);
                circleBorder = const Color(0xFFF59E0B);
                textColor = const Color(0xFFB45309);
              } else if (isAnswered) {
                circleBg = AppColors.bananiSuccessSoft;
                circleBorder = AppColors.softGreen;
                textColor = const Color(0xFF047857);
              } else {
                circleBg = const Color(0xFFF8FAFC);
                circleBorder = const Color(0xFFCBD5E1);
                textColor = const Color(0xFF64748B);
              }

              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  vm.goToQuestion(index);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: circleBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: circleBorder, width: 1.3),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.bananiPrimary.withValues(alpha: 0.3),
                              blurRadius: 4.0,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExecutiveBottomDock(
      BuildContext context, FluencyAssessmentViewModel vm) {
    final bool isLast = vm.isLastQuestion;
    final bool canSubmit = vm.isCurrentAnswered || vm.totalAnsweredCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10.0,
            offset: const Offset(0, -3),
          ),
        ],
        border: const Border(
          top: BorderSide(
            color: AppColors.cardBorder,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620.0),
            child: Row(
              children: [
                // Previous Question Button
                if (!vm.isFirstQuestion) ...[
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      vm.previousQuestion();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 13.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: const Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            size: 16.0,
                            color: AppColors.deepInk,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                ],

                // Next or Complete Benchmark Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isLast) {
                        _handleComplete(context, vm);
                      } else {
                        HapticFeedback.mediumImpact();
                        vm.nextQuestion();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        color: isLast
                            ? AppColors.bananiPrimary
                            : (canSubmit
                                ? AppColors.deepInk
                                : const Color(0xFF94A3B8)),
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: (isLast
                                    ? AppColors.bananiPrimary
                                    : AppColors.deepInk)
                                .withValues(alpha: 0.22),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3.0),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLast
                                  ? 'Submit & View Benchmark Result (+150 XP) ➔'
                                  : 'Next Question ➔',
                              style: const TextStyle(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CelebrationDialog extends StatelessWidget {
  final VoidCallback onViewResults;

  const _CelebrationDialog({required this.onViewResults});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.pureWhite,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      contentPadding: const EdgeInsets.all(22.0),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380.0),
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
                Icons.emoji_events_rounded,
                color: Color(0xFFD97706),
                size: 36.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Diagnostic Complete!',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Your skill matrix and fluency benchmark have been calculated. You earned +150 XP and unlocked your personalized learning pathway.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 6.0,
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
                    Icons.verified_rounded,
                    size: 14.0,
                    color: Color(0xFF059669),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '+150 XP Credited to Profile',
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: onViewResults,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiPrimary,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bananiPrimary.withValues(alpha: 0.25),
                      blurRadius: 10.0,
                      offset: const Offset(0, 4.0),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'View Official Benchmark Result ➔',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
