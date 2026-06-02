import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/github_user.dart';
import '../repositories/users_repository.dart';

class SaveFavorite {
  final UsersRepository repository;

  SaveFavorite(this.repository);

  Future<Either<Failure, void>> call(
      GithubUser user,
      ) {
    return repository.saveFavorite(user);
  }
}