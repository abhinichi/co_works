import 'package:co_works/bootstrap.dart';
import 'package:co_works/core/config/app_config.dart';

/// Entry point for the **staging** flavor.
///
/// Run with `flutter run -t lib/main_staging.dart`.
Future<void> main() => bootstrap(Flavor.staging);
