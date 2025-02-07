import 'package:account_management/core/constatnts/constatnts.dart';
import 'package:account_management/core/services/dio_provider.dart';
import 'package:account_management/core/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginRepo {
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      var url = AppConstants.baseUrl + AppConstants.login;
      debugPrint('Login URL: $url');
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      var response = await DioProvider.post(endPoint: url, data: formData);
      if (response.statusCode == 200) {
        String token = response.data['data']['token'] ?? '';
        String role = response.data['data']['role'] ?? '';

        await AppLocalStorage.cacheData(
          key: AppLocalStorage.token,
          value: token,
        );
        await AppLocalStorage.cacheData(
          key: AppLocalStorage.role,
          value: role,
        );
        String cachedToken =
            AppLocalStorage.getCachData(key: AppLocalStorage.token);
        debugPrint('cachedToken: $cachedToken');

        debugPrint(response.data.toString());
        return response.data;
      } else {
        throw Exception(response.data['message']);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Exception('حدث خطأ ما');
    }
  }

  //  static Future<AuthResponseModel?> login(LoginModelParams params) async {
  //   try {
  //     var url = AppConstants.baseUrl + AuthEndPoints.login;
  //     var rsponse = await DioProvider.post(
  //       endPoint: url,
  //       data: params.toJson(),
  //     );

  //     var model = AuthResponseModel.fromJson(rsponse.data);
  //     if (rsponse.statusCode == 200) {
  //       return model;
  //     } else {
  //       return null;
  //     }
  //   } on Exception catch (e) {
  //     log(e.toString());
  //     return null;
  //   }
  // }
}
