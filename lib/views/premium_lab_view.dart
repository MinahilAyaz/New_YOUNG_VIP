import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/premium_lab_model.dart';
import '../viewmodels/premium_lab_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';

class PremiumLabView extends StatelessWidget {
  const PremiumLabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PremiumLabViewModel>(
      create: (_) => PremiumLabViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<PremiumLabViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final premiumData = viewModel.premiumData;

            return SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 20.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 28.0),
                          _buildHeading(premiumData.screenTitle),
                          const SizedBox(height: 52.0),
                          _buildPaywallContent(premiumData),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 1,
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.menu_rounded,
                color: AppColors.deepInk,
                size: 26.0,
              ),
            ),
          ),
        ),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'YOUNG ',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              TextSpan(
                text: 'VIP',
                style: TextStyle(
                  color: AppColors.youngVipGold,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36.0,
          height: 36.0,
          decoration: const BoxDecoration(
            color: AppColors.lightLavender,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'AV',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading(String title) {
    return Text(
      title,
      style: AppTextStyles.headingLarge.copyWith(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: AppColors.deepInk,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildPaywallContent(PremiumLabModel premiumData) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tall gold lock outline icon
          Container(
            width: 22.0,
            height: 38.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.youngVipGold,
                width: 2.8,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(height: 22.0),
          Text(
            premiumData.heading,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              premiumData.description,
              style: const TextStyle(
                color: AppColors.blueGray,
                fontSize: 13.5,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 38.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                label: r'$19 / month',
                onPressed: () {},
                backgroundColor: AppColors.royalIndigo,
                textColor: AppColors.pureWhite,
              ),
              const SizedBox(width: 14.0),
              CustomButton(
                label: r'$149 / year',
                onPressed: () {},
                backgroundColor: AppColors.youngVipGold,
                textColor: AppColors.pureWhite,
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Text(
            premiumData.footnote,
            style: const TextStyle(
              color: AppColors.youngVipGold,
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
