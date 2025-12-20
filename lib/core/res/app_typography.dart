import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Cairo';

  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: ColorManager.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: ColorManager.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorManager.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorManager.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorManager.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
