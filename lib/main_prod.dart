import 'package:flutter_base_project/bootstrap.dart';
import 'package:flutter_base_project/core/config/app_config.dart';

/// Entry point for the **prod** flavor.
///
/// Run with `flutter run -t lib/main_prod.dart`.
Future<void> main() => bootstrap(Flavor.prod);
