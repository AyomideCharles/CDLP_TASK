import 'package:cpld_task/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Profile Page'),
              onTap: () {
                // Get.changeTheme(ThemeData.light());
                themeController.switchTheme();
              },
            ),
            // ListTile(
            //   title: Text('Profile Page'),
            //   onTap: () {
            //     Get.changeTheme(ThemeData.dark());
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
