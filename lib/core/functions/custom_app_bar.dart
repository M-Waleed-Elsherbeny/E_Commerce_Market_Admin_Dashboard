import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

AppBar buildCustomAppBar(
  BuildContext context,
  String title, {
  bool canPop = true,
}) {
  return AppBar(
    backgroundColor: AppColors.kPrimaryColor,
    centerTitle: true,
    toolbarHeight: MediaQuery.of(context).size.height * 0.05,
    title: Text(title),
    titleTextStyle: TextStyle(
      fontSize: 30.sp,
      color: AppColors.kWhiteColor,
      fontWeight: FontWeight.bold,
    ),
    leading:
        canPop
            ? IconButton(
              onPressed: () {
                context.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColors.kWhiteColor,
            )
            : Container(),
  );
}
