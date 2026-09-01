import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/user_profile_model.dart';

class ProfileViewModel extends BaseViewModel {
  final UserProfileModel _profileData;

  ProfileViewModel()
      : _profileData = const UserProfileModel(
          initials: 'AV',
          name: 'Alex Verma',
          profession: 'Legal Professional · AI Governance',
          fluencyBadge: 'Fluency: Builder',
          stats: [
            ProfileStatModel(
              value: '8',
              label: 'Labs',
              color: AppColors.royalIndigo,
            ),
            ProfileStatModel(
              value: '14',
              label: 'Builds',
              color: AppColors.royalIndigo,
            ),
            ProfileStatModel(
              value: '31',
              label: 'Failure tests',
              color: AppColors.coral,
            ),
          ],
          recentBuilds: [
            'AI Agent with Approval Gate',
            'RAG Conflict Test',
            'Automation Approval Gate',
          ],
        ) {
    setIdle();
  }

  UserProfileModel get profileData => _profileData;
}
