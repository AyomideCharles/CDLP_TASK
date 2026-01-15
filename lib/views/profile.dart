import 'package:cpld_task/controllers/auth_controller.dart';
import 'package:cpld_task/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Full Name:', style: TextStyle(fontSize: 15)),
                  Text(
                    '${authController.userProfile.value.firstName ?? ''} ${authController.userProfile.value.lastName ?? ''}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Divider(height: 40, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Phone number:', style: TextStyle(fontSize: 15)),
                  Text(
                    authController.userProfile.value.phone ?? '',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Divider(height: 40, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Email Address:', style: TextStyle(fontSize: 15)),
                  Text(
                    authController.userProfile.value.email ?? '',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Divider(height: 40, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Username:', style: TextStyle(fontSize: 15)),
                  Text(
                    authController.userProfile.value.username ?? '',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Divider(height: 40, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Gender:', style: TextStyle(fontSize: 15)),
                  Text(
                    authController.userProfile.value.gender ?? '',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
