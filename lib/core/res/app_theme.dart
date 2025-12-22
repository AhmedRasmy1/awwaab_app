import 'package:awwaab_app/core/res/app_typography.dart';
import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ضفت دي عشان أيقونات البطارية والشبكة تبيض في الداكن

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
      systemOverlayStyle: SystemUiOverlayStyle.dark, // أيقونات سوداء
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
        fontFamily: AppTypography.arabicFontFamily,
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

  // =========================
  // 🌙 DARK THEME (الإضافة الجديدة)
  // =========================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark, // مهم عشان الفلاتر يفهم إنه ليلي
    fontFamily: AppTypography.fontFamily,
    scaffoldBackgroundColor: const Color(0xFF1A1D1A), // الخلفية الغامقة

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF2D5A42), // أخضر أهدى شوية لليل
      secondary: ColorManager.secondary, // الذهبي زي ما هو
      surface: Color(0xFF242826), // لون الكروت الغامق
      onSurface: Color(0xFFF9F9F7), // لون النصوص الفاتح
    ),

    // هنا بنقوله خد ستايل النصوص بتاعنا بس اقلب الألوان أبيض
    textTheme: AppTypography.textTheme.apply(
      bodyColor: const Color(0xFFF9F9F7),
      displayColor: const Color(0xFFF9F9F7),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light, // أيقونات بيضاء
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9F9F7), // النص أبيض
        fontFamily: AppTypography.arabicFontFamily,
      ),
      iconTheme: IconThemeData(color: Color(0xFFF9F9F7)), // الأيقونات بيضاء
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF242826), // خلفية الكارت الغامقة
      elevation: 2,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0x14FFFFFF),
        ), // بوردر خفيف أبيض شفاف
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2D5A42), // الأخضر الليلي
        foregroundColor: const Color(0xFFF9F9F7),
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
      color: Color(0x14FFFFFF), // الفاصل لونه أبيض شفاف
      thickness: 1,
    ),
  );
}
