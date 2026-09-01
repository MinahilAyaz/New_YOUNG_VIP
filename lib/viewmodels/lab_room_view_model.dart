import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/lab_room_model.dart';

class LabRoomViewModel extends BaseViewModel {
  final LabRoomModel _roomData;

  LabRoomViewModel()
      : _roomData = LabRoomModel(
          title: 'AI Agents · Lab Room',
          peopleTag: '318 PEOPLE',
          posts: [
            RoomPostModel(
              initials: 'AK',
              authorName: 'Aisha Khan',
              tagLabel: 'FAILURE',
              tagBgColor: AppColors.coral.withValues(alpha: 0.12),
              tagTextColor: AppColors.coral,
              content: 'Giving send permission changed the risk.',
            ),
            RoomPostModel(
              initials: 'JM',
              authorName: 'Jordan Malik',
              tagLabel: 'INSIGHT',
              tagBgColor: AppColors.youngVipGold.withValues(alpha: 0.15),
              tagTextColor: AppColors.youngVipGold,
              content: 'The newest document was only a draft.',
            ),
            RoomPostModel(
              initials: 'PS',
              authorName: 'Priya Shah',
              tagLabel: 'QUESTION',
              tagBgColor: AppColors.royalIndigo.withValues(alpha: 0.12),
              tagTextColor: AppColors.royalIndigo,
              content: 'Would human approval be enough?',
            ),
          ],
        ) {
    setIdle();
  }

  LabRoomModel get roomData => _roomData;
}
