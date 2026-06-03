import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

import 'package:github_user_explorer/features/users/domain/usecases/is_favorite.dart';

void main() {
  late MockUsersRepository repository;
  late IsFavorite usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = IsFavorite(repository);
  });

  test(
    'should return true when favorite exists',
        () async {
      when(
            () => repository.isFavorite(
          1,
        ),
      ).thenAnswer(
            (_) async => true,
      );

      final result =
      await usecase(1);

      expect(
        result,
        true,
      );

      verify(
            () => repository.isFavorite(
          1,
        ),
      ).called(1);
    },
  );
}