import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/message_thread_model.dart';

class MessagesViewModel extends BaseViewModel {
  final MessagesScreenModel _messagesData;
  String _searchQuery = '';

  final List<Map<String, String>> onlinePeers = const [
    {'initials': 'AK', 'name': 'Aisha K.'},
    {'initials': 'JM', 'name': 'Jordan M.'},
    {'initials': 'PS', 'name': 'Priya S.'},
    {'initials': 'SW', 'name': 'Sarah W.'},
    {'initials': 'DO', 'name': 'David O.'},
    {'initials': 'SA', 'name': 'Samuel A.'},
  ];

  MessagesViewModel()
      : _messagesData = const MessagesScreenModel(
          title: 'Messages',
          threads: [
            MessageThreadModel(
              initials: 'AK',
              senderName: 'Aisha Khan',
              role: 'VIP Lead Architect',
              lastMessage: 'The prompt injection sandbox was verified at 99.4% precision.',
              timestamp: '10:45 AM',
              unreadCount: 2,
              avatarBg: AppColors.pastelLavender,
            ),
            MessageThreadModel(
              initials: 'JM',
              senderName: 'Jordan Malik',
              role: 'AI Researcher',
              lastMessage: 'Let us benchmark the semantic chunking reranker tomorrow.',
              timestamp: '08:20 AM',
              unreadCount: 1,
              avatarBg: AppColors.pastelSage,
            ),
            MessageThreadModel(
              initials: 'PS',
              senderName: 'Priya Shah',
              role: 'Security Engineer',
              lastMessage: 'Shared the dual-approver gate architecture diagram.',
              timestamp: 'Yesterday',
              unreadCount: 0,
              avatarBg: AppColors.pastelCoral,
            ),
            MessageThreadModel(
              initials: 'DO',
              senderName: 'David Okoro',
              role: 'Systems Builder',
              lastMessage: 'Happy to compare evaluation logs for the autonomous ops lab.',
              timestamp: 'Aug 29',
              unreadCount: 0,
              avatarBg: AppColors.pastelSand,
            ),
          ],
        ) {
    setIdle();
  }

  MessagesScreenModel get messagesData => _messagesData;
  String get searchQuery => _searchQuery;

  List<MessageThreadModel> get filteredThreads {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _messagesData.threads;
    }
    return _messagesData.threads.where((t) {
      return t.senderName.toLowerCase().contains(query) ||
          t.lastMessage.toLowerCase().contains(query) ||
          t.role.toLowerCase().contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
