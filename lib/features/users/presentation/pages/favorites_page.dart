import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/core/constants/constants.dart';
import 'package:go_router/go_router.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';

import '../widgets/app_confirmation_dialog.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/user_tile.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() =>
      _FavoritesPageState();
}

class _FavoritesPageState
    extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<FavoritesBloc>()
        .add(const LoadFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.favoriteUsers),
      ),
      body: BlocBuilder<
          FavoritesBloc,
          FavoritesState>(
        builder: (_, state) {
          if (state is FavoritesLoading) {
            return const LoadingWidget();
          }

          if (state is FavoritesError) {
            return AppErrorWidget(
              message: state.message,
            );
          }

          if (state is FavoritesEmpty) {
            return const EmptyWidget(
              message: Constants.noFavoriteYet,
            );
          }

          if (state is FavoritesLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (_, index) {
                final user =
                state.users[index];

                return UserTile(
                  user: user,
                  isFavorite: true,
                  onTap: () {
                    context.push(
                      '/details',
                      extra: user.login,
                    );
                  },
                  onFavoriteTap: () async {
                    final shouldRemove =
                    await AppConfirmationDialog.show(
                      context: context,
                      title: Constants.removeFavorite,
                      message:
                      Constants.removeFavoriteMessage,
                      confirmText: Constants.remove,
                      cancelText: Constants.cancel,
                      isDestructive: true,
                    );

                    if (!shouldRemove) return;

                    context
                        .read<FavoritesBloc>().add(
                      RemoveFavoriteEvent(
                        user.id,
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}