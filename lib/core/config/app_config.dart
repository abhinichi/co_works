import 'package:flutter_base_project/core/constants/app_constants.dart';

/// Build flavors supported by the app.
enum Flavor { dev, staging, prod }

/// Strongly-typed, per-flavor runtime configuration.
///
/// Initialise exactly once at startup (see `bootstrap.dart`) via
/// [AppConfig.init]. Afterwards read values through [AppConfig.instance].
///
/// This is intentionally NOT a Riverpod provider: it has to be available before
/// the widget tree (and `ProviderScope`) exists, e.g. while configuring the
/// network client.
class AppConfig {
  const AppConfig._({
    required this.flavor,
    required this.baseUrl,
    required this.appName,
  });

  final Flavor flavor;
  final String baseUrl;
  final String appName;

  static AppConfig? _instance;

  /// The active configuration. Throws if [init] has not been called.
  static AppConfig get instance {
    final config = _instance;
    if (config == null) {
      throw StateError('AppConfig.init() must be called before use.');
    }
    return config;
  }

  bool get isProd => flavor == Flavor.prod;

  /// Creates and stores the configuration for the given [flavor].
  static AppConfig init(Flavor flavor) {
    return _instance = switch (flavor) {
      Flavor.dev => const AppConfig._(
        flavor: Flavor.dev,
        baseUrl: 'https://reqres.in/api',
        appName: '${AppConstants.appName} (Dev)',
      ),
      Flavor.staging => const AppConfig._(
        flavor: Flavor.staging,
        baseUrl: 'https://reqres.in/api',
        appName: '${AppConstants.appName} (Staging)',
      ),
      Flavor.prod => const AppConfig._(
        flavor: Flavor.prod,
        baseUrl: 'https://reqres.in/api',
        appName: AppConstants.appName,
      ),
    };
  }
}
