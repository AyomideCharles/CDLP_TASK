import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool isNumberKeys;

  const CustomTextField({
    super.key,
    this.hint,
    this.controller,
    this.isNumberKeys = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.onPrimary,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 17.h,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
        ),
      ),
    );
  }
}
