class ApiEndpoints {
  ApiEndpoints._();

  static const String users = '/users';

  static String userDetails(String username) {
    return '/users/$username';
  }

  static String searchUsers(String query) {
    return '/search/users?q=$query';
  }
}