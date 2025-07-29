import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/core/widgets/custom_catch_image.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: SizedBox(
        height: 250.h,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250.w,
                height: 250.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: const CustomCachedImage(
                    url:
                        "https://images.unsplash.com/photo-1546868871-7041f2a55e12?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  ),
                ),
              ),
              // const WidthSpacer(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Product Name",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Product Description",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Product Price",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Product Sale",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      child: Icon(
                        Icons.edit,
                        size: 30.sp,
                        color: AppColors.kWhiteColor,
                      ),
                      onPressed: () {
                        context.pushNamed(AppRoutes.editProductsView);
                      },
                    ),
                    CustomButton(
                      child: Icon(
                        Icons.comment,
                        size: 30.sp,
                        color: AppColors.kWhiteColor,
                      ),
                      onPressed: () {
                        context.pushNamed(AppRoutes.commentsView);
                      },
                    ),
                    CustomButton(
                      onPressed: () {},
                      backgroundColor: AppColors.kRedColor,
                      child: Icon(
                        Icons.delete,
                        size: 30.sp,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
