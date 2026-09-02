import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/premium_lab_model.dart';
import '../viewmodels/premium_lab_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class PremiumLabView extends StatelessWidget {
  final bool isRootTab;

  const PremiumLabView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PremiumLabViewModel>(
      create: (_) => PremiumLabViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
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
                      vertical: 12.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 18.0),
                          _buildHeading(premiumData.screenTitle),
                          const SizedBox(height: 24.0),
                          _buildPaywallHero(premiumData),
                          const SizedBox(height: 20.0),
                          _buildPricingCards(),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: isRootTab
            ? null
            : const CustomBottomNavBar(
                currentIndex: 1,
              ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34.0,
                height: 34.0,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFEDE7F2),
                    width: 1.0,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.deepInk,
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 10.0),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'YOUNG ',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                    TextSpan(
                      text: 'VIP',
                      style: TextStyle(
                        color: AppColors.mutedPurple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFEDE7F2),
                  width: 1.0,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                  Positioned(
                    top: 7.0,
                    right: 8.0,
                    child: Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 34.0,
              height: 34.0,
              decoration: const BoxDecoration(
                color: AppColors.avatarBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'AV',
                style: TextStyle(
                  color: AppColors.avatarText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeading(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Unlock full access to production labs & live rooms',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPaywallHero(PremiumLabModel premiumData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.heroCardPurple,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroCardPurple.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 6.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: const Color(0xFF857A9D),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 13.0,
                ),
                SizedBox(width: 3.0),
                Text(
                  'VIP ALL-ACCESS PASS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            premiumData.heading,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            premiumData.description,
            style: const TextStyle(
              color: AppColors.heroCardSubtext,
              fontSize: 12.5,
              height: 1.45,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: const Color(0xFFEDE7F2),
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Monthly',
                  style: TextStyle(
                    color: AppColors.roomCardSubtext,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  r'$19',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 7.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.roomCardBg,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Select',
                    style: TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: AppColors.deepInk,
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Annual (Save 35%)',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  r'$149',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 7.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.deepInk,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Best Value →',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
