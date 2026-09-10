import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../data/models/lab_stage_screen_model.dart';

class BuildItViewModel extends BaseViewModel {
  final BuildItStageModel _stageData;

  bool _isVectorMemoryEnabled = true;
  bool _isAutoFallbackEnabled = true;
  double _temperature = 0.2;
  int _activeCodeTab = 0; // 0 = YAML, 1 = Python
  final Set<String> _completedActions = {};

  BuildItViewModel()
      : _stageData = const BuildItStageModel(
          stageTitle: 'Build It',
          labTagLabel: 'STAGE 01 • AI AGENTS LAB',
          objective:
              'Assemble your autonomous agent pipeline. Configure tool schemas, set deterministic fallback guardrails, and run initial sandbox execution tests before stress testing.',
          steps: [
            StageStepModel(label: 'Build', isActive: true),
            StageStepModel(label: 'Break', isActive: false),
            StageStepModel(label: 'Understand', isActive: false),
            StageStepModel(label: 'Advise', isActive: false),
          ],
          contentBlocks: [
            ContentBlockModel(
              tagLabel: 'ARCHITECTURE',
              icon: Icons.schema_rounded,
              title: 'Agent Persona & Tool Declaration',
              description:
                  'Define role directives, JSON schema contracts, and parameter boundaries.',
              buttonLabel: 'Configure',
              accentColor: Color(0xFF6366F1),
              cardBackgroundColor: Color(0xFFEEF2FF),
            ),
            ContentBlockModel(
              tagLabel: 'PIPELINE',
              icon: Icons.hub_rounded,
              title: 'Wire Multi-Tool Router & Memory Buffer',
              description:
                  'Integrate vector knowledge retrieval, SQL query generator, and fallback loop.',
              buttonLabel: 'Assemble',
              accentColor: Color(0xFFD97706),
              cardBackgroundColor: Color(0xFFFFFBEB),
            ),
            ContentBlockModel(
              tagLabel: 'GUARDRAILS',
              icon: Icons.shield_outlined,
              title: 'Define Boundaries & Hallucination Filter',
              description:
                  'Establish token budgets, PII redaction rules, and deterministic retry caps.',
              buttonLabel: 'Set Rules',
              accentColor: Color(0xFF8B5CF6),
              cardBackgroundColor: Color(0xFFF5F3FF),
            ),
            ContentBlockModel(
              tagLabel: 'SANDBOX RUN',
              icon: Icons.play_arrow_rounded,
              title: 'Execute Initial Agent Benchmark Test',
              description:
                  'Run sample prompt in isolated sandbox and inspect execution telemetry.',
              buttonLabel: 'Run Test',
              accentColor: Color(0xFFE57373),
              cardBackgroundColor: Color(0xFFFFF0ED),
            ),
          ],
        ) {
    setIdle();
  }

  BuildItStageModel get stageData => _stageData;
  bool get isVectorMemoryEnabled => _isVectorMemoryEnabled;
  bool get isAutoFallbackEnabled => _isAutoFallbackEnabled;
  double get temperature => _temperature;
  int get activeCodeTab => _activeCodeTab;
  Set<String> get completedActions => _completedActions;

  void toggleVectorMemory() {
    _isVectorMemoryEnabled = !_isVectorMemoryEnabled;
    notifyListeners();
  }

  void toggleAutoFallback() {
    _isAutoFallbackEnabled = !_isAutoFallbackEnabled;
    notifyListeners();
  }

  void setTemperature(double val) {
    _temperature = val;
    notifyListeners();
  }

  void setCodeTab(int index) {
    _activeCodeTab = index;
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
