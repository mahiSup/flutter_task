import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

import 'package:github_user_explorer/features/users/domain/usecases/save_favorite.dart';

void main() {
  late MockUsersRepository repository;
  late SaveFavorite usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = SaveFavorite(repository);
  });

  test(
    'should save favorite user',
        () async {
      when(
            () => repository.saveFavorite(
          testUser,
        ),
      ).thenAnswer(
            (_) async => const Right(null),
      );

      final result =
      await usecase(testUser);

      expect(
        result,
        const Right(null),
      );

      verify(
            () => repository.saveFavorite(
          testUser,
        ),
      ).called(1);
    },
  );
}