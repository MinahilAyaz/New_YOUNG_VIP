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

class AuthoredLabModel {
  final String title;
  final String status;
  final Color statusBg;
  final Color statusText;
  final String learnersCount;
  final String rating;
  final IconData icon;

  const AuthoredLabModel({
    required this.title,
    required this.status,
    required this.statusBg,
    required this.statusText,
    required this.learnersCount,
    required this.rating,
    this.icon = Icons.bolt_rounded,
  });
}

class ExpertStudioModel {
  final String screenTitle;
  final String tagLabel;
  final String description;
  final String buttonLabel;
  final List<StudioStatusItemModel> statusItems;
  final List<AuthoredLabModel> authoredLabs;

  const ExpertStudioModel({
    required this.screenTitle,
    required this.tagLabel,
    required this.description,
    required this.buttonLabel,
    required this.statusItems,
    this.authoredLabs = const [],
  });
}
