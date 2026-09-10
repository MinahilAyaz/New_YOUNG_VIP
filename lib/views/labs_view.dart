import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'lab_detail_view.dart';

class LabsView extends StatefulWidget {
  final bool isRootTab;

  const LabsView({
    super.key,
    this.isRootTab = false,
  });

  @override
  State<LabsView> createState() => _LabsViewState();
}

class _LabsViewState extends State<LabsView> {
  int _selectedDayIndex = 2; // Tue 28
  final ScrollController _cardScrollController = ScrollController();

  final List<Map<String, String>> _weekDays = [
    {'day': 'Sun', 'date': '26'},
    {'day': 'Mon', 'date': '27'},
    {'day': 'Tue', 'date': '28'},
    {'day': 'Wed', 'date': '29'},
    {'day': 'Thu', 'date': '30'},
    {'day': 'Fri', 'date': '01'},
    {'day': 'Sat', 'date': '02'},
  ];

  final List<Map<String, dynamic>> _domainCards = [
    {
      'title': 'AI Agents &\nWorkflows',
      'amount': '14 Labs',
      'icon': Icons.bolt_rounded,
      'bgColor': AppColors.pastelPeach,
    },
    {
      'title': 'RAG & Vector\nPipelines',
      'amount': '12 Labs',
      'icon': Icons.lightbulb_rounded,
      'bgColor': AppColors.pastelLilac,
    },
    {
      'title': 'Security &\nSandboxes',
      'amount': '8 Labs',
      'icon': Icons.security_rounded,
      'bgColor': AppColors.periwinkle,
    },
    {
      'title': 'Autonomous\nAutomation',
      'amount': '6 Labs',
      'icon': Icons.settings_rounded,
      'bgColor': AppColors.blushPink,
    },
  ];

  final List<Map<String, dynamic>> _activeLabTracks = [
    {
      'title': 'Agentic Reasoning Loop',
      'subtitle': 'Multi-agent debate & consensus evaluation',
      'stage': 'Stage 3',
      'icon': Icons.psychology_rounded,
      'iconColor': const Color(0xFF9C6FE4),
      'bgColor': const Color(0xFFF3EAFE),
    },
    {
      'title': 'Cross-Domain RAG Retrieval',
      'subtitle': 'Hybrid keyword & dense semantic embeddings',
      'stage': 'Stage 2',
      'icon': Icons.storage_rounded,
      'iconColor': const Color(0xFFE57373),
      'bgColor': const Color(0xFFFFF0ED),
    },
    {
      'title': 'Prompt Injection Defense',
      'subtitle': 'Defending LLM tool-calling against jailbreaks',
      'stage': 'Stage 1',
      'icon': Icons.security_rounded,
      'iconColor': const Color(0xFF9C6FE4),
      'bgColor': const Color(0xFFF3EAFE),
    },
    {
      'title': 'Enterprise Sandbox Deployment',
      'subtitle': 'Production-ready automated test harness',
      'stage': 'Stage 4',
      'icon': Icons.rocket_launch_rounded,
      'iconColor': const Color(0xFFE57373),
      'bgColor': const Color(0xFFFFF0ED),
    },
  ];

  @override
  void dispose() {
    _cardScrollController.dispose();
    super.dispose();
  }

  void _scrollCardsForward() {
    if (_cardScrollController.hasClients) {
      _cardScrollController.animateTo(
        _cardScrollController.offset + 180.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
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
                    const SizedBox(height: 18.0),
                    _buildCalendarStrip(),
                    const SizedBox(height: 20.0),
                    _buildExpensesHeader(),
                    const SizedBox(height: 18.0),
                    _buildCardsWithOverlappingArrow(),
                    const SizedBox(height: 24.0),
                    _buildSectionTitle('Active Lab Tracks'),
                    const SizedBox(height: 14.0),
                    _buildTransactionsList(),
                    const SizedBox(height: 22.0),
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
              currentIndex: 1,
            ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Builder(
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
                  const Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: YoungVipWordmark(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('All active lab track notifications caught up.'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
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
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LabDetailView()),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarStrip() {
    return SizedBox(
      height: 64.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: _weekDays.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10.0),
        itemBuilder: (context, index) {
          final isSelected = _selectedDayIndex == index;
          final item = _weekDays[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52.0,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.pastelPeach : AppColors.pureWhite,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: isSelected
                    ? AppColors.buttonShadow
                    : [
                        BoxShadow(
                          color: const Color(0xFFD49B85).withValues(alpha: 0.08),
                          blurRadius: 10.0,
                          offset: const Offset(0, 3.0),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['day']!,
                    style: TextStyle(
                      color: isSelected ? AppColors.deepInk : AppColors.roomCardSubtext,
                      fontSize: 12.0,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item['date']!,
                    style: TextStyle(
                      color: isSelected ? AppColors.deepInk : AppColors.deepInk.withValues(alpha: 0.6),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpensesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Interactive Labs',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(width: 6.0),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.deepInk,
                  size: 26.0,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD49B85).withValues(alpha: 0.08),
                blurRadius: 8.0,
                offset: const Offset(0, 2.0),
              ),
            ],
          ),
          child: const Text(
            'Active Sprint',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardsWithOverlappingArrow() {
    return SizedBox(
      height: 220.0,
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none,
        children: [
          ListView.separated(
            controller: _cardScrollController,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(right: 32.0),
            itemCount: _domainCards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16.0),
            itemBuilder: (context, index) {
              final card = _domainCards[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LabDetailView()),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 175.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: card['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(28.0),
                    boxShadow: AppColors.softShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 44.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Icon(
                          card['icon'] as IconData,
                          color: AppColors.deepInk,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card['title'] as String,
                            style: const TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            card['amount'] as String,
                            style: TextStyle(
                              color: AppColors.deepInk.withValues(alpha: 0.60),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Overlapping circular white arrow button
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: _scrollCardsForward,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  shape: BoxShape.circle,
                  boxShadow: AppColors.softShadow,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.deepInk,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 14.5,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      children: _activeLabTracks.map((item) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LabDetailView()),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(20.0),
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
                    color: item['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['iconColor'] as Color,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: AppColors.peachBackground.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    item['stage'] as String,
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickPayBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LabDetailView()),
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
          'ENTER ACTIVE LAB',
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
