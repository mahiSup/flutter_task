import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:github_user_explorer/core/constants/constants.dart';
import 'package:github_user_explorer/core/errors/failures.dart';
import 'package:github_user_explorer/features/users/data/models/github_user_model.dart';
import 'package:github_user_explorer/features/users/data/users_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

class FakeGithubUserModel extends Fake
    implements GithubUserModel {}

void main() {
  late UsersRepositoryImpl repository;

  late MockUsersRemoteDataSource remoteDataSource;
  late MockUsersLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;

  setUpAll(() {
    registerFallbackValue(
      FakeGithubUserModel(),
    );
  });

  setUp(() {
    remoteDataSource =
        MockUsersRemoteDataSource();

    localDataSource =
        MockUsersLocalDataSource();

    networkInfo =
        MockNetworkInfo();

    repository =
        UsersRepositoryImpl(
          remoteDataSource:
          remoteDataSource,
          localDataSource:
          localDataSource,
          networkInfo:
          networkInfo,
        );
  });

  group(
    'getUsers',
        () {
      test(
        'returns users when online',
            () async {
          when(
                () => networkInfo.isConnected,
          ).thenAnswer(
                (_) async => true,
          );

          when(
                () => remoteDataSource.getUsers(),
          ).thenAnswer(
                (_) async => testUserModels,
          );

          final result =
          await repository.getUsers();

          expect(
            result,
            Right(testUserModels),
          );

          verify(
                () => remoteDataSource.getUsers(),
          ).called(1);
        },
      );
    },
  );

  group(
    'searchUsers',
        () {
      test(
        'returns searched users',
            () async {
          when(
                () => networkInfo.isConnected,
          ).thenAnswer(
                (_) async => true,
          );

          when(
                () => remoteDataSource.searchUsers(
              'john',
            ),
          ).thenAnswer(
                (_) async => testUserModels,
          );

          final result =
          await repository.searchUsers(
            'john',
          );

          expect(
            result,
            Right(testUserModels),
          );

          verify(
                () => remoteDataSource.searchUsers(
              'john',
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'getUserDetails',
        () {
      test(
        'returns user details',
            () async {
          when(
                () => networkInfo.isConnected,
          ).thenAnswer(
                (_) async => true,
          );

          when(
                () => remoteDataSource.getUserDetails(
              'john',
            ),
          ).thenAnswer(
                (_) async => testUserDetailModel,
          );

          final result =
          await repository.getUserDetails(
            'john',
          );

          expect(
            result,
            Right(
              testUserDetailModel,
            ),
          );
        },
      );
    },
  );

  group(
    'saveFavorite',
        () {
      test(
        'saves favorite user',
            () async {
          when(
                () => localDataSource
                .saveFavorite(
              any(),
            ),
          ).thenAnswer(
                (_) async {},
          );

          final result =
          await repository
              .saveFavorite(
            testUser,
          );

          expect(
            result,
            const Right(null),
          );

          verify(
                () => localDataSource
                .saveFavorite(
              any(),
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'removeFavorite',
        () {
      test(
        'removes favorite',
            () async {
          when(
                () => localDataSource
                .removeFavorite(
              1,
            ),
          ).thenAnswer(
                (_) async {},
          );

          final result =
          await repository
              .removeFavorite(
            1,
          );

          expect(
            result,
            const Right(null),
          );

          verify(
                () => localDataSource
                .removeFavorite(
              1,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'getFavorites',
        () {
      test(
        'returns favorite users',
            () async {
          when(
                () => localDataSource.getFavorites(),
          ).thenAnswer(
                (_) async => testUserModels,
          );

          final result =
          await repository.getFavorites();

          expect(
            result,
            Right(testUserModels),
          );

          verify(
                () => localDataSource.getFavorites(),
          ).called(1);
        },
      );
    },
  );

  group(
    'isFavorite',
        () {
      test(
        'returns true',
            () async {
          when(
                () => localDataSource
                .isFavorite(
              1,
            ),
          ).thenAnswer(
                (_) async => true,
          );

          final result =
          await repository
              .isFavorite(
            1,
          );

          expect(
            result,
            true,
          );

          verify(
                () => localDataSource
                .isFavorite(
              1,
            ),
          ).called(1);
        },
      );
    },
  );
}