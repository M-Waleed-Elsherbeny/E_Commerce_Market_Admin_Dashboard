import 'package:admin_dashboard/core/database/supabase_config.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: BASE_URL, headers: {"apikey": API_KEY}),
  );

  Future<Response> getData(String endPoint) async {
    try {
      final response = await _dio.get(endPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postData(String endPoint, Map<String, dynamic> data, Map<String, dynamic>? queryParameters,
  ) async {
    try {
      final response = await _dio.post(endPoint, data: data,queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putData(String endPoint, Map<String, dynamic> data, Map<String, dynamic>? queryParameters,
  ) async {
    try {
      final response = await _dio.patch(endPoint, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteData(String endPoint) async {
    try {
      final response = await _dio.delete(endPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
