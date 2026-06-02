import 'package:hive/hive.dart';

import '../models/github_user_model.dart';

abstract class UsersLocalDataSource {
  Future<void> saveFavorite(
      GithubUserModel user,
      );

  Future<void> removeFavorite(
      int userId,
      );

  Future<List<GithubUserModel>>
  getFavorites();
}

class UsersLocalDataSourceImpl
    implements UsersLocalDataSource {
  static const String boxName =
      'favorites';

  @override
  Future<void> saveFavorite(
      GithubUserModel user,
      ) async {
    final box =
    await Hive.openBox(boxName);

    await box.put(
      user.id,
      user.toJson(),
    );
  }

  @override
  Future<void> removeFavorite(
      int userId,
      ) async {
    final box =
    await Hive.openBox(boxName);

    await box.delete(userId);
  }

  @override
  Future<List<GithubUserModel>>
  getFavorites() async {
    final box =
    await Hive.openBox(boxName);

    return box.values
        .map(
          (e) => GithubUserModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }
}