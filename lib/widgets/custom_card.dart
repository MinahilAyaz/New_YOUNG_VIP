import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.pureWhite,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(24.0),
        boxShadow: boxShadow ?? AppColors.softShadow,
        border: border,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
