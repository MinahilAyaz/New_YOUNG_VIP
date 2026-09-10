import 'package:flutter/material.dart';

class AppColors {
  // =========================================================================
  // --- Canonical Brand & Design System Tokens ---
  // =========================================================================
  static const Color bananiBackground = Color(0xFFFAF9F6); // Warm luxury ivory canvas
  static const Color bananiCard = Color(0xFFFFFFFF);       // Crisp pure white elevated card
  static const Color bananiBorder = Color(0xFFE9E5D9);     // Editorial subtle warm border
  static const Color bananiPrimary = Color(0xFF4A3FD6);    // Signature Royal Purple primary action
  static const Color bananiPrimaryFg = Color(0xFFFFFFFF);  // Primary button foreground
  static const Color bananiAccent = Color(0xFFD99A12);     // Signature Young VIP Gold
  static const Color bananiLavender = Color(0xFFF1EFFF);   // Soft lavender badge/tag surface
  static const Color bananiSuccess = Color(0xFF2F9E67);    // Emerald success green
  static const Color bananiSuccessSoft = Color(0xFFE6F4EC);// Soft success green badge surface
  static const Color bananiCoral = Color(0xFFD95C4F);      // Coral challenge/accent
  static const Color bananiCoralSoft = Color(0xFFFDEEEC);  // Soft coral badge surface
  static const Color bananiInk = Color(0xFF172033);        // Deep obsidian charcoal typography
  static const Color bananiSlate = Color(0xFF68738A);      // Refined slate secondary typography

  // =========================================================================
  // --- Screen Canvas & Elevated Surfaces (Harmonized) ---
  // =========================================================================
  static const Color peachBackground = bananiBackground;   // #FAF9F6 - All screens now share this canvas
  static const Color pureWhite = bananiCard;               // #FFFFFF - Crisp white card surface
  static const Color warmIvory = bananiBackground;         // #FAF9F6
  static const Color porcelain = bananiBackground;         // #FAF9F6
  static const Color alabaster = bananiBackground;         // #FAF9F6
  static const Color cardBg = pureWhite;                  // #FFFFFF
  static const Color borderLight = bananiBorder;           // #E9E5D9
  static const Color cardBorder = bananiBorder;            // #E9E5D9

  // =========================================================================
  // --- Typography & Text Hierarchy ---
  // =========================================================================
  static const Color deepInk = bananiInk;                 // #172033 - Titles, headings, high contrast
  static const Color textPrimary = bananiInk;             // #172033
  static const Color textSecondary = bananiSlate;         // #68738A - Subtitles, captions, metadata
  static const Color blueGray = bananiSlate;              // #68738A
  static const Color searchHint = bananiSlate;            // Clean search placeholder

  // =========================================================================
  // --- Brand Actions & Accents ---
  // =========================================================================
  static const Color royalIndigo = bananiPrimary;         // #4A3FD6 - Primary brand button & active states
  static const Color youngVipGold = bananiAccent;         // #D99A12 - Signature Young VIP Gold
  static const Color periwinkle = Color(0xFFA6B5F5);      // Soft periwinkle accent
  static const Color pastelLilac = Color(0xFFEAE7FC);      // Soft lavender lilac
  static const Color lightLavender = bananiLavender;      // #F1EFFF
  static const Color pastelPeach = bananiCoralSoft;       // #FDEEEC
  static const Color blushPink = Color(0xFFFCEAE8);       // Soft blush
  static const Color softGreen = bananiSuccess;           // #2F9E67 - Verified / Complete
  static const Color coral = bananiCoral;                 // #D95C4F - Alert / Urgent

  // =========================================================================
  // --- Elevated Surface Accents ---
  // =========================================================================
  static const Color heroCardPurple = pureWhite;
  static const Color heroCardBg = pureWhite;
  static const Color heroCardSubtext = textSecondary;
  static const Color roomCardBg = pureWhite;
  static const Color roomCardSubtext = textSecondary;
  static const Color mutedPurple = Color(0xFF8B80F9);

  // =========================================================================
  // --- Four Cohesive Domain / Category Cards ---
  // =========================================================================
  static const Color pastelSage = Color(0xFFE6F4EC);       // Domain 1 (AI Agents - Success Green Tint)
  static const Color pastelSageText = bananiSuccess;
  static const Color pastelLavender = bananiLavender;      // Domain 2 (RAG - Lavender Tint)
  static const Color pastelLavenderText = bananiPrimary;
  static const Color pastelCoral = bananiCoralSoft;        // Domain 3 (Security - Coral Tint)
  static const Color pastelCoralText = bananiCoral;
  static const Color pastelSand = Color(0xFFFEF7E6);       // Domain 4 (Automation - Warm Gold Tint)
  static const Color pastelSandText = bananiAccent;

  // =========================================================================
  // --- Avatar & Chips ---
  // =========================================================================
  static const Color avatarBg = bananiLavender;            // AV chip background
  static const Color avatarText = bananiPrimary;           // AV chip text

  // =========================================================================
  // --- Refined Shadows ---
  // =========================================================================
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: bananiInk.withValues(alpha: 0.04),
      blurRadius: 18.0,
      offset: const Offset(0, 4.0),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: bananiPrimary.withValues(alpha: 0.22),
      blurRadius: 12.0,
      offset: const Offset(0, 4.0),
      spreadRadius: 0,
    ),
  ];
}
