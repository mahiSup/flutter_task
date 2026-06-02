import 'package:dio/dio.dart';
import 'package:github_user_explorer/core/network/retry_interceptor.dart';

import '../constants/constants.dart';
import 'githu_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/vnd.github+json',
        },
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.addAll([
      RetryInterceptor(dio),
      GitHubInterceptor(),
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    ]);
  }
}