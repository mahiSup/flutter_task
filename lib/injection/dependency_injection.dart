import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_user_explorer/core/constants/constants.dart';

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

import '../features/users/presentation/bloc/users/users_bloc.dart';
import '../features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import '../features/users/presentation/bloc/favorites/favorites_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton(
        () => Dio(
      BaseOptions(
        baseUrl:
        Constants.baseURL,
      ),
    ),
  );

  sl.registerLazySingleton(
    Connectivity.new,
  );

  sl.registerLazySingleton<
      NetworkInfo>(
        () => NetworkInfoImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<
      UsersRemoteDataSource>(
        () =>
        UsersRemoteDataSourceImpl(
          sl(),
        ),
  );

  sl.registerLazySingleton<
      UsersLocalDataSource>(
        () =>
        UsersLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<
      UsersRepository>(
        () => UsersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => GetUsers(sl()),
  );

  sl.registerLazySingleton(
        () => GetUserDetails(sl()),
  );

  sl.registerLazySingleton(
        () => SaveFavorite(sl()),
  );

  sl.registerLazySingleton(
        () => RemoveFavorite(sl()),
  );

  sl.registerLazySingleton(
        () => GetFavorites(sl()),
  );

  sl.registerFactory(
        () => UsersBloc(
      getUsers: sl(),
    ),
  );

  sl.registerFactory(
        () => UserDetailBloc(
      getUserDetails: sl(),
    ),
  );

  sl.registerFactory(
        () => FavoritesBloc(
      saveFavorite: sl(),
      removeFavorite: sl(),
      getFavorites: sl(),
    ),
  );
}