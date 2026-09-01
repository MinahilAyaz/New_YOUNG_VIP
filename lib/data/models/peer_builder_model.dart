class PeerBuilderModel {
  final String initials;
  final String name;
  final String role;

  const PeerBuilderModel({
    required this.initials,
    required this.name,
    required this.role,
  });
}

class PeersScreenModel {
  final String title;
  final List<PeerBuilderModel> peers;

  const PeersScreenModel({
    required this.title,
    required this.peers,
  });
}
