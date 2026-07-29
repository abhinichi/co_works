import 'package:co_works/bootstrap.dart';
import 'package:co_works/core/config/app_config.dart';

/// Entry point for the **prod** flavor.
///
/// Run with `flutter run -t lib/main_prod.dart`.
Future<void> main() => bootstrap(Flavor.prod);
