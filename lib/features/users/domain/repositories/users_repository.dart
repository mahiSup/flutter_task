import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/github_user.dart';
import '../entities/user_detail.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<GithubUser>>> getUsers();

  Future<Either<Failure, UserDetail>> getUserDetails(
      String username,
      );

  Future<Either<Failure, void>> saveFavorite(
      GithubUser user,
      );

  Future<Either<Failure, void>> removeFavorite(
      int userId,
      );

  Future<Either<Failure, List<GithubUser>>>
  getFavorites();
}