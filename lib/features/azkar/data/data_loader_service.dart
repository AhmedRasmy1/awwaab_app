import 'dart:convert';
import 'package:awwaab_app/features/azkar/data/azkar_model.dart';
import 'package:awwaab_app/features/azkar/data/hadith_model.dart';
import 'package:flutter/services.dart'; // عشان نقرأ من الـ Assets

class DataLoaderService {
  // دالة تحميل الأذكار
  static Future<List<AzkarCategoryModel>> loadAzkar() async {
    try {
      // 1. نقرأ الملف كنص
      final String response = await rootBundle.loadString(
        'assets/data/azkar.json',
      );

      // 2. نحوله لـ JSON
      final List<dynamic> data = json.decode(response);

      // 3. نحوله لـ List of Models
      return data.map((e) => AzkarCategoryModel.fromJson(e)).toList();
    } catch (e) {
      print("Error loading Azkar: $e");
      return [];
    }
  }

  // دالة تحميل الأحاديث
  static Future<List<HadithModel>> loadHadith() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/hadith.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((e) => HadithModel.fromJson(e)).toList();
    } catch (e) {
      print("Error loading Hadith: $e");
      return [];
    }
  }
}
