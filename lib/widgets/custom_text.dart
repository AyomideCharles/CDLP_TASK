import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: const Color(0xFF070122),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp),
    );
  }
}

class GreyText extends StatelessWidget {
  const GreyText({super.key, required this.title, this.textAlign});
  final String title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
          color: const Color(0xFF6B6B6B),
          fontWeight: FontWeight.w400,
          fontSize: 13.sp),
    );
  }
}