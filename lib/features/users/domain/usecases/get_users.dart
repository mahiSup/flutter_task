import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/github_user.dart';
import '../repositories/users_repository.dart';

class GetUsers {
  final UsersRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<GithubUser>>> call() {
    return repository.getUsers();
  }
}