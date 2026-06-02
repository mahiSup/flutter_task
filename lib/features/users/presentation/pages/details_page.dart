import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/core/utils/extensions.dart';

import '../bloc/user_detail/user_detail_bloc.dart';
import '../bloc/user_detail/user_detail_event.dart';
import '../bloc/user_detail/user_detail_state.dart';

import '../widgets/full_screen_image_viewer.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class DetailsPage extends StatefulWidget {
  final String username;

  const DetailsPage({
    super.key,
    required this.username,
  });

  @override
  State<DetailsPage> createState() =>
      _DetailsPageState();
}

class _DetailsPageState
    extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<UserDetailBloc>()
        .add(
      LoadUserDetailEvent(
        widget.username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username.capitalizeWords()),
      ),
      body: BlocBuilder<
          UserDetailBloc,
          UserDetailState>(
        builder: (_, state) {
          if (state is UserDetailLoading) {
            return const LoadingWidget();
          }

          if (state is UserDetailError) {
            return AppErrorWidget(
              message: state.message,
            );
          }

          if (state is UserDetailLoaded) {
            final user = state.user;

            return SingleChildScrollView(
              padding:
              const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showProfileImage(
                        context,
                        user.avatarUrl,
                        user.login.capitalizeWords(),
                      );
                    },
                    child: Hero(
                      tag: user.avatarUrl,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                        CachedNetworkImageProvider(
                          user.avatarUrl,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    user.login.capitalizeWords(),
                    style:
                    const TextStyle(
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    user.bio ??
                        'No bio available',
                    textAlign:
                    TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceEvenly,
                    children: [
                      _infoCard(
                        'Followers',
                        user.followers
                            .toString(),
                      ),
                      _infoCard(
                        'Following',
                        user.following
                            .toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _infoCard(
                    'Repositories',
                    user.publicRepos
                        .toString(),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _infoCard(
      String title,
      String value,
      ) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title),
            const SizedBox(height: 8),
            Text(
              value,
              style:
              const TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileImage(
      BuildContext context,
      String imageUrl,
      String username,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImagePage(
          imageUrl: imageUrl,
          username: username,
        ),
      ),
    );
  }
}