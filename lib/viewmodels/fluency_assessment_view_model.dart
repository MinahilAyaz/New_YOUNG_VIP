import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/assessment_result_model.dart';
import '../data/models/fluency_assessment_model.dart';

class FluencyAssessmentViewModel extends BaseViewModel {
  final FluencyAssessmentSession session;

  int _currentIndex = 0;
  final Map<int, String> _selectedAnswers = {};
  final Set<int> _flaggedQuestions = {};
  final bool _isSubmitting = false;

  FluencyAssessmentViewModel({FluencyAssessmentSession? session})
      : session = session ?? FluencyAssessmentSession.createDefault();

  int get currentIndex => _currentIndex;
  AssessmentQuestion get currentQuestion => session.questions[_currentIndex];
  int get totalQuestions => session.questions.length;
  Map<int, String> get selectedAnswers => Map.unmodifiable(_selectedAnswers);
  Set<int> get flaggedQuestions => Set.unmodifiable(_flaggedQuestions);
  bool get isSubmitting => _isSubmitting;

  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == session.questions.length - 1;

  bool get isCurrentAnswered => _selectedAnswers.containsKey(_currentIndex);
  String? get currentSelectedOptionId => _selectedAnswers[_currentIndex];
  bool get isCurrentFlagged => _flaggedQuestions.contains(_currentIndex);

  int get totalAnsweredCount => _selectedAnswers.length;
  double get progressRatio =>
      totalQuestions == 0 ? 0.0 : _selectedAnswers.length / totalQuestions;

  bool isQuestionAnswered(int index) => _selectedAnswers.containsKey(index);
  bool isQuestionFlagged(int index) => _flaggedQuestions.contains(index);

  void selectOption(String optionId) {
    _selectedAnswers[_currentIndex] = optionId;
    notifyListeners();
  }

  void toggleFlagCurrentQuestion() {
    if (_flaggedQuestions.contains(_currentIndex)) {
      _flaggedQuestions.remove(_currentIndex);
    } else {
      _flaggedQuestions.add(_currentIndex);
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < session.questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < session.questions.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  AssessmentResultModel calculateAssessmentResult() {
    int correctCount = 0;

    // Track domain results
    final Map<String, List<bool>> domainResults = {};

    for (int i = 0; i < session.questions.length; i++) {
      final q = session.questions[i];
      final userAns = _selectedAnswers[i];
      final isCorrect =
          userAns != null && q.options.any((o) => o.id == userAns && o.isCorrect);

      if (isCorrect) {
        correctCount++;
      }

      domainResults.putIfAbsent(q.domain, () => []).add(isCorrect);
    }

    final int calculatedScore =
        totalQuestions == 0 ? 0 : ((correctCount / totalQuestions) * 100).round();

    // Map score to fluency tier and percentile
    final String tier;
    final String percentile;
    if (calculatedScore >= 90) {
      tier = 'Senior Builder · Level 14';
      percentile = 'Top 3.8% Worldwide';
    } else if (calculatedScore >= 75) {
      tier = 'Associate Builder · Level 9';
      percentile = 'Top 16.5% Worldwide';
    } else if (calculatedScore >= 50) {
      tier = 'Practitioner · Level 6';
      percentile = 'Top 38.2% Worldwide';
    } else {
      tier = 'Apprentice Builder · Level 3';
      percentile = 'Top 65.0% Worldwide';
    }

    final List<DomainScoreModel> domainScores = [
      DomainScoreModel(
        domainName: 'AI Agents & Orchestration',
        score: domainResults['AI Agents & Tool Governance']?.any((c) => c) == true
            ? 95
            : 60,
        proficiencyLevel:
            domainResults['AI Agents & Tool Governance']?.any((c) => c) == true
                ? 'Mastery'
                : 'Developing',
        accentColor: AppColors.bananiPrimary,
        icon: Icons.hub_rounded,
      ),
      DomainScoreModel(
        domainName: 'Prompt Security & Forensics',
        score:
            domainResults['Prompt Security & Forensics']?.any((c) => c) == true
                ? 92
                : 58,
        proficiencyLevel:
            domainResults['Prompt Security & Forensics']?.any((c) => c) == true
                ? 'Expert'
                : 'Developing',
        accentColor: AppColors.bananiCoral,
        icon: Icons.shield_outlined,
      ),
      DomainScoreModel(
        domainName: 'Enterprise RAG & Context',
        score:
            domainResults['Enterprise RAG & Grounding']?.any((c) => c) == true
                ? 88
                : 55,
        proficiencyLevel:
            domainResults['Enterprise RAG & Grounding']?.any((c) => c) == true
                ? 'Proficient'
                : 'Foundational',
        accentColor: AppColors.youngVipGold,
        icon: Icons.auto_stories_rounded,
      ),
      DomainScoreModel(
        domainName: 'Autonomous Tool Governance',
        score:
            domainResults['Autonomous Tool Governance']?.any((c) => c) == true
                ? 89
                : 52,
        proficiencyLevel:
            domainResults['Autonomous Tool Governance']?.any((c) => c) == true
                ? 'Proficient'
                : 'Foundational',
        accentColor: AppColors.softGreen,
        icon: Icons.gavel_rounded,
      ),
    ];

    return AssessmentResultModel(
      assessmentTitle: 'Enterprise AI Fluency Benchmark',
      assessmentSubtitle:
          'Official Diagnostic · Agentic Systems, RAG & Security',
      completionDate: 'September 2026',
      overallScore: calculatedScore,
      fluencyTier: tier,
      percentileText: percentile,
      timeSpent: '03m 48s',
      totalQuestions: totalQuestions,
      correctAnswers: correctCount,
      domainScores: domainScores,
      topStrengths: const [
        'Deterministic tool-calling boundaries verified with schema checks.',
        'Structural delimiter isolation applied against indirect prompt injection.',
        'Temporal metadata filtering prioritized over raw vector similarity.',
      ],
      growthRecommendations: const [
        'Explore speculative execution to minimize multi-agent loop latency under SLAs.',
        'Implement semantic cache invalidation strategies for hybrid retrieval pipelines.',
      ],
      credentialName: 'Young VIP Certified AI Systems Architect',
      credentialId: 'YVIP-CERT-9140-FL14',
      verificationHash: '0x8F92...B3C1',
      recommendedLabTitle: 'Autonomous Multi-Agent Topology Lab',
      recommendedLabSubtitle:
          'Stage 01 • Build production-grade dual-agent supervision with audit pipelines.',
    );
  }
}
