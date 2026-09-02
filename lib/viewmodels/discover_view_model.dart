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
            backgroundColor: AppColors.pastelLavender,
            accentColor: AppColors.pastelLavenderText,
          ),
          const DiscoverCategoryModel(
            title: 'RAG',
            backgroundColor: AppColors.pastelSage,
            accentColor: AppColors.pastelSageText,
          ),
          const DiscoverCategoryModel(
            title: 'Security',
            backgroundColor: AppColors.pastelCoral,
            accentColor: AppColors.pastelCoralText,
          ),
          const DiscoverCategoryModel(
            title: 'Automation',
            backgroundColor: AppColors.pastelSand,
            accentColor: AppColors.pastelSandText,
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
