import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_state.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/loading_widget.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/pages/details_page.dart';

import '../../../../helpers/test_data.dart';



class MockUserDetailBloc
    extends MockBloc<
        UserDetailEvent,
        UserDetailState>
    implements UserDetailBloc {}

void main() {
  late MockUserDetailBloc bloc;

  setUp(() {
    bloc = MockUserDetailBloc();

    when(() => bloc.stream).thenAnswer(
          (_) => const Stream.empty(),
    );
  });

  Widget createWidget() {
    return MaterialApp(
      home: BlocProvider<UserDetailBloc>.value(
        value: bloc,
        child: const DetailsPage(
          username: 'john',
        ),
      ),
    );
  }

  group('DetailsPage', () {
    testWidgets(
      'shows loading state',
          (tester) async {
        when(() => bloc.state)
            .thenReturn(
          UserDetailLoading(),
        );

        await tester.pumpWidget(
          createWidget(),
        );

        expect(
          find.byType(LoadingWidget),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows error state',
          (tester) async {
        when(() => bloc.state)
            .thenReturn(
          const UserDetailError(
            'Error',
          ),
        );

        await tester.pumpWidget(
          createWidget(),
        );

        expect(
          find.text('Error'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows user detail data',
          (tester) async {
        when(() => bloc.state)
            .thenReturn(
          const UserDetailLoaded(
            testUserDetail,
          ),
        );

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            createWidget(),
          );

          await tester.pumpAndSettle();
        });

        expect(
          find.text('John'),
            findsNWidgets(2),
        );

        expect(
          find.text(
            'Flutter Developer',
          ),
          findsOneWidget,
        );

        expect(
          find.text('Followers'),
          findsOneWidget,
        );

        expect(
          find.text('Following'),
          findsOneWidget,
        );

        expect(
          find.text('Repositories'),
          findsOneWidget,
        );
      },
    );
  });
}