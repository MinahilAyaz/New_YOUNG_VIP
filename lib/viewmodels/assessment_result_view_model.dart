import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/assessment_result_model.dart';

class AssessmentResultViewModel extends BaseViewModel {
  final AssessmentResultModel _resultData;
  bool _isCredentialSaved = false;
  int _activeTab = 0; // 0 = Overview, 1 = Competency Breakdown, 2 = Next Recommendations

  AssessmentResultViewModel()
      : _resultData = const AssessmentResultModel(
          assessmentTitle: 'Enterprise AI Fluency Benchmark',
          assessmentSubtitle:
              'Official Diagnostic · Agentic Systems, RAG & Security',
          completionDate: 'September 2026',
          overallScore: 91,
          fluencyTier: 'Senior Builder · Level 14',
          percentileText: 'Top 3.8% Worldwide',
          timeSpent: '19m 24s',
          totalQuestions: 30,
          correctAnswers: 28,
          domainScores: [
            DomainScoreModel(
              domainName: 'AI Agents & Orchestration',
              score: 95,
              proficiencyLevel: 'Mastery',
              accentColor: AppColors.bananiPrimary,
              icon: Icons.hub_rounded,
            ),
            DomainScoreModel(
              domainName: 'Prompt Security & Forensics',
              score: 92,
              proficiencyLevel: 'Expert',
              accentColor: AppColors.bananiCoral,
              icon: Icons.shield_outlined,
            ),
            DomainScoreModel(
              domainName: 'Enterprise RAG & Context',
              score: 88,
              proficiencyLevel: 'Proficient',
              accentColor: AppColors.youngVipGold,
              icon: Icons.auto_stories_rounded,
            ),
            DomainScoreModel(
              domainName: 'Autonomous Tool Governance',
              score: 89,
              proficiencyLevel: 'Proficient',
              accentColor: AppColors.softGreen,
              icon: Icons.gavel_rounded,
            ),
          ],
          topStrengths: [
            'Detected recursive XML injection payloads before tool execution.',
            'Architected dual-agent verification topologies with zero token leakage.',
            'Correctly enforced human-in-the-loop escalation thresholds for database writes.',
          ],
          growthRecommendations: [
            'Explore speculative execution to minimize agent loop latency under enterprise SLAs.',
            'Implement semantic cache invalidation strategies for hybrid retrieval pipelines.',
          ],
          credentialName: 'Young VIP Certified AI Systems Architect',
          credentialId: 'YVIP-CERT-9140-FL14',
          verificationHash: '0x8F92...B3C1',
          recommendedLabTitle: 'Autonomous Multi-Agent Topology Lab',
          recommendedLabSubtitle:
              'Stage 01 • Build production-grade dual-agent supervision with audit pipelines.',
        );

  AssessmentResultModel get resultData => _resultData;
  bool get isCredentialSaved => _isCredentialSaved;
  int get activeTab => _activeTab;

  void setActiveTab(int index) {
    _activeTab = index;
    notifyListeners();
  }

  void toggleSaveCredential() {
    _isCredentialSaved = !_isCredentialSaved;
    notifyListeners();
  }
}
