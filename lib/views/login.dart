import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
              SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
