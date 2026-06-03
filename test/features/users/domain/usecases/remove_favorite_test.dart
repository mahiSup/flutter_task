import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

import 'package:github_user_explorer/features/users/domain/usecases/remove_favorite.dart';

void main() {
  late MockUsersRepository repository;
  late RemoveFavorite usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = RemoveFavorite(repository);
  });

  test(
    'should remove favorite user',
        () async {
      when(
            () => repository.removeFavorite(
          1,
        ),
      ).thenAnswer(
            (_) async => const Right(null),
      );

      final result =
      await usecase(1);

      expect(
        result,
        const Right(null),
      );

      verify(
            () => repository.removeFavorite(
          1,
        ),
      ).called(1);
    },
  );
}