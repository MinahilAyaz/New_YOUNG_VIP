import 'package:flutter/material.dart';

class LabModel {
  final String title;
  final String tagLabel;
  final Color tagBackgroundColor;
  final Color tagTextColor;
  final Color accentColor;

  const LabModel({
    required this.title,
    required this.tagLabel,
    required this.tagBackgroundColor,
    required this.tagTextColor,
    required this.accentColor,
  });
}
