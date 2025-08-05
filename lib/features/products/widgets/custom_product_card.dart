import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:admin_dashboard/core/functions/custom_snack_bar.dart';
import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/core/widgets/custom_catch_image.dart';
import 'package:admin_dashboard/core/widgets/custom_loading.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:admin_dashboard/features/products/cubit/cubit/products_cubit.dart';
import 'package:admin_dashboard/features/products/models/home_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomProductView extends StatelessWidget {
  const CustomProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is GetProductsError) {
          customSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        ProductsCubit productsCubit = context.read<ProductsCubit>();
        return state is GetProductsLoading
            ? const CustomLoading()
            : ListView.builder(
              itemCount: productsCubit.allProducts.length,
              itemBuilder: (context, index) {
                return state is GetProductsLoading
                    ? const CustomLoading()
                    : CustomProductCard(
                      productsModel: productsCubit.allProducts[index],
                    );
              },
            );
      },
    );
  }
}

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.productsModel});
  final HomeProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: SizedBox(
        height: 250.h,
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250.w,
                  height: 250.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CustomCachedImage(
                      url:
                          productsModel.productImage ??
                          "https://img.freepik.com/free-psd/iphone-15-mockup-perspective_1332-60616.jpg?t=st=1751960051~exp=1751963651~hmac=0d01365c290e0e1b178fe8e473abaa71e382c263ea9561f9c3dcb15f808cf1c2&w=900",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        productsModel.productName ?? "Product Name",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        productsModel.productDescription ??
                            "Product Description",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${productsModel.productNewPrice} LE",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${productsModel.productSale} %",
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
                          context.pushNamed(
                            AppRoutes.editProductsView,
                            extra: productsModel,
                          );
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
      ),
    );
  }
}
