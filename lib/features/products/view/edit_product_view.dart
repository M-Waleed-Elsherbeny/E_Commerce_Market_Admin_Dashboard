import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_catch_image.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Edit Product Name"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300.w,
                height: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.kPrimaryColor, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: const CustomCachedImage(
                    url:
                        "https://images.unsplash.com/photo-1546868871-7041f2a55e12?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  ),
                ),
              ),
              HeightSpacer(height: 20),
              SizedBox(
                width: 300.w,
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: CustomButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.add_a_photo,
                          color: AppColors.kScaffoldColor,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    Flexible(
                      child: CustomButton(
                        onPressed: () {
                          // Handle file upload
                        },
                        child: Icon(
                          Icons.file_upload_outlined,
                          color: AppColors.kScaffoldColor,
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              HeightSpacer(height: 20),
              DropdownMenu(
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(
                    value: "Category",
                    label: "Category",
                  ),
                  DropdownMenuEntry<String>(value: "Shoes", label: "Shoes"),
                  DropdownMenuEntry<String>(value: "Clothes", label: "Clothes"),
                ],
                menuStyle: MenuStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: AppColors.kPrimaryColor, width: 2),
                  ),
                ),
                initialSelection: "Category",
                enableSearch: true,
              ),
            ],
          ),
          HeightSpacer(height: 50),
          CustomTextField(labelText: "Product Name"),
          HeightSpacer(height: 20),
          CustomTextField(labelText: "Old Price"),
          HeightSpacer(height: 20),
          CustomTextField(labelText: "New Price"),
          HeightSpacer(height: 20),
          CustomTextField(labelText: "Product Description", maxLines: 5),
          HeightSpacer(height: 20),
          Center(
            child: SizedBox(
              width: 300.w,
              height: 60.h,
              child: CustomButton(
                onPressed: () {
                  // Handle save action
                },
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    color: AppColors.kScaffoldColor,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
