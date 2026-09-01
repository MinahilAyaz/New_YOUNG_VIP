import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/current_room_model.dart';
import '../data/models/discover_category_model.dart';

class DiscoverViewModel extends BaseViewModel {
  final List<DiscoverCategoryModel> _categories;
  final CurrentRoomModel _currentRoom;
  String _searchQuery = '';

  DiscoverViewModel()
      : _categories = [
          const DiscoverCategoryModel(
            title: 'AI Agents',
            backgroundColor: AppColors.lightLavender,
            accentColor: AppColors.royalIndigo,
          ),
          DiscoverCategoryModel(
            title: 'RAG',
            backgroundColor: AppColors.softGreen.withValues(alpha: 0.12),
            accentColor: AppColors.softGreen,
          ),
          DiscoverCategoryModel(
            title: 'Security',
            backgroundColor: AppColors.coral.withValues(alpha: 0.12),
            accentColor: AppColors.coral,
          ),
          DiscoverCategoryModel(
            title: 'Automation',
            backgroundColor: AppColors.youngVipGold.withValues(alpha: 0.15),
            accentColor: AppColors.youngVipGold,
          ),
        ],
        _currentRoom = const CurrentRoomModel(
          label: 'YOUR CURRENT ROOM',
          title: '12 new observations',
          subtitle: '318 professionals in this Lab',
        ) {
    setIdle();
  }

  List<DiscoverCategoryModel> get categories => _categories;
  CurrentRoomModel get currentRoom => _currentRoom;
  String get searchQuery => _searchQuery;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
