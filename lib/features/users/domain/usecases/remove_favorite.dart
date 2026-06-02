import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/users_repository.dart';

class RemoveFavorite {
  final UsersRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, void>> call(
      int userId,
      ) {
    return repository.removeFavorite(
      userId,
    );
  }
}