import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/core/utils/extensions.dart';
import '../../../domain/usecases/get_favorites.dart';
import '../../../domain/usecases/is_favorite.dart';
import '../../../domain/usecases/remove_favorite.dart';
import '../../../domain/usecases/save_favorite.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc
    extends Bloc<FavoritesEvent,
        FavoritesState> {
  final SaveFavorite saveFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorites getFavorites;
  final IsFavorite isFavorite;

  FavoritesBloc({
    required this.saveFavorite,
    required this.removeFavorite,
    required this.getFavorites,
    required this.isFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(
      _loadFavorites,
    );

    on<AddFavoriteEvent>(
      _addFavorite,
    );

    on<RemoveFavoriteEvent>(
      _removeFavorite,
    );
  }

  Future<void> _loadFavorites(
      LoadFavoritesEvent event,
      Emitter<FavoritesState> emit,
      ) async {
    emit(FavoritesLoading());

    final result =
    await getFavorites();

    result.fold(
          (failure) => emit(
        FavoritesError(
          failure.message,
        ),
      ),
          (users) {
        if (users.isEmpty) {
          emit(FavoritesEmpty());
        } else {
          emit(
            FavoritesLoaded(users),
          );
        }
      },
    );
  }

  Future<void> _addFavorite(
      AddFavoriteEvent event,
      Emitter<FavoritesState> emit,
      ) async {
    final exists =
    await isFavorite(
      event.user.id,
    );

    if (exists) {
      emit(
        FavoriteAlreadyExists(
          '${event.user.login.capitalizeWords()} is already in favorites',
        ),
      );

      return;
    }

    final result =
    await saveFavorite(
      event.user,
    );

    result.fold(
          (failure) {
        emit(
          FavoritesError(
            failure.message,
          ),
        );
      },
          (_) {
        emit(
          FavoriteAdded(
            '${event.user.login.capitalizeWords()} added to favorites',
          ),
        );

        add(
          const LoadFavoritesEvent(),
        );
      },
    );
  }

  Future<void> _removeFavorite(
      RemoveFavoriteEvent event,
      Emitter<FavoritesState> emit,
      ) async {
    final result =
    await removeFavorite(
      event.userId,
    );

    result.fold(
          (failure) {
        emit(
          FavoritesError(
            failure.message,
          ),
        );
      },
          (_) {
        emit(
          const FavoriteRemoved(
            'Favorite removed successfully',
          ),
        );

        add(
          const LoadFavoritesEvent(),
        );
      },
    );
  }
}