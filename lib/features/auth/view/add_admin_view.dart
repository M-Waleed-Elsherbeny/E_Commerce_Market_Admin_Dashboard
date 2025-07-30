import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/functions/custom_snack_bar.dart';
import 'package:admin_dashboard/core/functions/email_validator.dart';
import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddAdminView extends StatefulWidget {
  const AddAdminView({super.key});

  @override
  State<AddAdminView> createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Add New Admin"),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 600.w,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomTextField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Name';
                              }
                              return null;
                            },
                            labelText: "Admin Name",
                            prefixIcon: const Icon(
                              Icons.admin_panel_settings_rounded,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                          HeightSpacer(height: 20.h),
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
                              textButton: "Create Admin",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  customSnackBar(
                                    context,
                                    "Admin Created Successfully",
                                  );
                                  context.go(AppRoutes.homeScreen);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
