import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/favorites/favorites_state.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/user_detail/user_detail_state.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_bloc.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_event.dart';
import 'package:github_user_explorer/features/users/presentation/bloc/users/users_state.dart';
import 'package:mocktail/mocktail.dart';

import 'package:github_user_explorer/core/network/network_info.dart';

import 'package:github_user_explorer/features/users/data/datasource/users_local_datasource.dart';
import 'package:github_user_explorer/features/users/data/datasource/users_remote_datasource.dart';

import 'package:github_user_explorer/features/users/domain/repositories/users_repository.dart';

import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';
import 'package:github_user_explorer/features/users/domain/usecases/search_users.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_user_details.dart';
import 'package:github_user_explorer/features/users/domain/usecases/save_favorite.dart';
import 'package:github_user_explorer/features/users/domain/usecases/remove_favorite.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_favorites.dart';
import 'package:github_user_explorer/features/users/domain/usecases/is_favorite.dart';

class MockUsersRepository extends Mock
    implements UsersRepository {}

class MockUsersRemoteDataSource extends Mock
    implements UsersRemoteDataSource {}

class MockUsersLocalDataSource extends Mock
    implements UsersLocalDataSource {}

class MockNetworkInfo extends Mock
    implements NetworkInfo {}

class MockConnectivity extends Mock
    implements Connectivity {}

class MockDio extends Mock
    implements Dio {}

class MockGetUsers extends Mock
    implements GetUsers {}

class MockSearchUsers extends Mock
    implements SearchUsers {}

class MockGetUserDetails extends Mock
    implements GetUserDetails {}

class MockSaveFavorite extends Mock
    implements SaveFavorite {}

class MockRemoveFavorite extends Mock
    implements RemoveFavorite {}

class MockGetFavorites extends Mock
    implements GetFavorites {}

class MockIsFavorite extends Mock
    implements IsFavorite {}


class MockUsersBloc
    extends MockBloc<
        UsersEvent,
        UsersState>
    implements UsersBloc {}

class MockFavoritesBloc
    extends MockBloc<
        FavoritesEvent,
        FavoritesState>
    implements FavoritesBloc {}

class MockUserDetailBloc
    extends MockBloc<
        UserDetailEvent,
        UserDetailState>
    implements UserDetailBloc {}