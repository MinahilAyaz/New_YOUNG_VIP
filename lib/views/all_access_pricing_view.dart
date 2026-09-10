import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'main_navigation_view.dart';

class AllAccessPricingView extends StatefulWidget {
  const AllAccessPricingView({super.key});

  @override
  State<AllAccessPricingView> createState() => _AllAccessPricingViewState();
}

class _AllAccessPricingViewState extends State<AllAccessPricingView> {
  bool _isAnnual = true; // true: $149/yr, false: $19/mo
  bool _isProcessing = false;

  Future<void> _handleSubscribe() async {
    HapticFeedback.heavyImpact();
    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;
    setState(() => _isProcessing = false);

    final planName = _isAnnual ? 'All-Access Annual (\$149/yr)' : 'All-Access Monthly (\$19/mo)';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.pureWhite,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF3C7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Color(0xFFD97706),
                  size: 36.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Welcome to Young VIP!',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Your subscription to $planName has been activated. You now have full access to all 40+ interactive AI architecture sandboxes, live breakout rooms & certified credentials.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.0,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bananiSuccessSoft,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 15.0,
                      color: Color(0xFF059669),
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      'All-Access Membership Confirmed',
                      style: TextStyle(
                        color: Color(0xFF065F46),
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22.0),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogCtx);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainNavigationView(initialIndex: 0),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bananiPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Exploring VIP Labs',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Icon(Icons.arrow_forward_rounded, size: 16.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : (screenWidth < 360 ? 14.0 : 20.0);

