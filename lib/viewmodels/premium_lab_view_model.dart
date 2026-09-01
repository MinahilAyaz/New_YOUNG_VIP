import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/premium_lab_model.dart';

class PremiumLabViewModel extends BaseViewModel {
  final PremiumLabModel _premiumData;

  PremiumLabViewModel()
      : _premiumData = const PremiumLabModel(
          screenTitle: 'Premium Lab',
          heading: 'Part of All Access',
          description:
              'Keep your free account. Upgrade only when you want the complete premium Lab library.',
          footnote: 'Annual = Best Value',
          pricingOptions: [
            PricingOptionModel(
              label: r'$19 / month',
              backgroundColor: AppColors.royalIndigo,
              textColor: AppColors.pureWhite,
            ),
            PricingOptionModel(
              label: r'$149 / year',
              backgroundColor: AppColors.youngVipGold,
              textColor: AppColors.pureWhite,
            ),
          ],
        ) {
    setIdle();
  }

  PremiumLabModel get premiumData => _premiumData;
}
