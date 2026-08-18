import 'package:dio/dio.dart';
import 'package:flutter_e_commerce_c11_online/core/network/api_keys.dart';
import 'package:flutter_e_commerce_c11_online/core/network/interceptor.dart';
import 'package:injectable/injectable.dart';

@singleton
class StripeApiManager {

  late Dio dio;

  StripeApiManager(){

    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.stripe.com/v1",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Authorization":
          "Bearer ${ApiKeys.secertKey}",
        },
      ),
    );

    dio.interceptors.add(AppInterceptor());

  }

 Future<Response> postData(
  String endPoint, {
  required Map<String, dynamic> body,
  Map<String, dynamic>? headers,
}) {
  return dio.post(
    endPoint,
    data: body,
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: headers,
      validateStatus: (status) => true,
    ),
  );
}

}