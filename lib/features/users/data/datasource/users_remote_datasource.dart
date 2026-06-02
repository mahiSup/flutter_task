import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';

import '../models/github_user_model.dart';
import '../models/user_detail_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<GithubUserModel>> getUsers();

  Future<UserDetailModel> getUserDetails(
      String username,
      );

  Future<List<GithubUserModel>>
  searchUsers(String query);
}

class UsersRemoteDataSourceImpl
    implements UsersRemoteDataSource {
  final Dio dio;

  UsersRemoteDataSourceImpl(
      this.dio,
      );

  @override
  Future<List<GithubUserModel>> getUsers() async {
    try {
      final response = await dio.get(
        ApiEndpoints.users,
      );

      return (response.data as List)
          .map(
            (e) => GithubUserModel.fromJson(e),
      )
          .toList();
    } catch (e) {
      throw ServerException(
        'Failed to fetch users',
      );
    }
  }

  @override
  Future<UserDetailModel> getUserDetails(
      String username,
      ) async {
    try {
      final response = await dio.get(
        ApiEndpoints.userDetails(
          username,
        ),
      );

      return UserDetailModel.fromJson(
        response.data,
      );
    } catch (e) {
      throw ServerException(
        'Failed to fetch details',
      );
    }
  }

  @override
  Future<List<GithubUserModel>>
  searchUsers(String query) async {

    final response = await dio.get(
      ApiEndpoints.searchUsers(query),
    );

    return (response.data['items'] as List)
        .map(
          (e) => GithubUserModel.fromJson(e),
    )
        .toList();
  }
}