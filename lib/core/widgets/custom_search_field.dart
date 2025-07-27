import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon, prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  const CustomTextField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      obscuringCharacter: "*",
      cursorColor: AppColors.kPrimaryColor,
      style: TextStyle(
        fontSize: 15.sp,
        color: AppColors.kBlackColor,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        isDense: true,
        errorStyle: TextStyle(fontSize: 12, color: Colors.red),
        filled: true,
        fillColor: AppColors.kWhiteColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        suffixIcon:
            isPassword
                ? Icon(Icons.visibility_off, color: AppColors.kGreyColor)
                : suffixIcon,
        prefixIcon: prefixIcon,
        label: Text(
          labelText,
          style: TextStyle(
            fontSize: 15,
            color: AppColors.kGreyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.kBorderSideColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.kBorderSideColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.kBorderSideColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
