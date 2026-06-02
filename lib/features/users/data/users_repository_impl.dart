import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../domain/entities/github_user.dart';
import '../domain/entities/user_detail.dart';
import '../domain/repositories/users_repository.dart';
import 'datasource/users_local_datasource.dart';
import 'datasource/users_remote_datasource.dart';
import 'models/github_user_model.dart';



class UsersRepositoryImpl
    implements UsersRepository {
  final UsersRemoteDataSource
  remoteDataSource;

  final UsersLocalDataSource
  localDataSource;

  final NetworkInfo networkInfo;

  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure,
      List<GithubUser>>> getUsers() async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(
            'No Internet Connection',
          ),
        );
      }

      final users =
      await remoteDataSource.getUsers();

      return Right(users);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<Either<Failure, UserDetail>>
  getUserDetails(
      String username,
      ) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(
            'No Internet Connection',
          ),
        );
      }

      final details =
      await remoteDataSource
          .getUserDetails(
        username,
      );

      return Right(details);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>>
  saveFavorite(
      GithubUser user,
      ) async {
    try {
      await localDataSource.saveFavorite(
        GithubUserModel.fromEntity(
          user,
        ),
      );

      return const Right(null);
    } catch (e) {
      return const Left(
        CacheFailure(
          'Failed to save favorite',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>>
  removeFavorite(
      int userId,
      ) async {
    try {
      await localDataSource.removeFavorite(
        userId,
      );

      return const Right(null);
    } catch (e) {
      return const Left(
        CacheFailure(
          'Failed to remove favorite',
        ),
      );
    }
  }

  @override
  Future<Either<Failure,
      List<GithubUser>>> getFavorites() async {
    try {
      final favorites =
      await localDataSource
          .getFavorites();

      return Right(favorites);
    } catch (e) {
      return const Left(
        CacheFailure(
          'Failed to load favorites',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GithubUser>>> searchUsers(
      String query,
      ) async {
    try {
      if (query.trim().isEmpty) {
        return const Right([]);
      }

      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(
            'No Internet Connection',
          ),
        );
      }

      final users =
      await remoteDataSource.searchUsers(
        query.trim(),
      );

      return Right(users);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<bool> isFavorite(
      int userId,
      ) async {
    return localDataSource.isFavorite(
      userId,
    );
  }
}