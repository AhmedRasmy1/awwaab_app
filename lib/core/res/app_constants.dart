import 'package:awwaab_app/main.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Awwaab";
  static const String appNameArabic = "أَوَّابٌ";
  static const String homeArabic = "الرئيسية";
  static const String quranArabic = "القرآن";
  static const String azkarArabic = "أذكار";
  static const String prayerArabic = "الصلاة";
  static const String settingsArabic = "الإعدادات";
  static const String fontFamily = 'Cairo';
  static const String appearanceArabic = "المظهر";
  static const String darkModeArabic = "الوضع الليلي";
  static const String disabledArabic = "مُعطّل";
  static const String enabledArabic = "مُفعّل";
  static const String readingArabic = "القراءة";
}

final List<Widget> screens = [
  HomePage(),
  const Center(child: Text('شاشة القرآن', style: TextStyle(fontSize: 30))),
  const Center(child: Text('شاشة الأذكار', style: TextStyle(fontSize: 30))),
  const Center(child: Text('شاشة الصلاة', style: TextStyle(fontSize: 30))),
];
