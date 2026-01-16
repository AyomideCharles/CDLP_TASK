import 'package:cpld_task/models/login_model.dart';
import 'package:cpld_task/models/user_model.dart';
import 'package:cpld_task/services/api_urls.dart';
import 'package:cpld_task/services/http_client.dart';
import 'package:cpld_task/services/secure_storage.dart';

class ApiAuthService {
  final SecureStorage secureStorage = SecureStorage();
  final ApiClient httpClient = ApiClient();

  Future<LoginModel> login(formData) async {
    return await httpClient.post(
      ApiUrls.login,
      body: formData,
      fromJson: (json) => LoginModel.fromJson(json),
    );
  }

  Future<UserModel> getUserInfo() async {
    return await httpClient.get(
      ApiUrls.userInfo,
      requiresAuth: true,
      fromJson: (json) => UserModel.fromJson(json),
    );
  }
}
