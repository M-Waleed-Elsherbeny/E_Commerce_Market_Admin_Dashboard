import 'dart:developer';
import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/functions/custom_snack_bar.dart';
import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/core/widgets/custom_catch_image.dart';
import 'package:admin_dashboard/core/widgets/custom_loading.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/core/widgets/width_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:admin_dashboard/features/products/cubit/products_cubit.dart';
import 'package:admin_dashboard/features/products/functions/pick_image.dart';
import 'package:admin_dashboard/features/products/models/home_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  String? selectedCategory, sale, selectedImage, imageName;
  Uint8List? image;

  late TextEditingController productNameController,
      oldPriceController,
      newPriceController,
      descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
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
    sale = widget.productsModel.productSale;
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
        if (state is EditProductsError) {
          customSnackBar(context, state.errorMessage);
        } else if (state is UploadImageError) {
          customSnackBar(context, state.errorMessage);
        } else if (state is GetProductsError) {
          customSnackBar(context, state.errorMessage);
        } else if (state is EditProductsSuccess) {
          customSnackBar(context, "Edit Product Successfully...");
          context.goNamed(AppRoutes.homeScreen);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();
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
                  buildCustomEditOrAddProductHeader(cubit, state),
                  const HeightSpacer(height: 50),
                  buildCustomEditOrAddProductTextField(),
                  const HeightSpacer(height: 20),
                  buildCustomEditOrAddProductButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (cubit.imageUrl.isNotEmpty) {
                          log(cubit.imageUrl);
                          await cubit.editProduct(
                            productId: widget.productsModel.productId,
                            data: {
                              "product_name": productNameController.text,
                              "product_description": descriptionController.text,
                              "product_old_price": oldPriceController.text,
                              "product_sale": sale,
                              "product_new_price": newPriceController.text,
                              "product_image": cubit.imageUrl,
                              "product_category": selectedCategory,
                            },
                          );
                        } else {
                          customSnackBar(context, "Please Upload Image");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Center buildCustomEditOrAddProductButton({required VoidCallback? onPressed}) {
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 60.h,
        child: CustomButton(
          onPressed: onPressed,
          child: Text(
            "Edit Product",
            style: TextStyle(color: AppColors.kScaffoldColor, fontSize: 25.sp),
          ),
        ),
      ),
    );
  }

  Column buildCustomEditOrAddProductTextField() {
    return Column(
      children: [
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
            } else if (num.tryParse(value) != null && num.parse(value) <= 0) {
              return "Price must be greater than zero";
            }
            return null;
          },
          controller: oldPriceController,
          labelText: "Old Price",
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
        ),
        const HeightSpacer(height: 20),
        CustomTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter product price";
            } else if (num.tryParse(value) == null) {
              return "Please enter a valid number";
            } else if (num.tryParse(value) != null && num.parse(value) <= 0) {
              return "Price must be greater than zero";
            }
            return null;
          },
          controller: newPriceController,
          labelText: "New Price",
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
          onChanged: (value) {
            // Discount Percentage = (old_price - new_price) / old_price * 100;
            double discountPercentage =
                (double.parse(oldPriceController.text) - double.parse(value)) /
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
      ],
    );
  }

  Row buildCustomEditOrAddProductHeader(
    ProductsCubit cubit,
    ProductsState state,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CustomCachedImage(
                url: selectedImage ?? widget.productsModel.productImage!,
                width: 250.w,
                height: 250.h,
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
                      onPressed: () async {
                        await pickImage().then((value) {
                          if (value != null) {
                            selectedImage = value.files.first.path;
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
                    side: const BorderSide(color: AppColors.kPrimaryColor),
                  ),
                ),
                side: const WidgetStatePropertyAll(
                  BorderSide(color: AppColors.kPrimaryColor, width: 2),
                ),
              ),
              initialSelection: selectedCategory,
              onSelected: (String? value) {
                selectedCategory = value;
                // setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}
