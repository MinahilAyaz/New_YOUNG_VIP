import 'package:flutter/material.dart';

class MessageThreadModel {
  final String initials;
  final String senderName;
  final String role;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final Color avatarBg;

  const MessageThreadModel({
    required this.initials,
    required this.senderName,
    this.role = 'VIP Peer',
    required this.lastMessage,
    this.timestamp = '10:45 AM',
    this.unreadCount = 0,
    this.avatarBg = const Color(0xFFECE6F4),
  });
}

class MessagesScreenModel {
  final String title;
  final List<MessageThreadModel> threads;

  const MessagesScreenModel({
    required this.title,
    required this.threads,
  });
}
