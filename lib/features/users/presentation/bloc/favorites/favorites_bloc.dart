import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_favorites.dart';
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

  FavoritesBloc({
    required this.saveFavorite,
    required this.removeFavorite,
    required this.getFavorites,
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
    await saveFavorite(event.user);

    add(
      const LoadFavoritesEvent(),
    );
  }

  Future<void> _removeFavorite(
      RemoveFavoriteEvent event,
      Emitter<FavoritesState> emit,
      ) async {
    await removeFavorite(
      event.userId,
    );

    add(
      const LoadFavoritesEvent(),
    );
  }
}