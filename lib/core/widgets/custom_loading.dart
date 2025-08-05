import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.color = AppColors.kPrimaryColor,
    this.height,
    this.width,
  });
  final Color? color;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 50.h,
        width: width ?? 50.w,
        child: CircularProgressIndicator(color: color),
      ),
    );
  }
}
