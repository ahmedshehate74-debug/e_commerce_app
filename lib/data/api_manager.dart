import 'package:dio/dio.dart';
import 'package:flutter_e_commerce_c11_online/core/network/interceptor.dart';
import 'package:flutter_e_commerce_c11_online/core/resources/constants_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(AppInterceptor());
  }

  Future<Response> postData(
    String endPoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: body,
      );

      print("========== ApiManager ==========");
      print("وصل الريسبونس");
      print(response.statusCode);
      print(response.data);
      print("===============================");

      return response;
    } catch (e) {
      print("========== ApiManager ERROR ==========");
      print(e.runtimeType);
      print(e);
      print("=====================================");

      rethrow;
    }
  }

  Future<Response> putData(
    String endPoint, {
    Map<String, dynamic>? body,
  }) {
    return dio.put(
      endPoint,
      data: body,
      options: Options(
        validateStatus: (status) => true,
      ),
    );
  }

  Future<Response> deleteData(String endPoint) {
    print("deleteData called with endpoint: $endPoint");

    return dio.delete(
      endPoint,
      options: Options(
        validateStatus: (status) => true,
      ),
    );
  }

  Future<Response> getData(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
      ),
    );

    print("GET => $endPoint");
    print(response.statusCode);
    print(response.data);

    return response;
  }
}
