import 'package:flutter/material.dart';
import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/expert_studio_model.dart';

class ExpertStudioViewModel extends BaseViewModel {
  final ExpertStudioModel _studioData;

  ExpertStudioViewModel()
      : _studioData = const ExpertStudioModel(
          screenTitle: 'Build Expert Studio',
          tagLabel: 'VIP CREATOR ACCESS',
          description:
              'Author and stress-test interactive workflows for 1,200+ global builders.',
          buttonLabel: 'Continue Creator Work on Web',
          statusItems: [
            StudioStatusItemModel(
              title: 'Draft Labs',
              count: 3,
              countColor: Color(0xFF6E6285),
            ),
            StudioStatusItemModel(
              title: 'Under Review',
              count: 1,
              countColor: Color(0xFFD97706),
            ),
            StudioStatusItemModel(
              title: 'Published',
              count: 5,
              countColor: Color(0xFF059669),
            ),
          ],
          authoredLabs: [
            AuthoredLabModel(
              title: 'Autonomous Approval Loops in Production',
              status: 'PUBLISHED',
              statusBg: Color(0xFFD1FAE5),
              statusText: Color(0xFF065F46),
              learnersCount: '1.4k Learners',
              rating: '4.9',
              icon: Icons.rocket_launch_rounded,
            ),
            AuthoredLabModel(
              title: 'Adversarial Prompt Defense Guardrails',
              status: 'IN REVIEW',
              statusBg: AppColors.pastelSand,
              statusText: AppColors.pastelSandText,
              learnersCount: 'Beta Testing',
              rating: '4.8',
              icon: Icons.security_rounded,
            ),
            AuthoredLabModel(
              title: 'Multi-Modal RAG Knowledge Graphs',
              status: 'DRAFT',
              statusBg: AppColors.pastelLavender,
              statusText: AppColors.pastelLavenderText,
              learnersCount: 'In Progress · 3/6 modules',
              rating: 'Draft',
              icon: Icons.lightbulb_rounded,
            ),
          ],
        ) {
    setIdle();
  }

  ExpertStudioModel get studioData => _studioData;
}
