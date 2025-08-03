import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon, prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;
  final bool isPassword;
  const CustomTextField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.isPassword = false,
    this.maxLines = 1, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      obscuringCharacter: "*",
      maxLines: maxLines,
      cursorColor: AppColors.kPrimaryColor,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 15.sp,
        color: AppColors.kBlackColor,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        isDense: true,
        errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
        filled: true,

        fillColor: AppColors.kWhiteColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        suffixIcon:
            isPassword
                ? const Icon(Icons.visibility_off, color: AppColors.kGreyColor)
                : suffixIcon,
        prefixIcon: prefixIcon,
        label: Text(
          labelText,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.kGreyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.kBorderSideColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.kBorderSideColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.kBorderSideColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
