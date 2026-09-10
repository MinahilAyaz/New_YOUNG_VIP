import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../data/models/lab_stage_screen_model.dart';

class UnderstandItViewModel extends BaseViewModel {
  final UnderstandItStageModel _stageData;

  int _activeInspectorTab = 0; // 0 = Telemetry Trace, 1 = Architectural Pattern
  int _selectedQuizAnswer = -1;
  bool _isQuizSubmitted = false;
  final Set<String> _completedActions = {};

  UnderstandItViewModel()
      : _stageData = const UnderstandItStageModel(
          stageTitle: 'Understand It',
          labTagLabel: 'STAGE 03 • AI AGENTS LAB',
          objective:
              'Dissect the failure mode observed in Break It. Inspect execution telemetry, analyze token attention leakage, and understand why the unhardened agent executed unauthorized operations.',
          rootCauseSummary:
              'Prompt Contamination Vector: Untrusted user input was passed directly into the reasoning context without cryptographic XML delimiters or separate validation checkpoints, allowing the model to confuse user instructions with system directives.',
          steps: [
            StageStepModel(label: 'Build', isActive: false),
            StageStepModel(label: 'Break', isActive: false),
            StageStepModel(label: 'Understand', isActive: true),
            StageStepModel(label: 'Advise', isActive: false),
          ],
          contentBlocks: [
            ContentBlockModel(
              tagLabel: 'DIAGNOSTIC',
              icon: Icons.troubleshoot_rounded,
              title: 'Execution Trace & Tool Calls Analysis',
              description:
                  'Examine timestamps, token allocations, and how the model chose the risky database deletion tool.',
              buttonLabel: 'Inspect Trace',
              accentColor: Color(0xFF6366F1),
              cardBackgroundColor: Color(0xFFEEF2FF),
            ),
            ContentBlockModel(
              tagLabel: 'DEEP DIVE',
              icon: Icons.psychology_rounded,
              title: 'Prompt Injection & Delimiter Boundary',
              description:
                  'Understand how syntactic XML boundaries and dual-prompt separation neutralize user override attempts.',
              buttonLabel: 'Analyze Pattern',
              accentColor: Color(0xFF8B5CF6),
              cardBackgroundColor: Color(0xFFF5F3FF),
            ),
            ContentBlockModel(
              tagLabel: 'COMPARISON',
              icon: Icons.compare_arrows_rounded,
              title: 'Vulnerable vs. Hardened Architecture',
              description:
                  'Side-by-side architectural blueprint contrasting single-agent pipelines with dual-agent verifier topologies.',
              buttonLabel: 'View Diff',
              accentColor: Color(0xFF059669),
              cardBackgroundColor: Color(0xFFECFDF5),
            ),
            ContentBlockModel(
              tagLabel: 'KNOWLEDGE CHECK',
              icon: Icons.verified_user_outlined,
              title: 'Diagnostic Mastery Validation',
              description:
                  'Verify your understanding of failure isolation before creating client executive recommendations.',
              buttonLabel: 'Test Knowledge',
              accentColor: Color(0xFFD97706),
              cardBackgroundColor: Color(0xFFFFFBEB),
            ),
          ],
        ) {
    setIdle();
  }

  UnderstandItStageModel get stageData => _stageData;
  int get activeInspectorTab => _activeInspectorTab;
  int get selectedQuizAnswer => _selectedQuizAnswer;
  bool get isQuizSubmitted => _isQuizSubmitted;
  Set<String> get completedActions => _completedActions;

  void setInspectorTab(int index) {
    _activeInspectorTab = index;
    notifyListeners();
  }

  void selectQuizAnswer(int index) {
    _selectedQuizAnswer = index;
    notifyListeners();
  }

  void submitQuiz() {
    if (_selectedQuizAnswer != -1) {
      _isQuizSubmitted = true;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _selectedQuizAnswer = -1;
    _isQuizSubmitted = false;
    notifyListeners();
  }

  void markActionDone(String title) {
    if (_completedActions.contains(title)) {
      _completedActions.remove(title);
    } else {
      _completedActions.add(title);
    }
    notifyListeners();
  }
}
