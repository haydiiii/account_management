import 'dart:io';

import 'package:account_management/core/constatnts/constatnts.dart';
import 'package:account_management/core/services/dio_provider.dart';
import 'package:account_management/core/services/local_storage.dart';
import 'package:account_management/features/admin/data/view_model/admin_convenant_for_employee.dart';
import 'package:account_management/features/admin/data/view_model/admin_expenses_for_employee.dart';
import 'package:account_management/features/admin/data/view_model/exenses_user_model.dart';
import 'package:account_management/features/admin/data/view_model/users_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AdminReo {
  Future<Map<String, dynamic>> createAdminConvenant(
      String? amount, String? note, File? image, int? userId) async {
    try {
      var url = AppConstants.baseUrl + AppConstants.createAdminCovenant;
      final formDatat = FormData.fromMap({
        'amount': amount,
        'notes': note,
        if (image != null)
          'img': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        'user_id': userId
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

  //////////////
  Future<Map<String, dynamic>> createAdminExpense(
      String? amount, String? note, File? image, int? userId) async {
    try {
      var url = AppConstants.baseUrl + AppConstants.createAdminExpense;
      final formDatat = FormData.fromMap({
        'amount': amount,
        'notes': note,
        if (image != null)
          'img': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        'user_id': userId
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
  ///////////////////////////////////////////////

  Future<List<UserModel>> fetchUsers() async {
    try {
      var url = AppConstants.baseUrl + AppConstants.users;
      String token = AppLocalStorage.getCachData(key: AppLocalStorage.token);

      final response = await DioProvider.get(
        endPoint: url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('فشل تحميل المستخدمين');
      }
    } catch (e) {
      debugPrint('خطأ أثناء جلب المستخدمين: $e');
      throw Exception('Error fetching users: $e');
    }
  }
  ////////////
Future<CovenantData> fetchCovenantForEmployee({
  required int id, 
  required int year, 
  required int month,
}) async {
  try {
    var url = "${AppConstants.baseUrl}${AppConstants.convenantforEmployee}/$id?year=$year&month=$month";
    
    String token = AppLocalStorage.getCachData(key: AppLocalStorage.token);

    final response = await DioProvider.get(
      endPoint: url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return CovenantData.fromJson(response.data['data']);
    } else {
      throw Exception('❌ فشل تحميل بيانات العهدة');
    }
  } catch (e) {
    debugPrint('❌ خطأ أثناء جلب بيانات العهدة: $e');
    throw Exception('Error fetching covenant data: $e');
  }
}
Future<ExpenseData> fetchExpensesForEmployee({
  required int id, 
  required int year, 
  required int month,
}) async {
  try {
    var url = "${AppConstants.baseUrl}${AppConstants.expensesforEmployee}/$id?year=$year&month=$month";
    
    String token = AppLocalStorage.getCachData(key: AppLocalStorage.token);

    final response = await DioProvider.get(
      endPoint: url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
return ExpenseData.fromMap(response.data['data']);
    } else {
      throw Exception('❌ فشل تحميل بيانات المصروفات');
    }
  } catch (e) {
    debugPrint('❌ خطأ أثناء جلب بيانات المصروفات: $e');
    throw Exception('Error fetching covenant data: $e');
  }
}
Future<List<Employee>> fetchExpensesUser({
  required int id, 
  required int year, 
  required int month,
}) async {
  try {
    var url = "${AppConstants.baseUrl}${AppConstants.expensesUser}/$id?year=$year&month=$month";      
    String token = AppLocalStorage.getCachData(key: AppLocalStorage.token);

    final response = await DioProvider.get(
      endPoint: url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // ✅ Parse entire JSON response using EmployeeResponse
      final EmployeeResponse employeeResponse = EmployeeResponse.fromJson(response.data);
      return employeeResponse.data; // ✅ Return List<Employee>
    } else {
      throw Exception('❌ فشل تحميل المستخدمين');
    }
  } catch (e) {
    debugPrint('❌ خطأ أثناء جلب المستخدمين: $e');
    throw Exception('Error fetching users: $e');
  }
}

  
}
