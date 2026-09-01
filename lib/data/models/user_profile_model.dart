import 'package:flutter/material.dart';

class ProfileStatModel {
  final String value;
  final String label;
  final Color color;

  const ProfileStatModel({
    required this.value,
    required this.label,
    required this.color,
  });
}

class UserProfileModel {
  final String initials;
  final String name;
  final String profession;
  final String fluencyBadge;
  final List<ProfileStatModel> stats;
  final List<String> recentBuilds;

  const UserProfileModel({
    required this.initials,
    required this.name,
    required this.profession,
    required this.fluencyBadge,
    required this.stats,
    required this.recentBuilds,
  });
}
