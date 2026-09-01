import 'package:flutter/material.dart';

class StudioStatusItemModel {
  final String title;
  final int count;
  final Color countColor;

  const StudioStatusItemModel({
    required this.title,
    required this.count,
    required this.countColor,
  });
}

class ExpertStudioModel {
  final String screenTitle;
  final String tagLabel;
  final String description;
  final String buttonLabel;
  final List<StudioStatusItemModel> statusItems;

  const ExpertStudioModel({
    required this.screenTitle,
    required this.tagLabel,
    required this.description,
    required this.buttonLabel,
    required this.statusItems,
  });
}
