import 'package:flutter/material.dart';

class StageStepModel {
  final String label;
  final bool isActive;

  const StageStepModel({
    required this.label,
    required this.isActive,
  });
}

class ContentBlockModel {
  final String tagLabel;
  final IconData icon;
  final String title;
  final String description;
  final String buttonLabel;
  final Color accentColor;
  final Color cardBackgroundColor;

  const ContentBlockModel({
    required this.tagLabel,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.accentColor,
    required this.cardBackgroundColor,
  });
}

class BreakItStageModel {
  final String stageTitle;
  final String labTagLabel;
  final List<StageStepModel> steps;
  final List<ContentBlockModel> contentBlocks;

  const BreakItStageModel({
    required this.stageTitle,
    required this.labTagLabel,
    required this.steps,
    required this.contentBlocks,
  });
}

class BuildItStageModel {
  final String stageTitle;
  final String labTagLabel;
  final String objective;
  final List<StageStepModel> steps;
  final List<ContentBlockModel> contentBlocks;

  const BuildItStageModel({
    required this.stageTitle,
    required this.labTagLabel,
    required this.objective,
    required this.steps,
    required this.contentBlocks,
  });
}

class UnderstandItStageModel {
  final String stageTitle;
  final String labTagLabel;
  final String objective;
  final String rootCauseSummary;
  final List<StageStepModel> steps;
  final List<ContentBlockModel> contentBlocks;

  const UnderstandItStageModel({
    required this.stageTitle,
    required this.labTagLabel,
    required this.objective,
    required this.rootCauseSummary,
    required this.steps,
    required this.contentBlocks,
  });
}

class AdviseBetterStageModel {
  final String stageTitle;
  final String labTagLabel;
  final String objective;
  final String advisorySummary;
  final List<StageStepModel> steps;
  final List<ContentBlockModel> contentBlocks;

  const AdviseBetterStageModel({
    required this.stageTitle,
    required this.labTagLabel,
    required this.objective,
    required this.advisorySummary,
    required this.steps,
    required this.contentBlocks,
  });
}



