import 'package:dio/dio.dart';
class RetryInterceptor extends Interceptor {
  RetryInterceptor(
      this.dio, {
        this.maxRetries = 3,
      });

  final Dio dio;
  final int maxRetries;

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    final retryCount =
        err.requestOptions.extra['retryCount'] ?? 0;

    if (retryCount >= maxRetries) {
      return handler.next(err);
    }

    err.requestOptions.extra['retryCount'] =
        retryCount + 1;

    try {
      await Future.delayed(
        Duration(
          seconds: retryCount + 1,
        ),
      );

      final response = await dio.fetch(
        err.requestOptions,
      );

      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }

  bool _shouldRetry(
      DioException error,
      ) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return true;

      case DioExceptionType.badResponse:
        final statusCode =
            error.response?.statusCode ?? 0;

        return statusCode == 500 ||
            statusCode == 502 ||
            statusCode == 503 ||
            statusCode == 504;

      default:
        return false;
    }
  }
}