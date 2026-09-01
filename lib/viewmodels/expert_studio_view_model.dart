import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/expert_studio_model.dart';

class ExpertStudioViewModel extends BaseViewModel {
  final ExpertStudioModel _studioData;

  ExpertStudioViewModel()
      : _studioData = const ExpertStudioModel(
          screenTitle: 'Build Expert Studio',
          tagLabel: 'CREATOR ACCESS',
          description:
              'Creator work is optimized for web. Use mobile to check status, revisions and published Lab analytics.',
          buttonLabel: 'Continue Creator Work on Web',
          statusItems: [
            StudioStatusItemModel(
              title: 'Draft Labs',
              count: 3,
              countColor: AppColors.royalIndigo,
            ),
            StudioStatusItemModel(
              title: 'Under Review',
              count: 1,
              countColor: AppColors.youngVipGold,
            ),
            StudioStatusItemModel(
              title: 'Published',
              count: 5,
              countColor: AppColors.softGreen,
            ),
          ],
        ) {
    setIdle();
  }

  ExpertStudioModel get studioData => _studioData;
}
