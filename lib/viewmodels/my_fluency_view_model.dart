import '../core/base/base_view_model.dart';
import '../data/models/my_fluency_model.dart';

class MyFluencyViewModel extends BaseViewModel {
  final MyFluencyModel _fluencyData;

  MyFluencyViewModel()
      : _fluencyData = const MyFluencyModel(
          title: 'My Fluency',
          levelTitle: 'Builder',
          levelSubtitle: '8 Labs · 14 Builds · 31 Failure Tests',
          skills: [
            FluencySkillModel(
              title: 'AI Agents',
              progress: 0.78,
              badgeLabel: 'Builder',
            ),
            FluencySkillModel(
              title: 'Data Systems',
              progress: 0.45,
              badgeLabel: 'Developing',
            ),
            FluencySkillModel(
              title: 'Privacy',
              progress: 0.65,
              badgeLabel: 'Practitioner',
            ),
            FluencySkillModel(
              title: 'Automation',
              progress: 0.55,
              badgeLabel: 'Builder',
            ),
          ],
        ) {
    setIdle();
  }

  MyFluencyModel get fluencyData => _fluencyData;
}
