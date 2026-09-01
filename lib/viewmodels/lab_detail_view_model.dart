import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_detail_model.dart';

class LabDetailViewModel extends BaseViewModel {
  final LabDetailModel _labDetail;

  LabDetailViewModel()
      : _labDetail = LabDetailModel(
          title: 'Build & Break an AI Agent',
          tagLabel: 'AI AGENTS · INTERMEDIATE',
          description:
              'Get inside the system, explore failure, understand why, then apply the lesson to professional judgment.',
          stages: [
            const LabStageModel(
              label: 'BUILD',
              backgroundColor: AppColors.lightLavender,
              textColor: AppColors.royalIndigo,
            ),
            LabStageModel(
              label: 'BREAK',
              backgroundColor: AppColors.coral.withValues(alpha: 0.12),
              textColor: AppColors.coral,
            ),
            const LabStageModel(
              label: 'UNDERSTAND',
              backgroundColor: AppColors.lightLavender,
              textColor: AppColors.royalIndigo,
            ),
            LabStageModel(
              label: 'ADVISE',
              backgroundColor: AppColors.youngVipGold.withValues(alpha: 0.15),
              textColor: AppColors.youngVipGold,
            ),
          ],
          professionalsCount: 342,
          unlockNote: 'Lab Room unlocks when you start.',
        ) {
    setIdle();
  }

  LabDetailModel get labDetail => _labDetail;
}
