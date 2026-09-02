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
        hintStyle: const TextStyle(
          color: AppColors.searchHint,
          fontSize: 13.5,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.pureWhite,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: const Color(0xFF5C93C4),
                size: 19.0,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: const BorderSide(
            color: Color(0xFFEDE7F2),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: const BorderSide(
            color: Color(0xFFEDE7F2),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: const BorderSide(
            color: AppColors.mutedPurple,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 11.0,
        ),
      ),
    );
  }
}
