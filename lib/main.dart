import 'package:co_works/router/navigation_router.dart';
import 'package:co_works/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:co_works/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// A ValueNotifier to manage the app's current locale dynamically.
final ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(const Locale('en'));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, locale, child) {
        return MaterialApp.router(
          title: 'CoWork Member Login',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: locale,
          routerConfig: appRouter,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ja'), // Japanese
          ],
        );
      },
    );
  }
}
