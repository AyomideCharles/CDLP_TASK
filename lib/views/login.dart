import 'package:cpld_task/controllers/auth_controller.dart';
import 'package:cpld_task/widgets/buttons.dart';
import 'package:cpld_task/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Enter your credentials to continue'),
              SizedBox(height: 50),
              CustomTextField(
                hint: 'Username',
                controller: controller.usernameController,
              ),
              SizedBox(height: 30),
              CustomTextField(
                hint: 'Password',
                controller: controller.passwordController,
              ),
              SizedBox(height: 30),
              Obx(
                () => CustomButton(
                  text: 'Login',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.login();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
