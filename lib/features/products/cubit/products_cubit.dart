import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_dashboard/core/data/shared_pref.dart';
import 'package:admin_dashboard/core/database/supabase_config.dart';
import 'package:admin_dashboard/core/services/api_services.dart';
import 'package:admin_dashboard/features/products/models/home_products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  ApiServices apiServices = ApiServices();
  List<HomeProductsModel> allProducts = [];
  Future<void> getAllProducts() async {
    emit(GetProductsLoading());
    try {
      String? token = await SharedPref.getToken();

      if (token != null) {
        Response response = await apiServices.getData("products_table", token);

        if (response.statusCode == 200) {
          log("200");
          for (var product in response.data) {
            allProducts.add(homeProductsModelFromJson(product));
          }
          emit(GetProductsSuccess());
        } else {
          emit(GetProductsError("Something went wrong"));
        }
      } else {
        emit(GetProductsError("You Must Login To See Products"));
      }
    } catch (e) {
      log("Error in getAllProducts: $e");

      emit(GetProductsError(e.toString()));
    }
  }

  Future<void> editProduct({
    required String? productId,
    required Map<String, dynamic> data,
  }) async {
    emit(EditProductsLoading());
    try {
      String? token = await SharedPref.getToken();
      if (token != null) {
        Response response = await apiServices.putData("products_table", data, {
          "product_id": "eq.$productId",
        }, token);
        if (response.statusCode == 204) {
          emit(EditProductsSuccess());
        } else {
          emit(EditProductsError(response.data['message']));
        }
      } else {
        emit(EditProductsError("You Must Login Again..."));
      }
    } catch (e) {
      log("Error in editProduct : $e");
      emit(EditProductsError(e.toString()));
    }
  }

  /// Delete Product By ID
  Future<void> deleteProduct({required String productId}) async {
    emit(DeleteProductsLoading());
    try {
      String? token = await SharedPref.getToken();
      if (token != null) {
        await apiServices.deleteData(
          "comments_table?product_id=eq.$productId",
          token,
        );
        await apiServices.deleteData(
          "favorite_products_table?product_id=eq.$productId",
          token,
        );
        await apiServices.deleteData(
          "rates_table?product_id=eq.$productId",
          token,
        );
        await apiServices.deleteData(
          "sold_products?product_id=eq.$productId",
          token,
        );
        await apiServices.deleteData(
          "products_table?product_id=eq.$productId",
          token,
        );

        emit(DeleteProductsSuccess());
      } else {
        emit(DeleteProductsError("You Must Login Again..."));
      }
    } catch (e) {
      log("Error in deleteProduct: $e");
      emit(DeleteProductsError(e.toString()));
    }
  }

  List<HomeProductsModel> products = [];
  Future<void> addNewProduct({required Map<String, dynamic> data}) async {
    emit(AddNewProductLoading());
    try {
      String? token = await SharedPref.getToken();
      if (token != null) {
        Response response = await apiServices.postData(
          "products_table",
          data,
          {},
          token,
        );
        log("Add Data Response ====> ${response.statusCode}");
        if (response.statusCode == 201) {
          emit(AddNewProductSuccess());
        }
      } else {
        emit(AddNewProductError("You Must Login Again..."));
      }
    } catch (e) {
      log(e.toString());
      emit(AddNewProductError(e.toString()));
    }
  }

  String imageUrl = "";
  Future<void> uploadImageToSupabase({
    required String bucketName,
    required Uint8List image,
    required String imageName,
  }) async {
    emit(UploadImageLoading());
    String? token = await SharedPref.getToken();
    try {
      Response response = await apiServices.uploadImage(
        bucketName: bucketName,
        image: image,
        imageName: imageName,
        token: token!,
      );
      if (response.statusCode == 200) {
        imageUrl = "$BASE_STORAGE_URL/${response.data['Key']}";
        emit(UploadImageSuccess());
      } else {
        emit(UploadImageError("Failed to upload image"));
      }
    } catch (e) {
      log("Error in uploadImageToSupabase: $e");
      emit(UploadImageError(e.toString()));
    }
  }
}
