import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/entities/user_detail.dart';

import 'package:github_user_explorer/features/users/data/models/github_user_model.dart';
import 'package:github_user_explorer/features/users/data/models/user_detail_model.dart';

const testUser = GithubUser(
  id: 1,
  login: 'john',
  avatarUrl: 'https://avatar.com/john.png',
  htmlUrl: 'https://github.com/john',
);

const testUsers = [
  testUser,
];

const testUserModel = GithubUserModel(
  id: 1,
  login: 'john',
  avatarUrl: 'https://avatar.com/john.png',
  htmlUrl: 'https://github.com/john',
);

const testUserModels = [
  testUserModel,
];

const testUserDetail = UserDetail(
  login: 'john',
  avatarUrl: 'https://avatar.com/john.png',
  bio: 'Flutter Developer',
  followers: 100,
  following: 50,
  publicRepos: 25, id: 1, htmlUrl: '',
);

const testUserDetailModel =
UserDetailModel(
  login: 'john',
  avatarUrl: 'https://avatar.com/john.png',
  bio: 'Flutter Developer',
  followers: 100,
  following: 50,
  publicRepos: 25, id: 1, htmlUrl: '',
);