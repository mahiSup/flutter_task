import 'package:go_router/go_router.dart';

import '../features/users/presentation/pages/home_page.dart';
import '../features/users/presentation/pages/details_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) =>
        const HomePage(),
      ),
      GoRoute(
        path: '/details',
        builder: (_, state) {
          final username =
          state.extra as String;

          return DetailsPage(
            username: username,
          );
        },
      ),
    ],
  );
}