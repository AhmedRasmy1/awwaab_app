import 'package:awwaab_app/core/res/app_typography.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppTypography.fontFamily,
    scaffoldBackgroundColor: ColorManager.scaffold,

    colorScheme: const ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.secondary,
      surface: ColorManager.scaffold,
    ),

    textTheme: AppTypography.textTheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
        fontFamily: AppTypography.fontFamily,
      ),
      iconTheme: IconThemeData(color: ColorManager.primary),
    ),

    cardTheme: CardThemeData(
      color: ColorManager.card,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: AppTypography.fontFamily,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: ColorManager.divider,
      thickness: 1,
    ),
  );
}
