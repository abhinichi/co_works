import 'package:flutter_base_project/bootstrap.dart';
import 'package:flutter_base_project/core/config/app_config.dart';

/// Entry point for the **dev** flavor.
///
/// Run with `flutter run -t lib/main_dev.dart`.
Future<void> main() => bootstrap(Flavor.dev);
