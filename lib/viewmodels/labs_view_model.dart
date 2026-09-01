import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_model.dart';

class LabsViewModel extends BaseViewModel {
  final List<LabModel> _labs;
  String _searchQuery = '';

  LabsViewModel()
      : _labs = [
          LabModel(
            title: 'AI Workflow',
            tagLabel: 'FREE',
            tagBackgroundColor: AppColors.softGreen.withValues(alpha: 0.12),
            tagTextColor: AppColors.softGreen,
            accentColor: AppColors.royalIndigo,
          ),
          const LabModel(
            title: 'AI Agents',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.lightLavender,
            tagTextColor: AppColors.royalIndigo,
            accentColor: AppColors.royalIndigo,
          ),
          LabModel(
            title: 'RAG Systems',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.softGreen.withValues(alpha: 0.12),
            tagTextColor: AppColors.softGreen,
            accentColor: AppColors.softGreen,
          ),
          LabModel(
            title: 'Cybersecurity',
            tagLabel: 'ALL ACCESS',
            tagBackgroundColor: AppColors.coral.withValues(alpha: 0.12),
            tagTextColor: AppColors.coral,
            accentColor: AppColors.coral,
          ),
        ] {
    setIdle();
  }

  List<LabModel> get labs => _labs;
  String get searchQuery => _searchQuery;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
