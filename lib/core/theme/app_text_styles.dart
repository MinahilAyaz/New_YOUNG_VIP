import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const List<String> _fallbacks = ['sans-serif', 'Arial', 'Roboto'];

  static TextStyle headingLarge = GoogleFonts.plusJakartaSans(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColors.deepInk,
    letterSpacing: -0.5,
  ).copyWith(fontFamilyFallback: _fallbacks);

  static TextStyle headingMedium = GoogleFonts.plusJakartaSans(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.deepInk,
    letterSpacing: -0.3,
  ).copyWith(fontFamilyFallback: _fallbacks);

  static TextStyle headingSmall = GoogleFonts.plusJakartaSans(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: AppColors.deepInk,
  ).copyWith(fontFamilyFallback: _fallbacks);

  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.deepInk,
  ).copyWith(fontFamilyFallback: _fallbacks);

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.deepInk,
  ).copyWith(fontFamilyFallback: _fallbacks);

  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.deepInk,
  ).copyWith(fontFamilyFallback: _fallbacks);

  static TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.blueGray,
  ).copyWith(fontFamilyFallback: _fallbacks);
}
