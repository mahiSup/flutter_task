import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late FavoritesBloc bloc;

  late MockSaveFavorite saveFavorite;
  late MockRemoveFavorite removeFavorite;
  late MockGetFavorites getFavorites;
  late MockIsFavorite isFavorite;

  setUp(() {
    saveFavorite = MockSaveFavorite();
    removeFavorite = MockRemoveFavorite();
    getFavorites = MockGetFavorites();
    isFavorite = MockIsFavorite();

    bloc = FavoritesBloc(
      saveFavorite: saveFavorite,
      removeFavorite: removeFavorite,
      getFavorites: getFavorites,
      isFavorite: isFavorite,
    );
  });

  tearDown(() {
    bloc.close();
  });

  blocTest<FavoritesBloc, FavoritesState>(
    'load favorites success',
    build: () {
      when(
            () => getFavorites(),
      ).thenAnswer(
            (_) async => const Right(testUsers),
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        const LoadFavoritesEvent(),
      );
    },
    expect: () => [
      FavoritesLoading(),
      const FavoritesLoaded(
        testUsers,
      ),
    ],
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'already exists',
    build: () {
      when(
            () => isFavorite(1),
      ).thenAnswer(
            (_) async => true,
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        AddFavoriteEvent(
          testUser,
        ),
      );
    },
    expect: () => [
      const FavoriteAlreadyExists(
        'John is already in favorites',
      ),
    ],
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'add favorite success',
    build: () {
      when(
            () => isFavorite(1),
      ).thenAnswer(
            (_) async => false,
      );

      when(
            () => saveFavorite(
          testUser,
        ),
      ).thenAnswer(
            (_) async => const Right(null),
      );

      when(
            () => getFavorites(),
      ).thenAnswer(
            (_) async => const Right(testUsers),
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        AddFavoriteEvent(
          testUser,
        ),
      );
    },
    verify: (_) {
      verify(
            () => saveFavorite(
          testUser,
        ),
      ).called(1);
    },
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'remove favorite success',
    build: () {
      when(
            () => removeFavorite(1),
      ).thenAnswer(
            (_) async => const Right(null),
      );

      when(
            () => getFavorites(),
      ).thenAnswer(
            (_) async => const Right([]),
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        const RemoveFavoriteEvent(
          1,
        ),
      );
    },
    verify: (_) {
      verify(
            () => removeFavorite(1),
      ).called(1);
    },
  );
}