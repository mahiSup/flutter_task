import 'package:equatable/equatable.dart';

import '../../../domain/entities/github_user.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<GithubUser> users;

  const FavoritesLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteAdded extends FavoritesState {
  final String message;

  const FavoriteAdded(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteAlreadyExists extends FavoritesState {
  final String message;

  const FavoriteAlreadyExists(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteRemoved extends FavoritesState {
  final String message;

  const FavoriteRemoved(this.message);

  @override
  List<Object?> get props => [message];
}


// abstract class FavoritesState
//     extends Equatable {
//   const FavoritesState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class FavoritesInitial
//     extends FavoritesState {}
//
// class FavoritesLoading
//     extends FavoritesState {}
//
// class FavoritesLoaded
//     extends FavoritesState {
//   final List<GithubUser> users;
//
//   const FavoritesLoaded(
//       this.users,
//       );
//
//   @override
//   List<Object?> get props => [users];
// }
//
// class FavoritesEmpty
//     extends FavoritesState {}
//
// class FavoritesError
//     extends FavoritesState {
//   final String message;
//
//   const FavoritesError(
//       this.message,
//       );
//
//   @override
//   List<Object?> get props => [message];
// }