import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_state.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_state.dart';
import 'package:github_user_explorer/features/users/presentation/pages/users_page.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/empty_widget.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/loading_widget.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/user_tile.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockUsersBloc
    extends MockBloc<UsersEvent, UsersState>
    implements UsersBloc {}

class MockFavoritesBloc
    extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

class FakeUsersEvent extends Fake
    implements UsersEvent {}

class FakeUsersState extends Fake
    implements UsersState {}

class FakeFavoritesEvent extends Fake
    implements FavoritesEvent {}

class FakeFavoritesState extends Fake
    implements FavoritesState {}

const testUsers = [
  GithubUser(
    id: 1,
    login: 'john',
    avatarUrl: 'https://avatar.com/john.png',
    htmlUrl: 'https://github.com/john',
  ),
];

void main() {
  late MockUsersBloc usersBloc;
  late MockFavoritesBloc favoritesBloc;

  setUpAll(() {
    registerFallbackValue(
      FakeUsersEvent(),
    );

    registerFallbackValue(
      FakeUsersState(),
    );

    registerFallbackValue(
      FakeFavoritesEvent(),
    );

    registerFallbackValue(
      FakeFavoritesState(),
    );
  });

  setUp(() {
    usersBloc = MockUsersBloc();
    favoritesBloc = MockFavoritesBloc();

    when(
          () => usersBloc.state,
    ).thenReturn(
      UsersInitial(),
    );

    when(
          () => favoritesBloc.state,
    ).thenReturn(
      FavoritesInitial(),
    );

    whenListen(
      usersBloc,
      const Stream<UsersState>.empty(),
      initialState: UsersInitial(),
    );

    whenListen(
      favoritesBloc,
      const Stream<FavoritesState>.empty(),
      initialState: FavoritesInitial(),
    );
  });

  Widget createWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UsersBloc>.value(
            value: usersBloc,
          ),
          BlocProvider<FavoritesBloc>.value(
            value: favoritesBloc,
          ),
        ],
        child: const UsersPage(),
      ),
    );
  }

  group(
    'UsersPage Widget Tests',
        () {
      testWidgets(
        'shows loading widget',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            UsersLoading(),
          );

          await mockNetworkImagesFor(
                () async {
              await tester.pumpWidget(
                createWidget(),
              );
            },
          );

          expect(
            find.byType(
              LoadingWidget,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'shows users list',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            const UsersLoaded(
              testUsers,
            ),
          );

          await mockNetworkImagesFor(
                () async {
              await tester.pumpWidget(
                createWidget(),
              );
            },
          );

          expect(
            find.byType(
              UserTile,
            ),
            findsNWidgets(
              testUsers.length,
            ),
          );

          expect(
            find.byType(
              TextField,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'shows empty state',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            UsersEmpty(),
          );

          await tester.pumpWidget(
            createWidget(),
          );

          expect(
            find.byType(
              EmptyWidget,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'No Users Found',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'shows error state',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            const UsersError(
              'Something went wrong',
            ),
          );

          await tester.pumpWidget(
            createWidget(),
          );

          expect(
            find.text(
              'Something went wrong',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'shows search field',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            const UsersLoaded(
              testUsers,
            ),
          );

          await mockNetworkImagesFor(
                () async {
              await tester.pumpWidget(
                createWidget(),
              );
            },
          );

          expect(
            find.byType(
              TextField,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'shows initial state',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            UsersInitial(),
          );

          await tester.pumpWidget(
            createWidget(),
          );

          expect(
            find.byType(
              TextField,
            ),
            findsOneWidget,
          );

          expect(
            find.byType(
              LoadingWidget,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'typing in search dispatches SearchUsersEvent',
            (tester) async {
          when(
                () => usersBloc.state,
          ).thenReturn(
            const UsersLoaded(
              testUsers,
            ),
          );

          await mockNetworkImagesFor(
                () async {
              await tester.pumpWidget(
                createWidget(),
              );
            },
          );

          await tester.enterText(
            find.byType(
              TextField,
            ),
            'john',
          );

          await tester.pump();

          verify(
                () => usersBloc.add(
              const SearchUsersEvent(
                'john',
              ),
            ),
          ).called(1);
        },
      );
    },
  );
}