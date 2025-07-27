import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/functions/email_validator.dart';
import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/core/widgets/custom_search_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(500.r),
                    bottomRight: Radius.circular(500.r),
                  ),
                  boxShadow: [
                    const BoxShadow(
                      color: AppColors.kYellowColor,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Login to Admin Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            HeightSpacer(height: 150.h),
            SizedBox(
              width: 600.w,
              height: 400.h,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomTextField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!checkEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          // Add more validation if needed
                          return null;
                        },
                        labelText: "Email",
                        prefixIcon: const Icon(
                          Icons.email_rounded,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      HeightSpacer(height: 20.h),
                      CustomTextField(
                        controller: passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          // Add more validation if needed
                          return null;
                        },
                        labelText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock_rounded,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      HeightSpacer(height: 50.h),
                      SizedBox(
                        width: 400.w,
                        height: 70.h,
                        child: CustomButton(
                          textButton: "Login",
                          onPressed: () {
                            context.pushReplacementNamed(AppRoutes.homeScreen);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
