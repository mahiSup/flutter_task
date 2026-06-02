import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_user_explorer/core/constants/constants.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/constants/constants.dart';
import '../core/network/dio_client.dart';
import '../core/network/network_info.dart';

import '../features/users/data/datasource/users_local_datasource.dart';
import '../features/users/data/datasource/users_remote_datasource.dart';


import '../features/users/data/users_repository_impl.dart';
import '../features/users/domain/repositories/users_repository.dart';

import '../features/users/domain/usecases/get_users.dart';
import '../features/users/domain/usecases/get_user_details.dart';
import '../features/users/domain/usecases/get_favorites.dart';
import '../features/users/domain/usecases/save_favorite.dart';
import '../features/users/domain/usecases/remove_favorite.dart';
import '../features/users/domain/usecases/search_users.dart';

import '../features/users/presentation/bloc/users/users_bloc.dart';
import '../features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import '../features/users/presentation/bloc/favorites/favorites_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  /// Dio Client
  sl.registerLazySingleton<DioClient>(
        () => DioClient(),
  );

  /// Dio Instance
  sl.registerLazySingleton<Dio>(
        () => sl<DioClient>().dio,
  );

  /// Connectivity
  sl.registerLazySingleton<Connectivity>(
    Connectivity.new,
  );

  /// NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(
      sl<Connectivity>(),
    ),
  );

  /// Data Sources
  sl.registerLazySingleton<UsersRemoteDataSource>(
        () => UsersRemoteDataSourceImpl(
      sl<Dio>(),
    ),
  );

  sl.registerLazySingleton<UsersLocalDataSource>(
        () => UsersLocalDataSourceImpl(),
  );

  /// Repository
  sl.registerLazySingleton<UsersRepository>(
        () => UsersRepositoryImpl(
      remoteDataSource: sl<UsersRemoteDataSource>(),
      localDataSource: sl<UsersLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  /// Use Cases
  sl.registerLazySingleton<GetUsers>(
        () => GetUsers(
      sl<UsersRepository>(),
    ),
  );

  sl.registerLazySingleton<GetUserDetails>(
        () => GetUserDetails(
      sl<UsersRepository>(),
    ),
  );

  sl.registerLazySingleton<SearchUsers>(
        () => SearchUsers(
      sl<UsersRepository>(),
    ),
  );

  sl.registerLazySingleton<SaveFavorite>(
        () => SaveFavorite(
      sl<UsersRepository>(),
    ),
  );

  sl.registerLazySingleton<RemoveFavorite>(
        () => RemoveFavorite(
      sl<UsersRepository>(),
    ),
  );

  sl.registerLazySingleton<GetFavorites>(
        () => GetFavorites(
      sl<UsersRepository>(),
    ),
  );

  /// BLoCs
  sl.registerFactory<UsersBloc>(
        () => UsersBloc(
      getUsers: sl<GetUsers>(),
      searchUsers: sl<SearchUsers>(),
    ),
  );

  sl.registerFactory<UserDetailBloc>(
        () => UserDetailBloc(
      getUserDetails: sl<GetUserDetails>(),
    ),
  );

  sl.registerFactory<FavoritesBloc>(
        () => FavoritesBloc(
      saveFavorite: sl<SaveFavorite>(),
      removeFavorite: sl<RemoveFavorite>(),
      getFavorites: sl<GetFavorites>(),
    ),
  );
}