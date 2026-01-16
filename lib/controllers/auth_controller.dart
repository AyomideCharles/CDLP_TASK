import 'package:cpld_task/models/login_model.dart';
import 'package:cpld_task/models/user_model.dart';
import 'package:cpld_task/services/api_auth_service.dart';
import 'package:cpld_task/services/secure_storage.dart';
import 'package:cpld_task/widgets/bottom_nav.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var user = Rxn<LoginModel>();
  final SecureStorage secureStorage = SecureStorage();
  Rx<UserModel> userProfile = UserModel().obs;

  RxBool signInPasswordVisible = false.obs;
  toggleSignInPasswordVisibility() {
    signInPasswordVisible.value = !signInPasswordVisible.value;
  }

  login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return Get.snackbar('Error', 'Please fill all fields');
    }
    var fomrData = {
      "username": usernameController.text,
      "password": passwordController.text,
    };
    try {
      isLoading.value = true;
      final userService = await ApiAuthService().login(fomrData);
      if (userService.accessToken.isNotEmpty) {
        user.value = userService;
        final token = userService.accessToken;
        final refreshToken = userService.refreshToken;
        await getUserInfo();
        usernameController.clear();
        passwordController.clear();
        await secureStorage.storeToken(token);
        await secureStorage.storeRefreshToken(refreshToken);
        Get.to(() => BottomNav());
      }
    } catch (e) {
      // print(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getUserInfo() async {
    try {
      final userInfo = await ApiAuthService().getUserInfo();
      userProfile.value = userInfo;
      print('User Info: ${userInfo.firstName} ${userInfo.lastName}');
      // Handle user info as needed
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
