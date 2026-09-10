import 'package:flutter/material.dart';
import '../../views/main_navigation_view.dart';

class TabNavigationService {
  static void Function(int index)? onSwitchTab;

  static void switchToTab(BuildContext context, int index) {
    if (onSwitchTab != null) {
      // If there are pushed sub-routes above MainNavigationView, pop them first
      Navigator.of(context).popUntil((route) => route.isFirst);
      onSwitchTab!(index);
    } else {
      // If on Homepage or outside MainNavigationView, transition directly to the tab shell
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => MainNavigationView(initialIndex: index),
        ),
        (route) => false,
      );
    }
  }
}

