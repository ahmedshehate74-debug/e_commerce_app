import 'package:dio/dio.dart';
import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token =
        SharedPreferenceUtils.getData(key: "token")?.toString();

    if (token != null) {
      options.headers["token"] = token;
    }

    // لو الـ Request رايح لـ Stripe
    if (!options.uri.host.contains("stripe.com")) {
   
    }

    print("==========================");
    print("PATH = ${options.path}");
    print("METHOD = ${options.method}");
    print("HEADERS = ${options.headers}");
    print("BODY = ${options.data}");
    print("==========================");

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print("✅ RESPONSE: ${response.data}");
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    print("❌ ERROR: ${err.response?.data}");
    handler.next(err);
  }
}