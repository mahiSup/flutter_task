import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_detail.dart';
import '../repositories/users_repository.dart';

class GetUserDetails {
  final UsersRepository repository;

  GetUserDetails(this.repository);

  Future<Either<Failure, UserDetail>> call(
      String username,
      ) {
    return repository.getUserDetails(
      username,
    );
  }
}