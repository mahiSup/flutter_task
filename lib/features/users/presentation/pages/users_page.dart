import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/core/utils/extensions.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../bloc/favorites/favorites_state.dart';
import '../bloc/users/users_bloc.dart';
import '../bloc/users/users_event.dart';
import '../bloc/users/users_state.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';

import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/user_tile.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshUsers() async {
    _searchController.clear();

    context
        .read<UsersBloc>().add(
      const LoadUsersEvent(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search GitHub Users',
          prefixIcon: const Icon(Icons.search),

          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();

              context.read<UsersBloc>().add(
                const LoadUsersEvent(),
              );

              setState(() {});
            },
          )
              : null,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) {
          setState(() {});

          context.read<UsersBloc>().add(
            SearchUsersEvent(value.trim()),
          );
        },
      ),
    );
  }

  Widget _buildUsersList(
      UsersLoaded state,
      ) {
    return RefreshIndicator(
      onRefresh: _refreshUsers,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.users.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return _buildSearchBar();
          }

          final user = state.users[index - 1];

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
              context.read<FavoritesBloc>().add(
                AddFavoriteEvent(user),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInitialView() {
    return Column(
      children: [
        _buildSearchBar(),
        const Expanded(
          child: LoadingWidget(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
        FavoritesBloc,
        FavoritesState>(
        listener: (
        context,
        state,
    ) {
      if (state
      is FavoriteAdded) {
        AppSnackBar.success(
          context,
          state.message,
        );
      }

      if (state
      is FavoriteAlreadyExists) {
        AppSnackBar.warning(
          context,
          state.message,
        );
      }

      if (state
      is FavoritesError) {
        AppSnackBar.error(
          context,
          state.message,
        );
      }
    },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Constants.githubUsers,
          ),
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (_, state) {
            if (state is UsersInitial) {
              return _buildInitialView();
            }
      
            if (state is UsersLoading) {
              return Column(
                children: [
                  _buildSearchBar(),
                  const Expanded(
                    child: LoadingWidget(),
                  ),
                ],
              );
            }
      
            if (state is UsersError) {
              return Column(
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: AppErrorWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<UsersBloc>().add(
                          const LoadUsersEvent(),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
      
            if (state is UsersEmpty) {
              return Column(
                children: [
                  _buildSearchBar(),
                  const Expanded(
                    child: EmptyWidget(
                      message: 'No Users Found',
                    ),
                  ),
                ],
              );
            }
      
            if (state is UsersLoaded) {
              return _buildUsersList(state);
            }
      
            return const SizedBox();
          },
        ),
      ),
    );
  }
}