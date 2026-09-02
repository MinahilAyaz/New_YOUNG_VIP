import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_room_model.dart';

class LabRoomViewModel extends BaseViewModel {
  final LabRoomModel _roomData;
  int _selectedDayIndex = 2; // Wed 14

  LabRoomViewModel()
      : _roomData = const LabRoomModel(
          title: 'AI Agents · Builder Room',
          peopleTag: '318 ACTIVE BUILDERS',
          posts: [
            RoomPostModel(
              initials: 'AK',
              authorName: 'Aisha Khan',
              role: 'Lead Architect',
              tagLabel: 'FAILURE CASE',
              tagBgColor: AppColors.pastelCoral,
              tagTextColor: AppColors.pastelCoralText,
              content:
                  'Giving unrestrained send permission changed the risk surface completely. Autonomous loop escaped bounds until sandboxing triggered.',
              timestamp: '10:00 AM',
              likes: 34,
              replies: 12,
            ),
            RoomPostModel(
              initials: 'JM',
              authorName: 'Jordan Malik',
              role: 'AI Researcher',
              tagLabel: 'PROMPT BENCHMARK',
              tagBgColor: AppColors.pastelSand,
              tagTextColor: AppColors.pastelSandText,
              content:
                  'Semantic routing reduced token usage by 42%. The model accurately switches between coding agent and retrieval tool without hallucinations.',
              timestamp: '01:30 PM',
              likes: 28,
              replies: 7,
            ),
            RoomPostModel(
              initials: 'PS',
              authorName: 'Priya Shah',
              role: 'Security Engineer',
              tagLabel: 'HUMAN-IN-THE-LOOP',
              tagBgColor: AppColors.pastelLavender,
              tagTextColor: AppColors.pastelLavenderText,
              content:
                  'Would asynchronous dual-approver confirmation be fast enough for high-frequency workflows while maintaining 100% policy compliance?',
              timestamp: '04:15 PM',
              likes: 19,
              replies: 15,
            ),
          ],
        ) {
    setIdle();
  }

  LabRoomModel get roomData => _roomData;
  int get selectedDayIndex => _selectedDayIndex;

  void selectDay(int index) {
    _selectedDayIndex = index;
    notifyListeners();
  }
}
