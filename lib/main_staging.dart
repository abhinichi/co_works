import 'package:flutter_base_project/bootstrap.dart';
import 'package:flutter_base_project/core/config/app_config.dart';

/// Entry point for the **staging** flavor.
///
/// Run with `flutter run -t lib/main_staging.dart`.
Future<void> main() => bootstrap(Flavor.staging);
