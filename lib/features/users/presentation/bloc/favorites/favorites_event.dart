import 'package:equatable/equatable.dart';


import '../../../domain/entities/github_user.dart';

abstract class FavoritesEvent
    extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent
    extends FavoritesEvent {
  const LoadFavoritesEvent();
}

class AddFavoriteEvent
    extends FavoritesEvent {
  final GithubUser user;

  const AddFavoriteEvent(
      this.user,
      );

  @override
  List<Object?> get props => [user];
}

class RemoveFavoriteEvent
    extends FavoritesEvent {
  final int userId;

  const RemoveFavoriteEvent(
      this.userId,
      );

  @override
  List<Object?> get props => [userId];
}