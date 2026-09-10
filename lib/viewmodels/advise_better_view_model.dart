import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../data/models/lab_stage_screen_model.dart';

class AdviseBetterViewModel extends BaseViewModel {
  final AdviseBetterStageModel _stageData;

  int _activeDeliverableTab = 0; // 0 = Executive Brief, 1 = Topology RFC, 2 = SLA Matrix
  final Set<String> _completedActions = {};
  final Map<String, bool> _governanceChecklist = {
    'Mandatory XML Delimiter Fence on all user inputs': true,
    'Independent Verifier Guard for destructive tools': true,
    'Human-in-the-loop approval on database modifications': false,
    'Immutable telemetry audit log stored in encrypted cold storage': true,
    'Rate-limiting & timeout SLAs on autonomous tool loops': true,
  };

  AdviseBetterViewModel()
      : _stageData = const AdviseBetterStageModel(
          stageTitle: 'Advise Better',
          labTagLabel: 'STAGE 04 • AI AGENTS LAB',
          objective:
              'Synthesize your technical discoveries from Build, Break, and Understand into executive-ready strategic recommendations, architectural hardening deliverables, and enterprise governance policies.',
          advisorySummary:
              'Enterprise Executive Deliverable: Hardened agent governance specification eliminating prompt contamination vectors, enforcing dual-agent verification topologies, and establishing quantifiable operational SLAs.',
          steps: [
            StageStepModel(label: 'Build', isActive: false),
            StageStepModel(label: 'Break', isActive: false),
            StageStepModel(label: 'Understand', isActive: false),
            StageStepModel(label: 'Advise', isActive: true),
          ],
          contentBlocks: [
            ContentBlockModel(
              tagLabel: 'EXECUTIVE BRIEF',
              icon: Icons.article_outlined,
              title: 'Client Risk Assessment Memo',
              description:
                  'Translate technical prompt leakage and tool escalation into board-level financial, regulatory, and legal liability terms.',
              buttonLabel: 'Draft Memo',
              accentColor: Color(0xFF6366F1),
              cardBackgroundColor: Color(0xFFEEF2FF),
            ),
            ContentBlockModel(
              tagLabel: 'ARCHITECTURE RFC',
              icon: Icons.architecture_rounded,
              title: 'Hardened Production Topology Blueprint',
              description:
                  'Provide engineering blueprints for dual-agent verification, input sanitizers, and token execution budgets.',
              buttonLabel: 'Generate RFC',
              accentColor: Color(0xFF059669),
              cardBackgroundColor: Color(0xFFECFDF5),
            ),
            ContentBlockModel(
              tagLabel: 'POLICY MATRIX',
              icon: Icons.checklist_rtl_rounded,
              title: 'Enterprise Guardrail & Governance Matrix',
              description:
                  'Establish audit trail requirements, human-in-the-loop thresholds, and compliance sign-off protocols.',
              buttonLabel: 'Review Matrix',
              accentColor: Color(0xFF8B5CF6),
              cardBackgroundColor: Color(0xFFF5F3FF),
            ),
            ContentBlockModel(
              tagLabel: 'STAKEHOLDER DEFENSE',
              icon: Icons.record_voice_over_rounded,
              title: 'Executive Presentation Simulation',
              description:
                  'Simulate defending your mitigation roadmap against CFO budget pushback and CTO operational latency concerns.',
              buttonLabel: 'Simulate Defense',
              accentColor: Color(0xFFD97706),
              cardBackgroundColor: Color(0xFFFFFBEB),
            ),
          ],
        ) {
    setIdle();
  }

  AdviseBetterStageModel get stageData => _stageData;
  int get activeDeliverableTab => _activeDeliverableTab;
  Set<String> get completedActions => _completedActions;
  Map<String, bool> get governanceChecklist => _governanceChecklist;

  void setDeliverableTab(int index) {
    _activeDeliverableTab = index;
    notifyListeners();
  }

  void toggleChecklistItem(String key) {
    if (_governanceChecklist.containsKey(key)) {
      _governanceChecklist[key] = !(_governanceChecklist[key] ?? false);
      notifyListeners();
    }
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
