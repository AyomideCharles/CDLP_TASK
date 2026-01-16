import 'package:cpld_task/controllers/auth_controller.dart';
import 'package:cpld_task/controllers/theme_controller.dart';
import 'package:cpld_task/services/secure_storage.dart';
import 'package:cpld_task/utils/support.dart';
import 'package:cpld_task/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final SecureStorage secureStorageService = SecureStorage();

    Future<void> logout() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: Support.iosSpinner());
        },
      );
      await Future.delayed(const Duration(seconds: 3));
      await secureStorageService.deleteToken();
      Get.offAll(() => const Login());
    }

    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundImage: NetworkImage(
                  authController.userProfile.value.image ??
                      'https://via.placeholder.com/150',
                ),
              ),
              SizedBox(height: 40),

              profile(
                'Full Name:',
                '${authController.userProfile.value.firstName ?? ''} ${authController.userProfile.value.lastName ?? ''}',
              ),
              Divider(height: 40, thickness: 0.5),
              profile(
                'Phone number: ',
                authController.userProfile.value.phone ?? '',
              ),
              Divider(height: 40, thickness: 0.5),
              profile(
                'Email Address:',
                authController.userProfile.value.email ?? '',
              ),
              Divider(height: 40, thickness: 0.5),
              profile(
                'Username:',
                authController.userProfile.value.username ?? '',
              ),
              Divider(height: 40, thickness: 0.5),
              profile('Gender:', authController.userProfile.value.gender ?? ''),
              Divider(height: 40, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Switch Theme'),
                  Obx(
                    () => Switch(
                      padding: EdgeInsets.zero,
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {
                        themeController.switchTheme();
                      },
                    ),
                  ),
                ],
              ),
              Divider(height: 40, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logout'),
                  GestureDetector(
                    onTap: () {
                      Support.showCustomBottomSheet(
                        context,
                        (p0) => Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.cancel_outlined),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        border: Border.all(color: Colors.red),
                                      ),
                                      width: 160.w,
                                      height: 48.h,
                                      child: Center(
                                        child: Text(
                                          'Go Back',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      logout();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        color: Colors.red,
                                      ),
                                      width: 160.w,
                                      height: 48.h,
                                      child: Center(
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(Iconsax.logout, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile(String title, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(title, style: TextStyle(fontSize: 15)),
        Text(label, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
