import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.pureWhite,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    final bool isWhite = backgroundColor == AppColors.pureWhite;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        border: isWhite
            ? Border.all(
                color: AppColors.blueGray.withValues(alpha: 0.15),
                width: 1.0,
              )
            : null,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
