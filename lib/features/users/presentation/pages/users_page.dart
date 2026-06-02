import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../bloc/users/users_bloc.dart';
import '../bloc/users/users_event.dart';
import '../bloc/users/users_state.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';

import '../widgets/loading_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/user_tile.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() =>
      _UsersPageState();
}

class _UsersPageState
    extends State<UsersPage> {
  @override
  void initState() {
    super.initState();

    context.read<UsersBloc>().add(
      const LoadUsersEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.githubUsers,
        ),
      ),
      body: BlocBuilder<
          UsersBloc,
          UsersState>(
        builder: (_, state) {
          if (state is UsersLoading) {
            return const LoadingWidget();
          }

          if (state is UsersError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context
                    .read<UsersBloc>()
                    .add(
                  const LoadUsersEvent(),
                );
              },
            );
          }

          if (state is UsersEmpty) {
            return const EmptyWidget(
              message: 'No Users Found',
            );
          }

          if (state is UsersLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<UsersBloc>()
                    .add(
                  const RefreshUsersEvent(),
                );
              },
              child: ListView.builder(
                itemCount:
                state.users.length,
                itemBuilder: (_, index) {
                  final user =
                  state.users[index];

                  return UserTile(
                    user: user,
                    isFavorite: false,
                    onTap: () {
                      context.push(
                        '/details',
                        extra: user.login,
                      );
                    },
                    onFavoriteTap: () {
                      context
                          .read<
                          FavoritesBloc>()
                          .add(
                        AddFavoriteEvent(
                            user),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}