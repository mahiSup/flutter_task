import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

import 'package:github_user_explorer/features/users/domain/usecases/get_favorites.dart';

void main() {
  late MockUsersRepository repository;
  late GetFavorites usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = GetFavorites(repository);
  });

  test(
    'should return favorite users',
        () async {
      when(
            () => repository.getFavorites(),
      ).thenAnswer(
            (_) async => const Right(testUsers),
      );

      final result =
      await usecase();

      expect(
        result,
        const Right(testUsers),
      );

      verify(
            () => repository.getFavorites(),
      ).called(1);
    },
  );
}