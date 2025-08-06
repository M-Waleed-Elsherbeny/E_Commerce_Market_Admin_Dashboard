import 'dart:developer';
import 'dart:typed_data';
import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/functions/custom_snack_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_catch_image.dart';
import 'package:admin_dashboard/core/widgets/custom_loading.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/core/widgets/width_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:admin_dashboard/features/products/cubit/products_cubit.dart';
import 'package:admin_dashboard/features/products/functions/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddProduct extends StatefulWidget {
  const CustomAddProduct({super.key});

  @override
  State<CustomAddProduct> createState() => _CustomAddProductState();
}

class _CustomAddProductState extends State<CustomAddProduct> {
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
  String? selectedCategory, sale, selectedImage, imageName;
  Uint8List? image;

  late TextEditingController productNameController,
      oldPriceController,
      newPriceController,
      descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    productNameController = TextEditingController();
    oldPriceController = TextEditingController();
    newPriceController = TextEditingController();
    descriptionController = TextEditingController();
    selectedCategory = dropdownMenuEntries.first.label;
    sale = "0";
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    oldPriceController.dispose();
    newPriceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is AddNewProductError) {
          customSnackBar(context, state.errorMessage);
        }
        if (state is UploadImageError) {
          customSnackBar(context, state.errorMessage);
        }
        if (state is UploadImageSuccess) {
          customSnackBar(context, "Image Uploaded Successfully...");
        }
        if (state is AddNewProductSuccess) {
          customSnackBar(context, "Product Added Successfully...");
        }
      },
      builder: (context, state) {
        ProductsCubit cubit = context.read<ProductsCubit>();
        return state is AddNewProductLoading
            ? const CustomLoading()
            : SingleChildScrollView(
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
                            "$sale % OFF",
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
                                border: Border.all(
                                  color: AppColors.kPrimaryColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CustomCachedImage(
                                  url:
                                      selectedImage ??
                                      "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png",
                                ),
                              ),
                            ),
                            const HeightSpacer(height: 20),
                            SizedBox(
                              width: 300.w,
                              height: 100.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: CustomButton(
                                      onPressed: () async {
                                        await pickImage().then((value) {
                                          if (value != null) {
                                            selectedImage =
                                                value.files.first.path;
                                            imageName = value.files.first.name;
                                            image = value.files.first.bytes;
                                            setState(() {});
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: AppColors.kScaffoldColor,
                                        size: 30.sp,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: CustomButton(
                                      onPressed: () async {
                                        if (selectedImage != null) {
                                          await cubit.uploadImageToSupabase(
                                            bucketName: "images",
                                            image: image!,
                                            imageName: imageName!,
                                          );
                                          log(cubit.imageUrl);
                                        }
                                      },
                                      child:
                                          state is UploadImageLoading
                                              ? const CustomLoading(
                                                color: AppColors.kWhiteColor,
                                                width: 20,
                                                height: 20,
                                              )
                                              : Icon(
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
                          return "Please enter product price";
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                        ),
                      ],
                    ),
                    const HeightSpacer(height: 20),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter product price";
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                        ),
                      ],
                      onChanged: (value) {
                        // Discount Percentage = (old_price - new_price) / old_price * 100;
                        double discountPercentage =
                            (double.parse(oldPriceController.text) -
                                double.parse(value)) /
                            double.parse(oldPriceController.text) *
                            100;
                        sale = discountPercentage.round().toString();
                        setState(() {});
                      },
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
                            if (_formKey.currentState!.validate()) {
                              if (cubit.imageUrl.isNotEmpty) {
                                log(cubit.imageUrl);
                                await cubit.addNewProduct(
                                  data: {
                                    "product_name": productNameController.text,
                                    "product_description":
                                        descriptionController.text,
                                    "product_old_price":
                                        oldPriceController.text,
                                    "product_sale": sale,
                                    "product_new_price":
                                        newPriceController.text,
                                    "product_image": cubit.imageUrl,
                                    "product_category": selectedCategory,
                                  },
                                );
                              } else {
                                customSnackBar(context, "Please Upload Image");
                              }
                            }
                          },
                          child: Text(
                            "Add Product",
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
            );
      },
    );
  }
}
