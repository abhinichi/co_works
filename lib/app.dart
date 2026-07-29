import 'package:flutter/material.dart';
import 'package:co_works/core/config/app_config.dart';
import 'package:co_works/core/router/app_router.dart';
import 'package:co_works/core/theme/app_theme.dart';
import 'package:co_works/core/theme/theme_controller.dart';
import 'package:co_works/l10n/generated/app_localizations.dart';

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
