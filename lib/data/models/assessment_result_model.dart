import 'package:flutter/material.dart';

class DomainScoreModel {
  final String domainName;
  final int score; // 0 - 100
  final String proficiencyLevel;
  final Color accentColor;
  final IconData icon;

  const DomainScoreModel({
    required this.domainName,
    required this.score,
    required this.proficiencyLevel,
    required this.accentColor,
    required this.icon,
  });
}

class AssessmentResultModel {
  final String assessmentTitle;
  final String assessmentSubtitle;
  final String completionDate;
  final int overallScore; // e.g. 88
  final String fluencyTier;
  final String percentileText;
  final String timeSpent;
  final int totalQuestions;
  final int correctAnswers;
  final List<DomainScoreModel> domainScores;
  final List<String> topStrengths;
  final List<String> growthRecommendations;
  final String credentialName;
  final String credentialId;
  final String verificationHash;
  final String recommendedLabTitle;
  final String recommendedLabSubtitle;

  const AssessmentResultModel({
    required this.assessmentTitle,
    required this.assessmentSubtitle,
    required this.completionDate,
    required this.overallScore,
    required this.fluencyTier,
    required this.percentileText,
    required this.timeSpent,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.domainScores,
    required this.topStrengths,
    required this.growthRecommendations,
    required this.credentialName,
    required this.credentialId,
    required this.verificationHash,
    required this.recommendedLabTitle,
    required this.recommendedLabSubtitle,
  });
}
