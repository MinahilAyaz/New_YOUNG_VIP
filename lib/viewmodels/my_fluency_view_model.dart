import 'package:flutter/material.dart';
import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/my_fluency_model.dart';

class MyFluencyViewModel extends BaseViewModel {
  final MyFluencyModel _fluencyData;

  MyFluencyViewModel()
      : _fluencyData = const MyFluencyModel(
          title: 'My Fluency',
          levelTitle: 'AI Systems Architect',
          levelSubtitle: 'Level 4 · 16 Verified Skills · Top 5% Global',
          skills: [
            FluencySkillModel(
              title: 'Autonomous Agents & Loops',
              progress: 0.88,
              badgeLabel: 'ADVANCED',
              icon: Icons.bolt_rounded,
              levelText: '88% Mastery',
              completedCount: '4/5 Milestones Verified',
              bgColor: AppColors.pastelLavender,
              textColor: AppColors.pastelLavenderText,
            ),
            FluencySkillModel(
              title: 'RAG & Vector Retrieval',
              progress: 0.84,
              badgeLabel: 'PROFICIENT',
              icon: Icons.lightbulb_rounded,
              levelText: '84% Mastery',
              completedCount: '5/6 Milestones Verified',
              bgColor: AppColors.pastelSage,
              textColor: AppColors.pastelSageText,
            ),
            FluencySkillModel(
              title: 'Red-Teaming & Guardrail Defense',
              progress: 0.92,
              badgeLabel: 'EXPERT',
              icon: Icons.security_rounded,
              levelText: '92% Mastery',
              completedCount: '4/4 Milestones Verified',
              bgColor: AppColors.pastelCoral,
              textColor: AppColors.pastelCoralText,
            ),
            FluencySkillModel(
              title: 'Autonomous Ops & Evals',
              progress: 0.72,
              badgeLabel: 'BUILDER',
              icon: Icons.settings_rounded,
              levelText: '72% Mastery',
              completedCount: '3/5 Milestones Verified',
              bgColor: AppColors.pastelSand,
              textColor: AppColors.pastelSandText,
            ),
          ],
        ) {
    setIdle();
  }

  MyFluencyModel get fluencyData => _fluencyData;
}
