import '../core/base/base_view_model.dart';
import '../data/models/peer_builder_model.dart';

class PeersViewModel extends BaseViewModel {
  final PeersScreenModel _peersData;

  PeersViewModel()
      : _peersData = const PeersScreenModel(
          title: 'Who else is building this?',
          peers: [
            PeerBuilderModel(
              initials: 'JM',
              name: 'Jane Mensah',
              role: 'Data Engineer',
            ),
            PeerBuilderModel(
              initials: 'DO',
              name: 'David Okoro',
              role: 'Security Architect',
            ),
            PeerBuilderModel(
              initials: 'PN',
              name: 'Priya Nair',
              role: 'Tech Counsel',
            ),
            PeerBuilderModel(
              initials: 'SA',
              name: 'Samuel Adeyemi',
              role: 'Automation Specialist',
            ),
          ],
        ) {
    setIdle();
  }

  PeersScreenModel get peersData => _peersData;
}
