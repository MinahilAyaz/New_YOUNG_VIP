import 'package:flutter/material.dart';

class BuildStatModel {
  final String value;
  final String label;
  final Color color;

  const BuildStatModel({
    required this.value,
    required this.label,
    required this.color,
  });
}

class BuildItemModel {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final IconData icon;
  final String status;
  final Color statusBg;
  final Color statusText;
  final String metrics;

  const BuildItemModel({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    this.icon = Icons.bolt_rounded,
    this.status = 'DEPLOYED',
    this.statusBg = const Color(0xFFD1FAE5),
    this.statusText = const Color(0xFF065F46),
    this.metrics = '180ms · 99.4% Accuracy',
  });
}

class MyBuildsModel {
  final String title;
  final List<BuildStatModel> stats;
  final List<BuildItemModel> buildItems;

  const MyBuildsModel({
    required this.title,
    required this.stats,
    required this.buildItems,
  });
}
