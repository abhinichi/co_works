import 'package:flutter_base_project/bootstrap.dart';
import 'package:flutter_base_project/core/config/app_config.dart';

/// Default entry point (dev flavor).
///
/// Per-flavor entry points live alongside this file — `main_dev.dart`,
/// `main_staging.dart`, `main_prod.dart` — each calling `bootstrap(Flavor.x)`.
/// Run a specific flavor with e.g. `flutter run -t lib/main_staging.dart`.
Future<void> main() => bootstrap(Flavor.dev);
