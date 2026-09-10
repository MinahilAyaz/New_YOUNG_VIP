import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';

class PremiumLabView extends StatefulWidget {
  final bool isRootTab;

  const PremiumLabView({
    super.key,
    this.isRootTab = false,
  });

  @override
  State<PremiumLabView> createState() => _PremiumLabViewState();
}

class _PremiumLabViewState extends State<PremiumLabView> {
  int _selectedMethodIndex = 0;
  final TextEditingController _amountController =
      TextEditingController(text: '29,00');

  final List<Map<String, dynamic>> _membershipPlans = [
    {
      'title': 'Full Lab Access Pass',
      'subtitle': 'All 40+ interactive sandboxes & live tracks',
      'icon': Icons.science_rounded,
      'color': AppColors.pastelPeach,
    },
    {
      'title': 'Peer Rooms & Sprints',
      'subtitle': 'Host private breakout rooms & live peer reviews',
      'icon': Icons.forum_rounded,
      'color': AppColors.pastelLilac,
    },
    {
      'title': 'Expert Studio Creator Suite',
      'subtitle': 'Author new labs, publish sprints & full analytics',
      'icon': Icons.auto_awesome_rounded,
      'color': AppColors.periwinkle,
    },
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 24.0 : screenWidth * 0.055;

    return Scaffold(
      backgroundColor: AppColors.peachBackground,
      drawer: const CustomDrawer(),
      body: SafeArea(
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
                    const SizedBox(height: 20.0),
                    _buildHeading(),
                    const SizedBox(height: 18.0),
                    _buildViaVirtualAccountPill(),
                    const SizedBox(height: 22.0),
                    _buildAmountCard(),
                    const SizedBox(height: 20.0),
                    _buildSectionHeader('Choose Pass Plan'),
                    const SizedBox(height: 12.0),
                    _buildPaymentMethodsList(),
                    const SizedBox(height: 24.0),
                    _buildQuickPayBar(context),
                    const SizedBox(height: 88.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.isRootTab
          ? null
          : const CustomBottomNavBar(
              currentIndex: 2,
            ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: AppColors.buttonShadow,
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.deepInk,
                    size: 20.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                const YoungVipWordmark(),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: AppColors.buttonShadow,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.deepInk,
                    size: 20.0,
                  ),
                  Positioned(
                    top: 9.0,
                    right: 9.0,
                    child: Container(
                      width: 7.0,
                      height: 7.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: AppColors.buttonShadow,
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.deepInk,
                size: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'VIP Pass',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Unlock unlimited interactive labs, peer rooms & expert studio',
          style: TextStyle(
            color: Color(0xFF8E8D88),
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildViaVirtualAccountPill() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.pastelPeach,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: AppColors.buttonShadow,
      ),
      alignment: Alignment.center,
      child: const Text(
        'VIA ALL-ACCESS VIP PASS',
        style: TextStyle(
          color: AppColors.deepInk,
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MEMBERSHIP TIER',
            style: TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '\$',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: AppColors.peachBackground,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  '/ month',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 14.5,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return Column(
      children: List.generate(_membershipPlans.length, (index) {
        final item = _membershipPlans[index];
        final bool isSelected = _selectedMethodIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedMethodIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: isSelected ? AppColors.deepInk : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD49B85).withValues(alpha: 0.10),
                  blurRadius: 14.0,
                  offset: const Offset(0, 4.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: AppColors.deepInk,
                    size: 22.0,
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF8E8D88),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.deepInk,
                    size: 22.0,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuickPayBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.deepInk,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            content: Text(
              'Activated ${_membershipPlans[_selectedMethodIndex]['title']} successfully!',
              style: const TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: AppColors.softShadow,
        ),
        alignment: Alignment.center,
        child: const Text(
          'ACTIVATE VIP PASS',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
