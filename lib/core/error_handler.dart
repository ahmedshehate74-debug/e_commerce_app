import 'package:dio/dio.dart';

import '../domain/failures.dart';

Failures handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return TimeoutError(
        errorMessage: 'Connection Timeout',
      );

    case DioExceptionType.receiveTimeout:
      return TimeoutError(
        errorMessage: 'Receive Timeout',
      );

    case DioExceptionType.sendTimeout:
      return TimeoutError(
        errorMessage: 'Send Timeout',
      );

    default:
      return ServerError(
        errorMessage: 'Server Error',
      );
  }
}