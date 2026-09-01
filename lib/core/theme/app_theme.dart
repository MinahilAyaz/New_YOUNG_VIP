import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class GmailSlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const GmailSlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn.flipped,
    );

    final slideIn = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(curvedAnimation);

    final curvedSecondaryAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn.flipped,
    );

    final slideOut = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.25, 0.0),
    ).animate(curvedSecondaryAnimation);

    return SlideTransition(
      position: slideOut,
      child: SlideTransition(
        position: slideIn,
        child: child,
      ),
    );
  }
}

class AppTheme {
  static ThemeData buildLightTheme() {
    final baseTextTheme = TextTheme(
      displayLarge: AppTextStyles.headingLarge,
      headlineMedium: AppTextStyles.headingMedium,
      titleLarge: AppTextStyles.headingSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelSmall: AppTextStyles.caption,
    );

    return ThemeData(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontFamilyFallback: const ['sans-serif', 'Arial', 'Roboto'],
      scaffoldBackgroundColor: AppColors.warmIvory,
      cardColor: AppColors.pureWhite,
      colorScheme: const ColorScheme.light(
        primary: AppColors.royalIndigo,
        secondary: AppColors.youngVipGold,
        surface: AppColors.porcelain,
        error: AppColors.coral,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: GmailSlidePageTransitionsBuilder(),
          TargetPlatform.iOS: GmailSlidePageTransitionsBuilder(),
          TargetPlatform.windows: GmailSlidePageTransitionsBuilder(),
          TargetPlatform.macOS: GmailSlidePageTransitionsBuilder(),
          TargetPlatform.linux: GmailSlidePageTransitionsBuilder(),
          TargetPlatform.fuchsia: GmailSlidePageTransitionsBuilder(),
        },
      ),
    );
  }
}
