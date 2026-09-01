class MessageThreadModel {
  final String initials;
  final String senderName;
  final String lastMessage;

  const MessageThreadModel({
    required this.initials,
    required this.senderName,
    required this.lastMessage,
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
