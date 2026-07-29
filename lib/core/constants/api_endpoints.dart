/// Centralised list of REST API paths.
///
/// Only relative paths live here; the base URL is supplied per flavor through
/// [AppConfig]. Group endpoints by feature so they stay easy to find.
class ApiEndpoints {
  const ApiEndpoints._();

  // ---- Auth ----------------------------------------------------------------
  static const String login = '/login';
  static const String register = '/register';

  // ---- Users ---------------------------------------------------------------
  static const String users = '/users';

  /// Builds the path for a single user resource.
  static String user(String id) => '/users/$id';
}
