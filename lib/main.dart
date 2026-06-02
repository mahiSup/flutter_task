import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/utils/app_bloc_observer.dart';
import 'routes/app_router.dart';
import 'injection/dependency_injection.dart';

import 'features/users/presentation/bloc/users/users_bloc.dart';
import 'features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'features/users/presentation/bloc/favorites/favorites_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized();

  await Hive.initFlutter();

  await initDependencies();

  Bloc.observer =
      AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              sl<UsersBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              sl<UserDetailBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              sl<FavoritesBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title:
        'GitHub User Explorer',
        debugShowCheckedModeBanner:
        false,

        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed:
          Colors.blue,
        ),

        routerConfig:
        AppRouter.router,
      ),
    );
  }
}