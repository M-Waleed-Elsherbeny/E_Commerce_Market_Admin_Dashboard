import 'dart:developer';

import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/data/shared_pref.dart';
import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_catch_image.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/core/widgets/width_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:admin_dashboard/features/products/models/home_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.productsModel});
  final HomeProductsModel productsModel;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  List<DropdownMenuEntry<String>> dropdownMenuEntries = [
    const DropdownMenuEntry<String>(
      value: "Select Category",
      label: "Select Category",
    ),
    const DropdownMenuEntry<String>(value: "mobiles", label: "Mobiles"),
    const DropdownMenuEntry<String>(value: "electronics", label: "Electronics"),
    const DropdownMenuEntry<String>(value: "sports", label: "Sports"),
    const DropdownMenuEntry<String>(value: "collections", label: "Collections"),
    const DropdownMenuEntry<String>(value: "books", label: "Books"),
    const DropdownMenuEntry<String>(value: "games", label: "Games"),
  ];
  String? selectedCategory;
  String? sale = "10";
  late TextEditingController saleController,
      productNameController,
      oldPriceController,
      newPriceController,
      descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    saleController = TextEditingController(
      text: widget.productsModel.productSale,
    );
    productNameController = TextEditingController(
      text: widget.productsModel.productName,
    );
    oldPriceController = TextEditingController(
      text: widget.productsModel.productOldPrice,
    );
    newPriceController = TextEditingController(
      text: widget.productsModel.productNewPrice,
    );
    descriptionController = TextEditingController(
      text: widget.productsModel.productDescription,
    );
    selectedCategory = widget.productsModel.productCategory;
    super.initState();
  }

  @override
  void dispose() {
    saleController.dispose();
    productNameController.dispose();
    oldPriceController.dispose();
    newPriceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        context,
        "${widget.productsModel.productName}",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      "${widget.productsModel.productSale} % OFF",
                      style: TextStyle(
                        color: AppColors.kScaffoldColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const WidthSpacer(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 300.w,
                        height: 300.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: CustomCachedImage(
                          url: widget.productsModel.productImage!,
                          width: 300.w,
                          height: 300.w,
                        ),
                      ),
                      const HeightSpacer(height: 20),
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
                      const HeightSpacer(height: 20),
                      DropdownMenu(
                        dropdownMenuEntries: dropdownMenuEntries,
                        menuStyle: MenuStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          side: const WidgetStatePropertyAll(
                            BorderSide(
                              color: AppColors.kPrimaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        initialSelection: selectedCategory,
                        onSelected: (String? value) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const HeightSpacer(height: 50),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter product name";
                  }
                  return null;
                },
                controller: productNameController,
                labelText: "Product Name",
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter product name";
                  } else if (num.tryParse(value) == null) {
                    return "Please enter a valid number";
                  } else if (num.tryParse(value) != null &&
                      num.parse(value) <= 0) {
                    return "Price must be greater than zero";
                  }
                  return null;
                },
                controller: oldPriceController,
                labelText: "Old Price",
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter product name";
                  } else if (num.tryParse(value) == null) {
                    return "Please enter a valid number";
                  } else if (num.tryParse(value) != null &&
                      num.parse(value) <= 0) {
                    return "Price must be greater than zero";
                  }
                  return null;
                },
                controller: newPriceController,
                labelText: "New Price",
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter product description";
                  }
                  return null;
                },
                controller: descriptionController,
                labelText: "Product Description",
                maxLines: 5,
              ),
              const HeightSpacer(height: 20),
              Center(
                child: SizedBox(
                  width: 300.w,
                  height: 60.h,
                  child: CustomButton(
                    onPressed: () async {
                      String? token = await SharedPref.getToken();
                      log("Token: $token");
                      // if (_formKey.currentState!.validate()) {
                      //   customSnackBar(
                      //     context,
                      //     "Product details updated successfully!",
                      //     backgroundColor: AppColors.kPrimaryColor,
                      //   );
                      // }
                    },
                    child: Text(
                      "Edit Product",
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
        ),
      ),
    );
  }
}
