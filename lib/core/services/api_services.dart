import 'package:admin_dashboard/core/database/supabase_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: BASE_URL, headers: {"apikey": API_KEY}),
  );

  Future<Response> getData(String endPoint, String token) async {
    try {
      final response = await _dio.get(
        endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postData(
    String endPoint,
    Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    String token,
  ) async {
    try {
      final response = await _dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,

        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putData(
    String endPoint,
    Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    String token,
  ) async {
    try {
      final response = await _dio.patch(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteData(String endPoint, String token) async {
    try {
      final response = await _dio.delete(endPoint, options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  final Dio _dioAuth = Dio(
    BaseOptions(baseUrl: BASE_AUTH_URL, headers: {"apikey": API_KEY}),
  );
  Future<Response> createAdminAccount(
    String endPoint,
    Map<String, dynamic> data,
  ) async {
    final response = await _dioAuth.post(endPoint, data: data);
    return response;
  }

  Future<Response> loginAdminAccount(
    String endPoint,
    Map<String, dynamic> data,
  ) async {
    Response response = await _dioAuth.post(
      endPoint,
      data: data,
      queryParameters: {"grant_type": "password"},
    );
    return response;
  }

  final Dio _dioStorage = Dio();
  Future<Response> uploadImage({
    required String bucketName,
    required Uint8List image,
    required String imageName,
    required String token,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(image, filename: imageName),
      });
      final response = await _dioStorage.post(
        "$BASE_STORAGE_URL/$bucketName/$imageName",
        data: formData,
        options: Options(
          headers: {
            "apikey": API_KEY,
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
