import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late UserDetailBloc bloc;
  late MockGetUserDetails getUserDetails;

  setUp(() {
    getUserDetails =
        MockGetUserDetails();

    bloc = UserDetailBloc(
      getUserDetails:
      getUserDetails,
    );
  });

  tearDown(() {
    bloc.close();
  });

  blocTest<
      UserDetailBloc,
      UserDetailState>(
    'load detail success',
    build: () {
      when(
            () => getUserDetails(
          'john',
        ),
      ).thenAnswer(
            (_) async => const Right(
          testUserDetail,
        ),
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        const LoadUserDetailEvent(
          'john',
        ),
      );
    },
    expect: () => [
      UserDetailLoading(),
      const UserDetailLoaded(
        testUserDetail,
      ),
    ],
  );
}