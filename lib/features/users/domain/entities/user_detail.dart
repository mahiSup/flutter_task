import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String? bio;
  final int followers;
  final int following;
  final int publicRepos;
  final String htmlUrl;

  const UserDetail({
    required this.id,
    required this.login,
    required this.avatarUrl,
    this.bio,
    required this.followers,
    required this.following,
    required this.publicRepos,
    required this.htmlUrl,
  });

  @override
  List<Object?> get props => [
    id,
    login,
    avatarUrl,
    bio,
    followers,
    following,
    publicRepos,
    htmlUrl,
  ];
}