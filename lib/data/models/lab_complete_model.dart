import 'package:flutter/material.dart';

class CompletedStageSummary {
  final int stageNumber;
  final String title;
  final String summary;
  final IconData icon;

  const CompletedStageSummary({
    required this.stageNumber,
    required this.title,
    required this.summary,
    required this.icon,
  });
}

class LabCompleteModel {
  final String labTitle;
  final String domainTag;
  final int xpEarned;
  final double fluencyGain;
  final String credentialName;
  final String credentialId;
  final String issuedDate;
  final List<CompletedStageSummary> stages;
  final String nextLabTitle;
  final String nextLabSubtitle;

  const LabCompleteModel({
    required this.labTitle,
    required this.domainTag,
    required this.xpEarned,
    required this.fluencyGain,
    required this.credentialName,
    required this.credentialId,
    required this.issuedDate,
    required this.stages,
    required this.nextLabTitle,
    required this.nextLabSubtitle,
  });
}
