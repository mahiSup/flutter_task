import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_explorer/core/constants/constants.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_state.dart';
import 'package:github_user_explorer/features/users/presentation/pages/favorites_page.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/empty_widget.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/loading_widget.dart';
import 'package:github_user_explorer/features/users/presentation/widgets/user_tile.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late MockFavoritesBloc bloc;

  setUp(() {
    bloc = MockFavoritesBloc();

    when(() => bloc.state)
        .thenReturn(
      FavoritesInitial(),
    );

    whenListen(
      bloc,
      const Stream<FavoritesState>.empty(),
      initialState: FavoritesInitial(),
    );
  });

  Widget createWidget() {
    return MaterialApp(
      home: BlocProvider<FavoritesBloc>.value(
        value: bloc,
        child: const FavoritesPage(),
      ),
    );
  }

  testWidgets(
    'shows loading state',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(
        FavoritesLoading(),
      );

      await tester.pumpWidget(
        createWidget(),
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
    'shows favorite users',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(
        const FavoritesLoaded(
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
    },
  );

  testWidgets(
    'shows empty widget',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(
        FavoritesEmpty(),
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
          Constants.noFavoriteYet,
        ),
        findsOneWidget,
      );
    },
  );
}