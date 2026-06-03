import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:github_user_explorer/features/users/presentation/bloc/users/users_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late MockGetUsers mockGetUsers;
  late MockSearchUsers mockSearchUsers;

  setUp(() {
    mockGetUsers = MockGetUsers();
    mockSearchUsers = MockSearchUsers();
  });

  group('LoadUsersEvent', () {
    blocTest<UsersBloc, UsersState>(
      'emits [Loading, Loaded] when users exist',
      build: () {
        when(
              () => mockGetUsers(),
        ).thenAnswer(
              (_) async => const Right(testUsers),
        );

        return UsersBloc(
          getUsers: mockGetUsers,
          searchUsers: mockSearchUsers,
        );
      },
      act: (bloc) =>
          bloc.add(
            const LoadUsersEvent(),
          ),
      expect: () => [
        UsersLoading(),
        const UsersLoaded(testUsers),
      ],
      verify: (_) {
        verify(
              () => mockGetUsers(),
        ).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'emits [Loading, Empty] when list is empty',
      build: () {
        when(
              () => mockGetUsers(),
        ).thenAnswer(
              (_) async => const Right([]),
        );

        return UsersBloc(
          getUsers: mockGetUsers,
          searchUsers: mockSearchUsers,
        );
      },
      act: (bloc) =>
          bloc.add(
            const LoadUsersEvent(),
          ),
      expect: () => [
        UsersLoading(),
        UsersEmpty(),
      ],
    );
  });

  group('SearchUsersEvent', () {
    blocTest<UsersBloc, UsersState>(
      'emits [Loading, Loaded] when search succeeds',
      build: () {
        when(
              () => mockSearchUsers('john'),
        ).thenAnswer(
              (_) async => const Right(testUsers),
        );

        return UsersBloc(
          getUsers: mockGetUsers,
          searchUsers: mockSearchUsers,
        );
      },
      act: (bloc) =>
          bloc.add(
            const SearchUsersEvent(
              'john',
            ),
          ),

      wait: const Duration(
        milliseconds: 600,
      ),

      expect: () => [
        UsersLoading(),
        const UsersLoaded(testUsers),
      ],

      verify: (_) {
        verify(
              () => mockSearchUsers(
            'john',
          ),
        ).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'empty query reloads users',
      build: () {
        when(
              () => mockGetUsers(),
        ).thenAnswer(
              (_) async => const Right(testUsers),
        );

        return UsersBloc(
          getUsers: mockGetUsers,
          searchUsers: mockSearchUsers,
        );
      },
      act: (bloc) =>
          bloc.add(
            const SearchUsersEvent(''),
          ),

      wait: const Duration(
        milliseconds: 600,
      ),

      expect: () => [
        UsersLoading(),
        const UsersLoaded(testUsers),
      ],
    );
  });

  group('RefreshUsersEvent', () {
    blocTest<UsersBloc, UsersState>(
      'refresh triggers reload',
      build: () {
        when(
              () => mockGetUsers(),
        ).thenAnswer(
              (_) async => const Right(testUsers),
        );

        return UsersBloc(
          getUsers: mockGetUsers,
          searchUsers: mockSearchUsers,
        );
      },
      act: (bloc) =>
          bloc.add(
            const RefreshUsersEvent(),
          ),
      expect: () => [
        UsersLoading(),
        const UsersLoaded(testUsers),
      ],
    );
  });
}