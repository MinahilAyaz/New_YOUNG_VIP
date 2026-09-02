import 'package:flutter/material.dart';

class LabModel {
  final String title;
  final String tagLabel;
  final Color tagBackgroundColor;
  final Color tagTextColor;
  final Color accentColor;
  final IconData icon;
  final double rating;
  final String duration;
  final String modules;

  const LabModel({
    required this.title,
    required this.tagLabel,
    required this.tagBackgroundColor,
    required this.tagTextColor,
    required this.accentColor,
    this.icon = Icons.bolt_rounded,
    this.rating = 4.9,
    this.duration = '45 min',
    this.modules = '4 Modules',
  });
}
