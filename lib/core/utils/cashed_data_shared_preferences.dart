import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static late SharedPreferences sharedPreferences;

  static cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is List<String>) {
      return await sharedPreferences.setString(key, jsonEncode(value));
    }
    return false;
  }

  static dynamic getData({required String key}) {
    final data = sharedPreferences.get(key);
    if (data is String && data.startsWith('[') && data.endsWith(']')) {
      try {
        return List<String>.from(jsonDecode(data));
      } catch (_) {}
    }
    return data;
  }

  static void deleteItem({required String key}) async {
    await sharedPreferences.remove(key);
  }

  static void clearItems() async {
    await sharedPreferences.clear();
  }
}

class CacheConstants {
  // static const String userToken = "userToken";
  // static const String role = "role";
  // static const String userEmail = "userEmail";
  // static const String userType = "userType";
  // static const String technichianService = 'technichianService';
  // static const String serviceId = 'serviceId';
  // static const String technicalId = 'TechnichianId';
  // static const String orderId = 'orderId';
}
