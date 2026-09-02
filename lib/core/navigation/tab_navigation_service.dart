import 'package:flutter/material.dart';

class TabNavigationService {
  static void Function(int index)? onSwitchTab;

  static void switchToTab(BuildContext context, int index) {
    // If there are pushed sub-routes above MainNavigationView, pop them first
    Navigator.of(context).popUntil((route) => route.isFirst);
    if (onSwitchTab != null) {
      onSwitchTab!(index);
    }
  }
}
