import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardChooser extends StatelessWidget {
  const CustomCardChooser({super.key, required this.title, this.icon, this.iconSize, this.onPressed});
  final String title;
  final IconData? icon;
  final double? iconSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 300.w,
                height: 300.h,
                child: MaterialButton(
                  onPressed: onPressed,
                  color: AppColors.kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        icon,
                        size: iconSize ?? 50.sp,
                        color: AppColors.kWhiteColor,
                      ),
                    ],
                  ),
                ),
              );
  }
}