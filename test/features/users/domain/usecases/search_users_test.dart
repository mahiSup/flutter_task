import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';
import '../../../../helpers/test_data.dart';

import 'package:github_user_explorer/features/users/domain/usecases/search_users.dart';

void main() {
  late MockUsersRepository repository;
  late SearchUsers usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = SearchUsers(repository);
  });

  test(
    'should search users',
        () async {
      when(
            () => repository.searchUsers(
          'john',
        ),
      ).thenAnswer(
            (_) async => const Right(testUsers),
      );

      final result =
      await usecase('john');

      expect(
        result,
        const Right(testUsers),
      );

      verify(
            () => repository.searchUsers(
          'john',
        ),
      ).called(1);
    },
  );
}