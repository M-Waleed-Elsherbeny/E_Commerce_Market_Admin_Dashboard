import 'dart:developer';

import 'package:admin_dashboard/core/data/shared_pref.dart';
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
}
