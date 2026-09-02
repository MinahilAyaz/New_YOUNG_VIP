import 'package:flutter/material.dart';
import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_model.dart';

class LabsViewModel extends BaseViewModel {
  final List<LabModel> _labs;
  String _searchQuery = '';
  String _selectedCategory = 'All Labs';

  final List<String> categories = const [
    'All Labs',
    'AI Agents',
    'RAG Systems',
    'Cybersecurity',
    'Automation',
  ];

  LabsViewModel()
      : _labs = const [
          LabModel(
            title: 'AI Workflow Studio',
            tagLabel: 'FREE FIRST LAB',
            tagBackgroundColor: AppColors.roomCardBg,
            tagTextColor: AppColors.pastelLavenderText,
            accentColor: AppColors.pastelLavenderText,
            icon: Icons.rocket_launch_rounded,
            rating: 4.9,
            duration: '45 min',
            modules: '4 Modules',
          ),
          LabModel(
            title: 'AI Agents Architecture',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.pastelLavender,
            tagTextColor: AppColors.pastelLavenderText,
            accentColor: AppColors.pastelLavenderText,
            icon: Icons.bolt_rounded,
            rating: 4.9,
            duration: '60 min',
            modules: '6 Modules',
          ),
          LabModel(
            title: 'RAG Knowledge Pipelines',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.pastelSage,
            tagTextColor: AppColors.pastelSageText,
            accentColor: AppColors.pastelSageText,
            icon: Icons.lightbulb_rounded,
            rating: 4.8,
            duration: '50 min',
            modules: '5 Modules',
          ),
          LabModel(
            title: 'Security & Red-Teaming',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.pastelCoral,
            tagTextColor: AppColors.pastelCoralText,
            accentColor: AppColors.pastelCoralText,
            icon: Icons.security_rounded,
            rating: 4.9,
            duration: '40 min',
            modules: '4 Modules',
          ),
          LabModel(
            title: 'Autonomous Ops & Evals',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.pastelSand,
            tagTextColor: AppColors.pastelSandText,
            accentColor: AppColors.pastelSandText,
            icon: Icons.settings_rounded,
            rating: 4.7,
            duration: '55 min',
            modules: '5 Modules',
          ),
        ] {
    setIdle();
  }

  List<LabModel> get labs {
    final String query = _searchQuery.trim().toLowerCase();
    final String category = _selectedCategory.trim().toLowerCase();

    return _labs.where((lab) {
      final String title = lab.title.toLowerCase();
      final bool matchesCategory = category.isEmpty ||
          category == 'all labs' ||
          title.contains(category) ||
          (category.contains('agent') && title.contains('agent')) ||
          (category.contains('rag') && title.contains('rag')) ||
          (category.contains('security') && (title.contains('security') || title.contains('cyber'))) ||
          (category.contains('auto') && title.contains('auto'));

      final bool matchesSearch = query.isEmpty || title.contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
