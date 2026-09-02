import 'package:flutter/material.dart';
import '../core/navigation/tab_navigation_service.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'discover_view.dart';
import 'lab_room_view.dart';
import 'labs_view.dart';
import 'my_builds_view.dart';
import 'my_fluency_view.dart';

class MainNavigationView extends StatefulWidget {
  final int initialIndex;

  const MainNavigationView({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  late int _currentIndex;
  late PageController _pageController;

  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    TabNavigationService.onSwitchTab = _onTabTapped;
    _views = const [
      DiscoverView(isRootTab: true),
      LabsView(isRootTab: true),
      LabRoomView(isRootTab: true),
      MyBuildsView(isRootTab: true),
      MyFluencyView(isRootTab: true),
    ];
  }

  @override
  void dispose() {
    if (TabNavigationService.onSwitchTab == _onTabTapped) {
      TabNavigationService.onSwitchTab = null;
    }
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _views,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
