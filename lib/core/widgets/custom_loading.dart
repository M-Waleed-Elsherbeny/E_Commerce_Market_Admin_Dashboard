import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: color ?? AppColors.kPrimaryColor,
        ),
      ),
    );
  }
}
