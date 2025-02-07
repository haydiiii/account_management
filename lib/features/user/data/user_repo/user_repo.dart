import 'dart:io';

import 'package:account_management/core/constatnts/constatnts.dart';
import 'package:account_management/core/services/dio_provider.dart';
import 'package:account_management/core/services/local_storage.dart';
import 'package:account_management/features/user/data/view_model/profile_res_model/profile_res_model.dart';
import 'package:account_management/features/user/data/view_model/user_convenant_res_model/user_convenant_res_model.dart';
import 'package:account_management/features/user/data/view_model/user_expenses_res_model/user_expenses_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepo {
  Future<Data?> profileData() async {
    try {
      var url = AppConstants.baseUrl + AppConstants.profile;
      String? token = AppLocalStorage.getCachData(key: AppLocalStorage.token);

      if (token == null || token.isEmpty) {
        debugPrint('🚨 خطأ: لم يتم العثور على رمز المصادقة (Token)');
        return null;
      }

      var response = await DioProvider.get(
        endPoint: url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('📡 جلب بيانات الملف الشخصي: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        debugPrint('✅ تم جلب بيانات الملف الشخصي بنجاح');
        return Data.fromJson(response.data['data']);
      } else {
        debugPrint(
            '❌ خطأ: فشل في جلب بيانات الملف الشخصي - كود الحالة: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('❌ خطأ أثناء جلب بيانات الملف الشخصي: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> creatSpendAmount(
      String? amount, String? note, File? image) async {
    try {
      var url = AppConstants.baseUrl + AppConstants.spendAmount;
      final formDatat = FormData.fromMap({
        'amount': amount,
        'notes': note,
        if (image != null)
          'img': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });
      debugPrint('Request URL: $url');

      String token =
          AppLocalStorage.getCachData(key: AppLocalStorage.token) ?? '';
      final response = await DioProvider.post(
          endPoint: url,
          data: formDatat,
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        debugPrint('Response: ${response.data}');
        return response.data; // Successful response
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      debugPrint('Error during image upload: $e');
      throw Exception('Error during image upload: $e');
    }
  }

 Future<UserConvenatresModel?> userConvenant(int year, int month) async {
  try {
    var url = "${AppConstants.baseUrl}${AppConstants.userConvenant}?year=$year&month=$month"; 

    String token = AppLocalStorage.getCachData(key: AppLocalStorage.token) ?? '';

    final response = await DioProvider.get(
      endPoint: url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 && response.data != null) {
      debugPrint('✅ تم جلب بيانات العهدة بنجاح');

      var responseData = response.data;
      if (responseData.containsKey('data') && responseData['data'] is Map) {
        return UserConvenatresModel.fromJson(responseData);
      } else {
        debugPrint('❌ البيانات المسترجعة غير صحيحة، لا تحتوي على key `data`.');
        return null;
      }
    } else {
      debugPrint('❌ خطأ: فشل في جلب بيانات العهدة - كود الحالة: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    debugPrint('❌ حدث خطأ أثناء جلب بيانات العهدة: $e. يرجى التحقق من الاتصال بالخادم.');
    return null;
  }
}



   Future<ExpensesResponse?> getUserExpenses(int year, int month) async {
  try {
    var url = '${AppConstants.baseUrl + AppConstants.userExpenses}?year=$year&month=$month';
    String token = AppLocalStorage.getCachData(key: AppLocalStorage.token) ?? '';

    final response = await DioProvider.get(
      endPoint: url,
      headers: {'Authorization': 'Bearer $token'},
    );

    debugPrint('🔹 API Response Status: ${response.statusCode}');
    debugPrint('🔹 API Response Data: ${response.data}');

    if (response.statusCode == 200 && response.data != null) {
      debugPrint('✅ تم جلب بيانات المصروفات بنجاح');
      return ExpensesResponse.fromJson(response.data);
    } else {
      debugPrint('❌ فشل في جلب بيانات المصروفات - كود الحالة: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    debugPrint('❌ خطأ أثناء جلب بيانات المصروفات: $e');
    return null;
  }
}

}
