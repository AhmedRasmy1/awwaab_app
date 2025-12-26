import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:awwaab_app/features/azkar/data/azkar_model.dart';
import 'package:awwaab_app/features/azkar/data/hadith_model.dart';

class DataLoaderService {
  // دالة مساعدة لتحديد الأيقونة حسب اسم القسم (محدثة لتشمل كل الأقسام المحتملة)
  static String _getImageForCategory(String categoryName) {
    if (categoryName.contains("الصباح")) return "morning";
    if (categoryName.contains("المساء")) return "evening";
    if (categoryName.contains("النوم")) return "sleep";
    if (categoryName.contains("الاستيقاظ")) return "wake_up";
    if (categoryName.contains("الصلاة") || categoryName.contains("الآذان"))
      return "mosque"; // الآذان والمسجد نفس الأيقونة
    if (categoryName.contains("الوضوء")) return "wudu";
    if (categoryName.contains("المسجد")) return "mosque";
    if (categoryName.contains("الطعام")) return "food";
    if (categoryName.contains("المنزل")) return "home";
    if (categoryName.contains("السفر")) return "travel";
    // 👇 إضافات عشان تغطي باقي ملف azkar_obj.json
    if (categoryName.contains("الخلاء")) return "toilet";
    if (categoryName.contains("اللباس") || categoryName.contains("الثوب"))
      return "clothes";
    if (categoryName.contains("الهم") ||
        categoryName.contains("الدين") ||
        categoryName.contains("الحزن"))
      return "worry"; // أو أيقونة قلب/دعاء
    if (categoryName.contains("المريض") || categoryName.contains("مرض"))
      return "sick";
    if (categoryName.contains("الاستخارة"))
      return "istikhara"; // ممكن أيقونة علامة صح أو صلاة

    return "azkar"; // أيقونة افتراضية للباقي
  }

  // دالة تحميل الأذكار (المعدلة للملف الجديد azkar_obj.json)
  static Future<List<AzkarCategoryModel>> loadAzkar() async {
    try {
      // 1. قراءة الملف الصحيح
      final String response = await rootBundle.loadString(
        'assets/data/azkar_obj.json',
      );
      final List<dynamic> data = json.decode(response);

      // 2. تجميع الأذكار (Grouping Logic)
      // الخريطة دي بتجمع الأذكار تحت اسم القسم بتاعها
      Map<String, List<AzkarItemModel>> groupedAzkar = {};

      for (var item in data) {
        // اسم القسم (أذكار الصباح، أذكار المساء، إلخ)
        String categoryName = item['category'] ?? "أذكار متنوعة";

        // تحويل الـ JSON لموديل باستخدام AzkarItemModel المعدل
        AzkarItemModel zekrModel = AzkarItemModel.fromJson(item);

        // لو القسم ده جديد، نفتحله قائمة
        if (!groupedAzkar.containsKey(categoryName)) {
          groupedAzkar[categoryName] = [];
        }

        // نضيف الذكر للقائمة
        groupedAzkar[categoryName]!.add(zekrModel);
      }

      // 3. تحويل الخريطة لقائمة Categories جاهزة للعرض
      List<AzkarCategoryModel> finalCategories = [];

      groupedAzkar.forEach((catName, zekrList) {
        finalCategories.add(
          AzkarCategoryModel(
            category: catName,
            image: _getImageForCategory(catName), // تحديد الصورة أوتوماتيك
            array: zekrList,
          ),
        );
      });

      return finalCategories;
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
