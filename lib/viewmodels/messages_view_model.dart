import '../core/base/base_view_model.dart';
import '../data/models/message_thread_model.dart';

class MessagesViewModel extends BaseViewModel {
  final MessagesScreenModel _messagesData;

  MessagesViewModel()
      : _messagesData = const MessagesScreenModel(
          title: 'Messages',
          threads: [
            MessageThreadModel(
              initials: 'JM',
              senderName: 'Jane Mensah',
              lastMessage: 'That diagram helped.',
            ),
            MessageThreadModel(
              initials: 'DO',
              senderName: 'David Okoro',
              lastMessage: 'Happy to compare.',
            ),
            MessageThreadModel(
              initials: 'PN',
              senderName: 'Priya Nair',
              lastMessage: 'Interesting threshold.',
            ),
            MessageThreadModel(
              initials: 'SA',
              senderName: 'Samuel Adeyemi',
              lastMessage: 'Sent the reference.',
            ),
          ],
        ) {
    setIdle();
  }

  MessagesScreenModel get messagesData => _messagesData;
}
