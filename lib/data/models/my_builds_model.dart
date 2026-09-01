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

  const BuildItemModel({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
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
