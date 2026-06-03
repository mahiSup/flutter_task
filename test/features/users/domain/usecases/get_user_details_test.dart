import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

import 'package:github_user_explorer/features/users/domain/usecases/get_user_details.dart';

void main() {
  late MockUsersRepository repository;
  late GetUserDetails usecase;

  setUp(() {
    repository = MockUsersRepository();
    usecase = GetUserDetails(repository);
  });

  test(
    'should return user details',
        () async {
      when(
            () => repository.getUserDetails(
          'john',
        ),
      ).thenAnswer(
            (_) async =>
        const Right(testUserDetail),
      );

      final result =
      await usecase('john');

      expect(
        result,
        const Right(testUserDetail),
      );

      verify(
            () => repository.getUserDetails(
          'john',
        ),
      ).called(1);
    },
  );
}