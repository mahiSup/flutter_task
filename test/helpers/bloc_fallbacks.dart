import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_state.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_state.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_state.dart';
import 'package:mocktail/mocktail.dart';


class FakeUsersEvent extends Fake
    implements UsersEvent {}

class FakeUsersState extends Fake
    implements UsersState {}

class FakeFavoritesEvent extends Fake
    implements FavoritesEvent {}

class FakeFavoritesState extends Fake
    implements FavoritesState {}

class FakeUserDetailEvent extends Fake
    implements UserDetailEvent {}

class FakeUserDetailState extends Fake
    implements UserDetailState {}

void registerBlocFallbacks() {
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

  registerFallbackValue(
    FakeUserDetailEvent(),
  );

  registerFallbackValue(
    FakeUserDetailState(),
  );
}