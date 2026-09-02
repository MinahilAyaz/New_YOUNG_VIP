import 'package:flutter/material.dart';

class RoomPostModel {
  final String initials;
  final String authorName;
  final String role;
  final String tagLabel;
  final Color tagBgColor;
  final Color tagTextColor;
  final String content;
  final String timestamp;
  final int likes;
  final int replies;

  const RoomPostModel({
    required this.initials,
    required this.authorName,
    this.role = 'VIP Builder',
    required this.tagLabel,
    required this.tagBgColor,
    required this.tagTextColor,
    required this.content,
    this.timestamp = '10:00 AM',
    this.likes = 12,
    this.replies = 4,
  });
}

class LabRoomModel {
  final String title;
  final String peopleTag;
  final List<RoomPostModel> posts;

  const LabRoomModel({
    required this.title,
    required this.peopleTag,
    required this.posts,
  });
}
