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
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddAdminSuccess());
      }
    } catch (e) {
      emit(AddAdminError(e.toString()));
    }
  }
}
