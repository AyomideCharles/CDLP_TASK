import 'package:cpld_task/controllers/auth_controller.dart';
import 'package:cpld_task/widgets/buttons.dart';
import 'package:cpld_task/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
                hasSuffixIcon: true,
                suffixIcon: Icon(Iconsax.user),
              ),
              SizedBox(height: 30),
              Obx(
                () => CustomTextField(
                  isObscure: !controller.signInPasswordVisible.value,
                  hint: 'Password',
                  controller: controller.passwordController,
                  hasSuffixIcon: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.toggleSignInPasswordVisibility();
                    },
                    child: (controller.signInPasswordVisible.value)
                        ? const Icon(Iconsax.eye_slash4)
                        : const Icon(Iconsax.eye),
                  ),
                ),
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
