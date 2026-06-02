import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/github_user.dart';

class UserTile extends StatelessWidget {
  final GithubUser user;
  final bool isFavorite;

  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const UserTile({
    super.key,
    required this.user,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 25,
          backgroundImage:
          CachedNetworkImageProvider(
            user.avatarUrl,
          ),
        ),
        title: Text(user.login),
        subtitle: Text(
          user.htmlUrl,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: onFavoriteTap,
          icon: Icon(
            isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}