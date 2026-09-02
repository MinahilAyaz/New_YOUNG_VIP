import 'package:flutter/material.dart';

class FluencySkillModel {
  final String title;
  final double progress;
  final String badgeLabel;
  final IconData icon;
  final String levelText;
  final String completedCount;
  final Color bgColor;
  final Color textColor;

  const FluencySkillModel({
    required this.title,
    required this.progress,
    required this.badgeLabel,
    this.icon = Icons.bolt_rounded,
    this.levelText = 'Advanced',
    this.completedCount = '4/5 Milestones',
    this.bgColor = const Color(0xFFECE6F4),
    this.textColor = const Color(0xFF7A6A94),
  });
}

class MyFluencyModel {
  final String title;
  final String levelTitle;
  final String levelSubtitle;
  final List<FluencySkillModel> skills;

  const MyFluencyModel({
    required this.title,
    required this.levelTitle,
    required this.levelSubtitle,
    required this.skills,
  });
}
