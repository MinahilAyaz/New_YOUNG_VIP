class FluencySkillModel {
  final String title;
  final double progress;
  final String badgeLabel;

  const FluencySkillModel({
    required this.title,
    required this.progress,
    required this.badgeLabel,
  });
}

class MyFluencyModel {
  final String title;
  final String levelTitle;
  final String levelSubtitle;
  final List<FluencySkillModel> skills;

  const MyFluencyModel({
    required this.title,
    required this.levelTitle,
    required this.levelSubtitle,
    required this.skills,
  });
}
