/// Centralised route paths and names.
///
/// Referencing these constants (instead of raw strings) avoids typos and makes
/// renames safe. `name` values are used for `context.goNamed(...)`.
class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String users = '/users';

  // Named routes
  static const String splashName = 'splash';
  static const String loginName = 'login';
  static const String usersName = 'users';
}
