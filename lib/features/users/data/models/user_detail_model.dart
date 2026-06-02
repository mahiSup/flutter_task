import '../../domain/entities/user_detail.dart';

class UserDetailModel extends UserDetail {
  const UserDetailModel({
    required super.id,
    required super.login,
    required super.avatarUrl,
    super.bio,
    required super.followers,
    required super.following,
    required super.publicRepos,
    required super.htmlUrl,
  });

  factory UserDetailModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return UserDetailModel(
      id: json['id'],
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      bio: json['bio'],
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      publicRepos: json['public_repos'] ?? 0,
      htmlUrl: json['html_url'] ?? '',
    );
  }
}