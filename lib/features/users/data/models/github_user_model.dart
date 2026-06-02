import '../../domain/entities/github_user.dart';

class GithubUserModel extends GithubUser {
  const GithubUserModel({
    required super.id,
    required super.login,
    required super.avatarUrl,
    required super.htmlUrl,
  });

  factory GithubUserModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return GithubUserModel(
      id: json['id'],
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }

  factory GithubUserModel.fromEntity(
      GithubUser user,
      ) {
    return GithubUserModel(
      id: user.id,
      login: user.login,
      avatarUrl: user.avatarUrl,
      htmlUrl: user.htmlUrl,
    );
  }
}