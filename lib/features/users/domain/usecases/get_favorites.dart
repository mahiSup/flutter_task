import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/github_user.dart';
import '../repositories/users_repository.dart';

class GetFavorites {
  final UsersRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<GithubUser>>> call() {
    return repository.getFavorites();
  }
}