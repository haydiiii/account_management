
import 'package:account_management/core/services/local_storage.dart';
import 'package:dio/dio.dart';

class AddUserRepo {
  Future<Map<String, dynamic>> addUser(
    String name,
    String email,
    String? phone,
    String password,

  
  ) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
         
      });
      String token =
          AppLocalStorage.getCachData(key: AppLocalStorage.token) ?? '';

      final response = await Dio().post(
        'https://employee.ammarelgendy.com/api/user',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.data}');
        return response.data; // Successful response
      } else {
        print('Error: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      print('Error during image upload: $e');
      throw Exception('Error during image upload: $e');
    }
  }
}
