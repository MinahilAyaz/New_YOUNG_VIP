import 'package:flutter/material.dart';

class RoomPostModel {
  final String initials;
  final String authorName;
  final String tagLabel;
  final Color tagBgColor;
  final Color tagTextColor;
  final String content;

  const RoomPostModel({
    required this.initials,
    required this.authorName,
    required this.tagLabel,
    required this.tagBgColor,
    required this.tagTextColor,
    required this.content,
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
