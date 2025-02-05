import 'dart:io';

import 'package:account_management/core/constatnts/constatnts.dart';
import 'package:account_management/core/services/dio_provider.dart';
import 'package:account_management/core/services/local_storage.dart';
import 'package:account_management/features/user/data/view_model/profile_res_model/profile_res_model.dart';
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
        return Data.fromJson(
            response.data); // ✅ لا يوجد كائن data، البيانات مباشرةً
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
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });
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
}
