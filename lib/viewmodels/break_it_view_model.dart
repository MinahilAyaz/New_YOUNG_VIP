import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_stage_screen_model.dart';

class BreakItViewModel extends BaseViewModel {
  final BreakItStageModel _stageData;

  BreakItViewModel()
      : _stageData = BreakItStageModel(
          stageTitle: 'Break It',
          labTagLabel: 'AI AGENTS LAB',
          steps: const [
            StageStepModel(label: 'Build', isActive: false),
            StageStepModel(label: 'Break', isActive: true),
            StageStepModel(label: 'Understand', isActive: false),
            StageStepModel(label: 'Advise', isActive: false),
          ],
          contentBlocks: [
            ContentBlockModel(
              tagLabel: 'VIDEO',
              icon: Icons.play_arrow,
              title: 'Failure demonstration',
              description: 'Watch what happens when a permission changes.',
              buttonLabel: 'Watch',
              accentColor: AppColors.coral,
              cardBackgroundColor: AppColors.coral.withValues(alpha: 0.08),
            ),
            ContentBlockModel(
              tagLabel: 'SCENARIO',
              icon: Icons.diamond_outlined,
              title: 'What happens next?',
              description:
                  'Review the changed facts and predict likely behavior.',
              buttonLabel: 'Review',
              accentColor: AppColors.youngVipGold,
              cardBackgroundColor:
                  AppColors.youngVipGold.withValues(alpha: 0.08),
            ),
            const ContentBlockModel(
              tagLabel: 'QUIZ',
              icon: Icons.help_outline,
              title: 'Spot the failure point',
              description: 'Identify the component creating the risk.',
              buttonLabel: 'Answer',
              accentColor: AppColors.royalIndigo,
              cardBackgroundColor: AppColors.lightLavender,
            ),
          ],
        ) {
    setIdle();
  }

  BreakItStageModel get stageData => _stageData;
}
