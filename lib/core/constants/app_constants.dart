/// Application-wide constant values that never change at runtime.
///
/// Keep only truly global, environment-independent values here. Anything that
/// changes per build flavor (e.g. base URLs) belongs in [AppConfig].
class AppConstants {
  const AppConstants._();

  /// Human readable application name.
  static const String appName = 'Flutter Base Project';

  /// Default number of items requested per page for paginated endpoints.
  static const int defaultPageSize = 10;

  /// Default network timeout used by the HTTP client.
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Standard animation duration used across the UI.
  static const Duration animationDuration = Duration(milliseconds: 300);
}