    return Scaffold(
      backgroundColor: AppColors.bananiBackground,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 18.0),
                  _buildHeaderSection(),
                  const SizedBox(height: 20.0),
                  _buildBillingToggle(),
                  const SizedBox(height: 22.0),
                  _buildPricingCards(),
                  const SizedBox(height: 22.0),
                  _buildFeaturesMatrix(),
                  const SizedBox(height: 22.0),
                  _buildPrimaryActionButton(context),
                  const SizedBox(height: 14.0),
                  _buildGuaranteeBanner(),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 540.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MainNavigationView(initialIndex: 0),
                        ),
                      );
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 38.0,
                    height: 38.0,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: AppColors.buttonShadow,
                      border: Border.all(
                        color: AppColors.cardBorder,
                        width: 1.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.deepInk,
                      size: 18.0,
                    ),
                  ),
                ),
                const YoungVipWordmark(),
              ],
            ),
            // Membership Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: AppColors.bananiLavender,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColors.bananiPrimary.withValues(alpha: 0.25),
                  width: 1.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.workspace_premium_rounded,
                    size: 13.0,
                    color: AppColors.bananiPrimary,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'ALL-ACCESS PASS',
                    style: TextStyle(
                      color: AppColors.bananiPrimary,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars_rounded, size: 13.0, color: Color(0xFFD97706)),
                SizedBox(width: 4.0),
                Text(
                  'OFFICIAL SUBSCRIPTION TIERS',
                  style: TextStyle(
                    color: Color(0xFFB45309),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'All-Access Membership',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Choose between flexible monthly access at \$19/mo or unlock full annual privileges for \$149/yr (saving 35%).',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          // Monthly Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _isAnnual = false);
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: !_isAnnual ? AppColors.pureWhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: !_isAnnual ? AppColors.buttonShadow : null,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Monthly (\$19 / mo)',
                    style: TextStyle(
                      color: !_isAnnual ? AppColors.deepInk : AppColors.textSecondary,
                      fontSize: 13.0,
                      fontWeight: !_isAnnual ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Annual Button (Save 35%)
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _isAnnual = true);
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: _isAnnual ? AppColors.bananiPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: _isAnnual
                      ? [
                          BoxShadow(
                            color: AppColors.bananiPrimary.withValues(alpha: 0.3),
                            blurRadius: 8.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Annual (\$149 / yr)',
                        style: TextStyle(
                          color: _isAnnual ? Colors.white : AppColors.textSecondary,
                          fontSize: 13.0,
                          fontWeight: _isAnnual ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: _isAnnual
                              ? const Color(0xFFFCD34D)
                              : const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          'SAVE 35%',
                          style: TextStyle(
                            color: _isAnnual
                                ? const Color(0xFF78350F)
                                : const Color(0xFFB45309),
                            fontSize: 9.0,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards() {
    return Column(
      children: [
        // Annual Card ($149/yr)
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _isAnnual = true);
          },
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: _isAnnual ? AppColors.bananiLavender : AppColors.pureWhite,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: _isAnnual ? AppColors.bananiPrimary : AppColors.cardBorder,
                width: _isAnnual ? 2.0 : 1.0,
              ),
              boxShadow: _isAnnual
                  ? [
                      BoxShadow(
                        color: AppColors.bananiPrimary.withValues(alpha: 0.16),
                        blurRadius: 14.0,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: [
                    const Text(
                      'All-Access Annual Pass',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'BEST VALUE · 2 MONTHS FREE',
                        style: TextStyle(
                          color: Color(0xFFB45309),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: const [
                    Text(
                      '\$149',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                      ),
                    ),
                    Text(
                      '/ year',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '· approx. \$12.42/mo',
                      style: TextStyle(
                        color: AppColors.bananiPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'Full unrestricted access to all 40+ interactive AI architecture sandboxes, live breakout sprint rooms & verified credentials.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.0,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14.0),
                _buildCheckItem('Unlimited access to 40+ production AI lab tracks'),
                const SizedBox(height: 6.0),
                _buildCheckItem('Host & join private peer review breakout rooms'),
                const SizedBox(height: 6.0),
                _buildCheckItem('Verifiable cryptographic Fluency Index badges'),
                const SizedBox(height: 6.0),
                _buildCheckItem('Dedicated cloud GPU compute with zero queue wait'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14.0),

        // Monthly Card ($19/mo)
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _isAnnual = false);
          },
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: !_isAnnual ? AppColors.bananiLavender : AppColors.pureWhite,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: !_isAnnual ? AppColors.bananiPrimary : AppColors.cardBorder,
                width: !_isAnnual ? 2.0 : 1.0,
              ),
              boxShadow: !_isAnnual
                  ? [
                      BoxShadow(
                        color: AppColors.bananiPrimary.withValues(alpha: 0.16),
                        blurRadius: 14.0,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : AppColors.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: [
                    const Text(
                      'All-Access Monthly Pass',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'FLEXIBLE BILLING',
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: const [
                    Text(
                      '\$19',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                      ),
                    ),
                    Text(
                      '/ month',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '· Cancel anytime with 1 click',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'Full month-by-month access to complete current active sprints and validate applied agent workflows.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.0,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14.0),
                _buildCheckItem('Full access to all 40+ interactive sandboxes'),
                const SizedBox(height: 6.0),
                _buildCheckItem('Live sprint breakout rooms & peer reviews'),
                const SizedBox(height: 6.0),
                _buildCheckItem('Profile completion certificates & XP tracking'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          size: 16.0,
          color: AppColors.softGreen,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesMatrix() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: AppColors.softShadow,
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FEATURE INCLUSION MATRIX',
            style: TextStyle(
              color: AppColors.bananiPrimary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14.0),
          _buildMatrixRow('Interactive Sandboxes', '2 Free Labs', 'All 40+ Labs'),
          const Divider(height: 18.0, color: AppColors.cardBorder),
          _buildMatrixRow('Peer Review Rooms', 'Read Only', 'Host & Join Live'),
          const Divider(height: 18.0, color: AppColors.cardBorder),
          _buildMatrixRow('Cryptographic Badges', 'None', 'Verified Fluency Index'),
          const Divider(height: 18.0, color: AppColors.cardBorder),
          _buildMatrixRow('Container Execution', 'Standard Queue', 'Priority GPU Dedicated'),
        ],
      ),
    );
  }

  Widget _buildMatrixRow(String feature, String freeTier, String vipTier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            feature,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            freeTier,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            vipTier,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: AppColors.bananiPrimary,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryActionButton(BuildContext context) {
    final String label = _isAnnual
        ? 'Subscribe to All-Access Annual (\$149/yr) ➔'
        : 'Subscribe to All-Access Monthly (\$19/mo) ➔';

    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _handleSubscribe,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bananiPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          shadowColor: AppColors.bananiPrimary.withValues(alpha: 0.35),
        ),
        child: _isProcessing
            ? const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.white,
                ),
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.workspace_premium_rounded,
                      size: 18.0,
                      color: Color(0xFFFBBF24),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildGuaranteeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 15.0,
            color: Color(0xFF059669),
          ),
          SizedBox(width: 6.0),
          Flexible(
            child: Text(
              '14-Day Money-Back Guarantee · Cancel Anytime in 1 Click',
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
