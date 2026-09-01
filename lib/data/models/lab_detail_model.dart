import 'package:flutter/material.dart';

class LabStageModel {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const LabStageModel({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}

class LabDetailModel {
  final String title;
  final String tagLabel;
  final String description;
  final List<LabStageModel> stages;
  final int professionalsCount;
  final String unlockNote;

  const LabDetailModel({
    required this.title,
    required this.tagLabel,
    required this.description,
    required this.stages,
    required this.professionalsCount,
    required this.unlockNote,
  });
}
