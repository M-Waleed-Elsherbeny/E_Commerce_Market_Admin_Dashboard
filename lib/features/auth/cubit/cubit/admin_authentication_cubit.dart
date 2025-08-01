import 'dart:developer';

import 'package:admin_dashboard/core/data/shared_pref.dart';
import 'package:admin_dashboard/core/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_authentication_state.dart';

class AdminAuthenticationCubit extends Cubit<AdminAuthenticationState> {
  AdminAuthenticationCubit() : super(AdminAuthenticationInitial());
  ApiServices apiServices = ApiServices();

  Future<void> createAdminAccount({
    required String email,
    required String password,
  }) async {
    try {
      emit(AddAdminLoading());
      Response response = await apiServices.createAdminAccount("signup", {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        emit(AddAdminSuccess());
      } else {
        emit(AddAdminError(response.data["msg"]));
      }
    } catch (e) {
      log("Error in createAdminAccount: $e");
      emit(AddAdminError(e.toString()));
    }
  }

  Future<void> loginAdmin({
    required String email,
    required String password,
  }) async {
    emit(LoginAdminLoading());
    try {
      Response response = await apiServices.loginAdminAccount("token", {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        // log(response.data['access_token']);
        await SharedPref.saveToken(response.data['access_token']);
        emit(LoginAdminSuccess());
      } else {
        emit(LoginAdminError(response.data["msg"]));
      }
    } catch (e) {
      log("Error in loginAdmin : $e");
      emit(LoginAdminError(e.toString()));
    }
  }
}
