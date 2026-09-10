import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'main_navigation_view.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _selectedTimeframeIndex = 2; // 0: 24H, 1: 7D, 2: 30D, 3: ALL

  final List<String> _timeframes = const ['24H', '7D', '30D', 'ALL-TIME'];

  void _exportTelemetryData() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 18.0),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'Telemetry dataset exported to CSV successfully.',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF065F46),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
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
            constraints: const BoxConstraints(maxWidth: 640.0),
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
                  const SizedBox(height: 16.0),
                  _buildTimeframeSelector(),
                  const SizedBox(height: 20.0),
                  _buildPrimaryKpiCards(screenWidth),
                  const SizedBox(height: 20.0),
                  _buildRevenueAllocationCard(),
                  const SizedBox(height: 20.0),
                  _buildLabPerformanceCard(),
                  const SizedBox(height: 20.0),
                  _buildAuditLogCard(),
                  const SizedBox(height: 20.0),
                  _buildActionToolbar(),
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
        width: 560.0,
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
                          builder: (_) =>
                              const MainNavigationView(initialIndex: 0),
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
            // Live Admin Telemetry Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4EC),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFA7F3D0),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF059669),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  const Text(
                    'ADMIN CONSOLE · LIVE',
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
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
                Icon(Icons.analytics_rounded,
                    size: 13.0, color: Color(0xFFD97706)),
                SizedBox(width: 4.0),
                Text(
                  'ENTERPRISE PLATFORM INTELLIGENCE',
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
          'Admin Dashboard',
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
          'Real-time overview of members, lab track completions, and subscription revenue from \$19/mo and \$149/yr plans.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: List.generate(_timeframes.length, (index) {
          final isSelected = _selectedTimeframeIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedTimeframeIndex = index);
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.pureWhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: isSelected ? AppColors.buttonShadow : null,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _timeframes[index],
                    style: TextStyle(
                      color:
                          isSelected ? AppColors.deepInk : AppColors.textSecondary,
                      fontSize: 12.0,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPrimaryKpiCards(double screenWidth) {
    final isWide = screenWidth > 540;

    final membersCard = _buildKpiCard(
      title: 'TOTAL MEMBERS',
      value: '14,820',
      badgeText: '+18.4% MoM',
      badgeColor: const Color(0xFFE6F4EC),
      badgeTextColor: const Color(0xFF065F46),
      icon: Icons.people_alt_rounded,
      iconColor: AppColors.bananiPrimary,
      iconBg: AppColors.bananiLavender,
      subtitle: '11,240 Free · 3,580 All-Access VIP',
    );

    final labsCard = _buildKpiCard(
      title: 'ACTIVE LAB TRACKS',
      value: '42 Tracks',
      badgeText: '98.6% Uptime',
      badgeColor: const Color(0xFFFEF3C7),
      badgeTextColor: const Color(0xFFB45309),
      icon: Icons.science_rounded,
      iconColor: const Color(0xFF059669),
      iconBg: const Color(0xFFD1FAE5),
      subtitle: '38 Public Sandboxes · 4 VIP Sprints',
    );

    final revenueCard = _buildKpiCard(
      title: 'GROSS PLATFORM REVENUE',
      value: '\$186,450',
      badgeText: '+24.2% MoM',
      badgeColor: const Color(0xFFE6F4EC),
      badgeTextColor: const Color(0xFF065F46),
      icon: Icons.payments_rounded,
      iconColor: const Color(0xFFD97706),
      iconBg: const Color(0xFFFEF3C7),
      subtitle: 'MRR: \$23,940 · \$149/yr (72%) | \$19/mo (28%)',
    );

    final fluencyCard = _buildKpiCard(
      title: 'FLUENCY CREDENTIALS',
      value: '88.4 / 100',
      badgeText: '4,920 Badges',
      badgeColor: const Color(0xFFF1EFFF),
      badgeTextColor: AppColors.bananiPrimary,
      icon: Icons.workspace_premium_rounded,
      iconColor: AppColors.bananiPrimary,
      iconBg: AppColors.bananiLavender,
      subtitle: 'Cryptographic proof-of-fluency on-chain',
    );

    if (isWide) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: membersCard),
              const SizedBox(width: 14.0),
              Expanded(child: labsCard),
            ],
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(child: revenueCard),
              const SizedBox(width: 14.0),
              Expanded(child: fluencyCard),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          membersCard,
          const SizedBox(height: 12.0),
          labsCard,
          const SizedBox(height: 12.0),
          revenueCard,
          const SizedBox(height: 12.0),
          fluencyCard,
        ],
      );
    }
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(icon, color: iconColor, size: 20.0),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 26.0,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.8,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueAllocationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              const Text(
                'REVENUE ALLOCATION',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  '\$186.4K ARR',
                  style: TextStyle(
                    color: Color(0xFFB45309),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Subscription Plan Split',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Annual VIP pass provides 72% of recurring ARR with 2.4x higher net member retention.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16.0),
          // Stacked Visual Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 14.0,
              child: Row(
                children: [
                  Expanded(
                    flex: 72,
                    child: Container(
                      color: AppColors.bananiPrimary,
                    ),
                  ),
                  const SizedBox(width: 2.0),
                  Expanded(
                    flex: 28,
                    child: Container(
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 14.0,
            runSpacing: 6.0,
            children: [
              _buildLegendItem(
                color: AppColors.bananiPrimary,
                label: 'All-Access Annual (\$149/yr)',
                value: '72% (\$134,244)',
              ),
              _buildLegendItem(
                color: const Color(0xFFF59E0B),
                label: 'All-Access Monthly (\$19/mo)',
                value: '28% (\$52,206)',
              ),
            ],
          ),
          const Divider(height: 24.0, color: AppColors.cardBorder),
          // Financial Health Grid
          Row(
            children: [
              Expanded(
                child: _buildFinancialMetricItem(
                  label: 'ARPU',
                  value: '\$52.08',
                  hint: 'Avg. Revenue / User',
                ),
              ),
              Expanded(
                child: _buildFinancialMetricItem(
                  label: 'Churn Rate',
                  value: '1.2%',
                  hint: 'Subscribers / Mo',
                ),
              ),
              Expanded(
                child: _buildFinancialMetricItem(
                  label: 'Net LTV',
                  value: '\$348.50',
                  hint: 'Lifetime Value',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String value,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            '$label: ',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetricItem({
    required String label,
    required String value,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2.0),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 2.0),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 9.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabPerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              const Text(
                'LAB TRACK ENGAGEMENT',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  '42 TOTAL TRACKS',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _buildLabRow(
            name: 'Autonomous Multi-Agent Swarms',
            tier: 'VIP ONLY',
            tierColor: const Color(0xFFFEF3C7),
            tierTextColor: const Color(0xFFB45309),
            builders: '4,820 builders',
            completion: '94% completion',
          ),
          const Divider(height: 18.0, color: AppColors.cardBorder),
          _buildLabRow(
            name: 'Real-Time Context Synthesizer',
            tier: 'FREE TRACK',
            tierColor: const Color(0xFFF1F5F9),
            tierTextColor: const Color(0xFF475569),
            builders: '3,940 builders',
            completion: '91% completion',
          ),
          const Divider(height: 18.0, color: AppColors.cardBorder),
          _buildLabRow(
            name: 'Cryptographic Proof of Fluency',
            tier: 'VIP ONLY',
            tierColor: const Color(0xFFFEF3C7),
            tierTextColor: const Color(0xFFB45309),
            builders: '3,210 builders',
            completion: '89% completion',
          ),
          const Divider(height: 18.0, color: AppColors.cardBorder),
          _buildLabRow(
            name: 'Prompt Injection Defense Arena',
            tier: 'FREE TRACK',
            tierColor: const Color(0xFFF1F5F9),
            tierTextColor: const Color(0xFF475569),
            builders: '2,890 builders',
            completion: '86% completion',
          ),
        ],
      ),
    );
  }

  Widget _buildLabRow({
    required String name,
    required String tier,
    required Color tierColor,
    required Color tierTextColor,
    required String builders,
    required String completion,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: tierColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                tier,
                style: TextStyle(
                  color: tierTextColor,
                  fontSize: 9.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: Text(
                builders,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                ),
              ),
            ),
            Text(
              completion,
              style: const TextStyle(
                color: Color(0xFF059669),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuditLogCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              const Text(
                'REAL-TIME AUDIT STREAM',
                style: TextStyle(
                  color: AppColors.bananiPrimary,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4EC),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'SYNCED',
                  style: TextStyle(
                    color: Color(0xFF065F46),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          _buildAuditRow(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFD97706),
            title: 'Alex Rivera upgraded to All-Access Annual (\$149/yr)',
            timestamp: '2m ago',
          ),
          const SizedBox(height: 10.0),
          _buildAuditRow(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF059669),
            title: 'Sarah Chen completed Stage 4: Advise Better (+18 XP)',
            timestamp: '7m ago',
          ),
          const SizedBox(height: 10.0),
          _buildAuditRow(
            icon: Icons.bolt_rounded,
            iconColor: AppColors.bananiPrimary,
            title: 'Marcus Vance launched autonomous swarm GPU sandbox',
            timestamp: '14m ago',
          ),
          const SizedBox(height: 10.0),
          _buildAuditRow(
            icon: Icons.verified_user_rounded,
            iconColor: const Color(0xFF0284C7),
            title: 'Credential #YVIP-8842 minted to cryptographic registry',
            timestamp: '22m ago',
          ),
        ],
      ),
    );
  }

  Widget _buildAuditRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String timestamp,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.0, color: iconColor),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          timestamp,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionToolbar() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: _exportTelemetryData,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bananiPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          shadowColor: AppColors.bananiPrimary.withValues(alpha: 0.3),
        ),
        child: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.file_download_outlined, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'Export Platform Telemetry Report (CSV)',
                style: TextStyle(
                  fontSize: 13.5,
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
}
