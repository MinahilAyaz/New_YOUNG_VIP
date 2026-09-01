import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/my_builds_model.dart';

class MyBuildsViewModel extends BaseViewModel {
  final MyBuildsModel _buildsData;

  MyBuildsViewModel()
      : _buildsData = MyBuildsModel(
          title: 'My Builds',
          stats: const [
            BuildStatModel(
              value: '8',
              label: 'Labs',
              color: AppColors.royalIndigo,
            ),
            BuildStatModel(
              value: '14',
              label: 'Builds',
              color: AppColors.royalIndigo,
            ),
            BuildStatModel(
              value: '31',
              label: 'Failure tests',
              color: AppColors.coral,
            ),
            BuildStatModel(
              value: '7',
              label: 'Advice',
              color: AppColors.youngVipGold,
            ),
          ],
          buildItems: [
            BuildItemModel(
              title: 'AI Workflow with Approval Gate',
              subtitle: '4 failure tests',
              backgroundColor: AppColors.youngVipGold.withValues(alpha: 0.15),
            ),
            const BuildItemModel(
              title: 'RAG Conflict Test',
              subtitle: '3 failure tests',
              backgroundColor: AppColors.pureWhite,
            ),
            const BuildItemModel(
              title: 'Automation Approval Gate',
              subtitle: '2 failure tests',
              backgroundColor: AppColors.pureWhite,
            ),
          ],
        ) {
    setIdle();
  }

  MyBuildsModel get buildsData => _buildsData;
}
