import '../repositories/users_repository.dart';

class IsFavorite {
  final UsersRepository repository;

  IsFavorite(
      this.repository,
      );

  Future<bool> call(
      int userId,
      ) {
    return repository.isFavorite(
      userId,
    );
  }
}