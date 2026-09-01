import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../views/discover_view.dart';
import '../views/lab_room_view.dart';
import '../views/labs_view.dart';
import '../views/my_builds_view.dart';
import '../views/my_fluency_view.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  static void handleNavigation(
      BuildContext context, int targetIndex, int currentIndex) {
    if (targetIndex == currentIndex) return;
    switch (targetIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DiscoverView()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LabsView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LabRoomView()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyBuildsView()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyFluencyView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTwoBarsIcon(Color color) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 3.0,
              height: 12.0,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 1.2),
                borderRadius: BorderRadius.circular(1.0),
              ),
            ),
            const SizedBox(width: 3.0),
            Container(
              width: 3.0,
              height: 12.0,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 1.2),
                borderRadius: BorderRadius.circular(1.0),
              ),
            ),
          ],
        ),
      );
    }

    Widget navBar = BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.warmIvory,
      selectedItemColor: AppColors.royalIndigo,
      unselectedItemColor: AppColors.blueGray.withValues(alpha: 0.7),
      selectedFontSize: 10.0,
      unselectedFontSize: 10.0,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      elevation: 0,
      items: [
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.auto_awesome, size: 14.0),
          ),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: buildTwoBarsIcon(
            currentIndex == 1
                ? AppColors.royalIndigo
                : AppColors.blueGray.withValues(alpha: 0.7),
          ),
          label: 'Labs',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.circle_outlined, size: 14.0),
          ),
          label: 'Rooms',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.hexagon_outlined, size: 14.0),
          ),
          label: 'Builds',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.star, size: 14.0),
          ),
          label: 'Fluency',
        ),
      ],
      onTap: onTap ?? (index) => handleNavigation(context, index, currentIndex),
    );

    return Container(
      color: AppColors.warmIvory,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540.0),
          child: navBar,
        ),
      ),
    );
  }
}
