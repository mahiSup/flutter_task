import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class GitHubInterceptor extends Interceptor {
  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    final remaining =
    response.headers.value(
      'x-ratelimit-remaining',
    );

    debugPrint(
      'GitHub Remaining Requests: $remaining',
    );

    super.onResponse(
      response,
      handler,
    );
  }
}