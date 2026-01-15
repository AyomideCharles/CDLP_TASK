import 'dart:convert';
import 'package:cpld_task/models/login_model.dart';
import 'package:cpld_task/models/user_model.dart';
import 'package:cpld_task/services/api_urls.dart';
import 'package:cpld_task/services/secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiAuthService {
  final SecureStorage secureStorage = SecureStorage();

  Future<LoginModel> login(formData) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.login),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return loginModelFromJson(response.body);
      } else {
        throw (data['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserInfo() async {
    String? token = await secureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiUrls.userInfo),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return userModelFromJson(response.body);
      } else {
        throw (data['message'] ?? 'Failed to fetch user info');
      }
    } catch (e) {
      rethrow;
    }
  }
}
