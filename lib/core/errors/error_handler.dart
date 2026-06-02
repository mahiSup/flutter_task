import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return const NetworkFailure(
            Constants.connectionTimeout,
          );

        case DioExceptionType.receiveTimeout:
          return const NetworkFailure(
            Constants.receiveTimeout,
          );

        case DioExceptionType.connectionError:
          return const NetworkFailure(
              Constants.noInternetConnection
          );

        case DioExceptionType.badResponse:
          return ServerFailure(
            error.response?.data['message'] ??
                Constants.serverError,
          );

        default:
          return const ServerFailure(
            Constants.unexpectedError,
          );
      }
    }

    return const ServerFailure(
      Constants.somethingWentWrong,
    );
  }
}