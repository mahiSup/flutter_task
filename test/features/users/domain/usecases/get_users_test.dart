import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';
import '../../../../helpers/test_data.dart';

import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';

void main() {
  late MockUsersRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = GetUsers(repository);
  });

  test(
    'should get users from repository',
        () async {
      when(
            () => repository.getUsers(),
      ).thenAnswer(
            (_) async => const Right(testUsers),
      );

      final result = await usecase();

      expect(
        result,
        const Right(testUsers),
      );

      verify(
            () => repository.getUsers(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}