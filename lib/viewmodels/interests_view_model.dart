import '../core/base/base_view_model.dart';
import '../data/models/interests_model.dart';

class InterestsViewModel extends BaseViewModel {
  final InterestsOnboardingModel _model;
  final Set<String> _selectedTopicIds = {
    'ai-agents',
    'rag-knowledge',
    'prompt-eng',
  };
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String? _activePresetId;

  InterestsViewModel({InterestsOnboardingModel? model})
      : _model = model ?? InterestsOnboardingModel.initial();

  // Getters
  InterestsOnboardingModel get model => _model;
  Set<String> get selectedTopicIds => Set.unmodifiable(_selectedTopicIds);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String? get activePresetId => _activePresetId;
  int get selectedCount => _selectedTopicIds.length;
  int get minRequired => _model.minRequiredSelection;
  bool get canProceed => _selectedTopicIds.length >= _model.minRequiredSelection;
  int get remainingToSelect =>
      (_model.minRequiredSelection - _selectedTopicIds.length).clamp(0, 99);

  List<String> get categories => [
        'All',
        'Core Technologies',
        'Regulatory & Risk',
        'Emerging Tech',
      ];

  List<TopicInterest> get filteredTopics {
    return _model.allTopics.where((topic) {
      final matchesCategory = _selectedCategory == 'All' ||
          topic.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          topic.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          topic.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          topic.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  bool isTopicSelected(String id) => _selectedTopicIds.contains(id);

  void toggleTopic(String id) {
    if (_selectedTopicIds.contains(id)) {
      _selectedTopicIds.remove(id);
    } else {
      _selectedTopicIds.add(id);
    }
    _activePresetId = null;
    notifyListeners();
  }

  void applyPreset(InterestsPreset preset) {
    _activePresetId = preset.id;
    _selectedTopicIds.clear();
    _selectedTopicIds.addAll(preset.topicIds);
    notifyListeners();
  }

  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  Future<bool> saveInterests() async {
    if (!canProceed) {
      setError('Please select at least $minRequired topics to personalize your curriculum.');
      return false;
    }

    setSuccess();
    return true;
  }
}
