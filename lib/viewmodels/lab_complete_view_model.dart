import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../data/models/lab_complete_model.dart';

class LabCompleteViewModel extends BaseViewModel {
  final LabCompleteModel _completionData;
  bool _isCredentialSaved = false;

  LabCompleteViewModel()
      : _completionData = const LabCompleteModel(
          labTitle: 'AI Agents Workflow & Hardening',
          domainTag: 'AI AGENTS & GOVERNANCE',
          xpEarned: 50,
          fluencyGain: 4.2,
          credentialName: 'AI Systems Architect — Level 1',
          credentialId: 'YVIP-LAB-8924-ARCH',
          issuedDate: 'September 2026',
          stages: [
            CompletedStageSummary(
              stageNumber: 1,
              title: 'Build It',
              summary: 'Assembled autonomous multi-tool agent pipeline',
              icon: Icons.construction_rounded,
            ),
            CompletedStageSummary(
              stageNumber: 2,
              title: 'Break It',
              summary: 'Induced and verified prompt injection override',
              icon: Icons.bug_report_rounded,
            ),
            CompletedStageSummary(
              stageNumber: 3,
              title: 'Understand It',
              summary: 'Diagnosed telemetry & delimiter separation failures',
              icon: Icons.psychology_rounded,
            ),
            CompletedStageSummary(
              stageNumber: 4,
              title: 'Advise Better',
              summary: 'Delivered production RFC & governance SLA memo',
              icon: Icons.record_voice_over_rounded,
            ),
          ],
          nextLabTitle: 'RAG Knowledge Engine & Vector Indexing',
          nextLabSubtitle: 'Scale multi-document hybrid retrieval with Milvus & Cohere',
        ) {
    setIdle();
  }

  LabCompleteModel get completionData => _completionData;
  bool get isCredentialSaved => _isCredentialSaved;

  void toggleSaveCredential() {
    _isCredentialSaved = !_isCredentialSaved;
    notifyListeners();
  }
}
