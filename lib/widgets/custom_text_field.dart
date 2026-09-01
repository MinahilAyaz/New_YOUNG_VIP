import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.blueGray.withValues(alpha: 0.8),
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.pureWhite,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.blueGray.withValues(alpha: 0.7),
                size: 20.0,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: AppColors.blueGray.withValues(alpha: 0.18),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: AppColors.blueGray.withValues(alpha: 0.18),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: AppColors.royalIndigo,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
      ),
    );
  }
}
