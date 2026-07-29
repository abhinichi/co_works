import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/config/app_config.dart';
import 'package:flutter_base_project/core/router/app_router.dart';
import 'package:flutter_base_project/core/theme/app_theme.dart';
import 'package:flutter_base_project/core/theme/theme_controller.dart';
import 'package:flutter_base_project/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root widget of the application.
///
/// Reads the router from Riverpod and wires up theming. `MaterialApp.router` is
/// used because navigation is handled by `go_router`.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: AppConfig.instance.appName,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
