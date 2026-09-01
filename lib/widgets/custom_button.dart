import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBg = backgroundColor ??
        (isPrimary ? AppColors.royalIndigo : Colors.transparent);
    final Color effectiveFg =
        textColor ?? (isPrimary ? AppColors.pureWhite : AppColors.royalIndigo);

    if (isPrimary || backgroundColor != null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 11.0),
          minimumSize: const Size(0, 38),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: effectiveFg,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveFg,
          side: BorderSide(color: effectiveFg, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          minimumSize: const Size(0, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: effectiveFg,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
