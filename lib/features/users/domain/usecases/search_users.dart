import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/github_user.dart';
import '../repositories/users_repository.dart';

class SearchUsers {
  final UsersRepository repository;

  SearchUsers(this.repository);

  Future<Either<Failure,List<GithubUser>>> call(
      String query,
      ) {
    return repository.searchUsers(query);
  }
}