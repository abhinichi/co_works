import 'package:flutter/material.dart';
import 'package:flutter_base_project/app.dart';
import 'package:flutter_base_project/core/config/app_config.dart';
import 'package:flutter_base_project/core/providers/core_providers.dart';
import 'package:flutter_base_project/core/utils/app_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared startup routine used by every flavor entry point (e.g.
/// `main_dev.dart`, `main_prod.dart`, or the default `main.dart`).
///
/// Responsibilities:
///  1. Ensure the Flutter binding is ready.
///  2. Initialise the per-flavor [AppConfig].
///  3. Perform async setup that must complete before the first frame
///     (here: opening `SharedPreferences`).
///  4. Run the app inside a `ProviderScope`, overriding any providers that
///     need a pre-resolved instance.
///  5. Install a global error handler.
Future<void> bootstrap(Flavor flavor) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  AppConfig.init(flavor);

  final prefs = await SharedPreferences.getInstance();

  // Errors surfaced by the Flutter framework (build/layout/paint).
  FlutterError.onError = (details) {
    AppLogger.e(
      'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  // Errors that escape the framework: async gaps, platform channels, etc.
  // Returning true marks them as handled so the app is not torn down.
  binding.platformDispatcher.onError = (error, stack) {
    AppLogger.e('PlatformDispatcher', error: error, stackTrace: stack);
    return true;
  };

  runApp(
    ProviderScope(
      overrides: [
        // The provider declares `throw UnimplementedError`; here we supply the
        // real, already-initialised instance.
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
}
