import 'package:co_works/bootstrap.dart';
import 'package:co_works/core/config/app_config.dart';

/// Default entry point (dev flavor).
///
/// Per-flavor entry points live alongside this file — `main_dev.dart`,
/// `main_staging.dart`, `main_prod.dart` — each calling `bootstrap(Flavor.x)`.
/// Run a specific flavor with e.g. `flutter run -t lib/main_staging.dart`.
Future<void> main() => bootstrap(Flavor.dev);
