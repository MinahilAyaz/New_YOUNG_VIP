import 'package:flutter/material.dart';
import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/my_builds_model.dart';

class MyBuildsViewModel extends BaseViewModel {
  final MyBuildsModel _buildsData;
  String _selectedFilter = 'All Builds';

  final List<String> filters = const [
    'All Builds',
    'Deployed',
    'Benchmarking',
    'Drafts',
  ];

  MyBuildsViewModel()
      : _buildsData = const MyBuildsModel(
          title: 'My Builds',
          stats: [
            BuildStatModel(
              value: '8',
              label: 'Deployed',
              color: AppColors.deepInk,
            ),
            BuildStatModel(
              value: '14',
              label: 'Passed',
              color: Color(0xFF10B981),
            ),
            BuildStatModel(
              value: '99.4%',
              label: 'Uptime',
              color: Color(0xFF2563EB),
            ),
            BuildStatModel(
              value: '31',
              label: 'Stress Tests',
              color: Color(0xFFEF4444),
            ),
          ],
          buildItems: [
            BuildItemModel(
              title: 'Autonomous Approval Pipeline',
              subtitle: 'Multi-agent guardrail verification system',
              backgroundColor: AppColors.pureWhite,
              icon: Icons.rocket_launch_rounded,
              status: 'DEPLOYED',
              statusBg: Color(0xFFD1FAE5),
              statusText: Color(0xFF065F46),
              metrics: '140ms · 99.8% Reliability',
            ),
            BuildItemModel(
              title: 'RAG Knowledge Synthesis Engine',
              subtitle: 'Hybrid vector & semantic reranking pipeline',
              backgroundColor: AppColors.pureWhite,
              icon: Icons.lightbulb_rounded,
              status: 'DEPLOYED',
              statusBg: Color(0xFFD1FAE5),
              statusText: Color(0xFF065F46),
              metrics: '210ms · 98.6% Accuracy',
            ),
            BuildItemModel(
              title: 'Prompt Injection Defense Agent',
              subtitle: 'Real-time red-team adversarial sanitizer',
              backgroundColor: AppColors.pureWhite,
              icon: Icons.security_rounded,
              status: 'BENCHMARKING',
              statusBg: AppColors.pastelSand,
              statusText: AppColors.pastelSandText,
              metrics: '95ms · 12 Test Cases',
            ),
            BuildItemModel(
              title: 'Multi-Tool Execution Sandbox',
              subtitle: 'Isolated environment for Python & SQL execution',
              backgroundColor: AppColors.pureWhite,
              icon: Icons.settings_rounded,
              status: 'DRAFTS',
              statusBg: AppColors.pastelLavender,
              statusText: AppColors.pastelLavenderText,
              metrics: 'In Progress · 4/8 Modules',
            ),
          ],
        ) {
    setIdle();
  }

  MyBuildsModel get buildsData => _buildsData;
  String get selectedFilter => _selectedFilter;

  List<BuildItemModel> get filteredItems {
    final filter = _selectedFilter.trim().toLowerCase();
    if (filter.isEmpty || filter == 'all builds') {
      return _buildsData.buildItems;
    }
    return _buildsData.buildItems
        .where((item) => item.status.toLowerCase().contains(filter))
        .toList();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
}
