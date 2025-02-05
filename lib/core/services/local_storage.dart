import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static String token = "token";
  static String role = "role"; // بدلاً من isAdmin يمكن استخدام role
  static late SharedPreferences _sharedPreferences;

  // تهيئة SharedPreferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> cacheData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    }
  }

  // استرجاع البيانات من SharedPreferences
  static dynamic getCachData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static String? getRole() {
    return _sharedPreferences.getString(role);
  }

  // إضافة طريقة لحذف البيانات المخزنة
  static Future<void> clearData() async {
    await _sharedPreferences.clear();
  }
}
