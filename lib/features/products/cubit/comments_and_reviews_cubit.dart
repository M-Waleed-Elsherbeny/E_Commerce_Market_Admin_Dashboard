import 'dart:developer';

import 'package:admin_dashboard/core/data/shared_pref.dart';
import 'package:admin_dashboard/core/services/api_services.dart';
import 'package:admin_dashboard/features/products/models/home_products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comments_and_reviews_state.dart';

class CommentsAndReviewsCubit extends Cubit<CommentsAndReviewsState> {
  CommentsAndReviewsCubit() : super(CommentsAndReviewsInitial());
  ApiServices apiServices = ApiServices();
  List<UsersComments> userComments = [];

  Future<void> getComments({required String productId}) async {
    emit(GetCommentsLoading());
    try {
      String? token = await SharedPref.getToken();
      if (token != null) {
        Response response = await apiServices.getData(
          "comments_table?product_id=eq.$productId",
          token,
        );
        if (response.statusCode == 200) {
          for (var comments in response.data) {
            userComments.add(usersCommentsModelFromJson(comments));
          }
          // log(userComments.first.userName.toString());
          emit(GetCommentsSuccess());
        } else {
          emit(GetCommentsError(response.data));
        }
      } else {
        emit(GetCommentsError("You Must Login To See Comments..."));
      }
    } catch (e) {
      log("Error in getComments : $e");
      emit(GetCommentsError(e.toString()));
    }
  }
}
