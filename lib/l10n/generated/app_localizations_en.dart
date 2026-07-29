// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Base Project';

  @override
  String get signInAppBarTitle => 'Sign in';

  @override
  String get loginWelcome => 'Welcome back';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signInButton => 'Sign in';

  @override
  String get usersTitle => 'Users';

  @override
  String get signOutTooltip => 'Sign out';

  @override
  String get usersEmpty => 'No users found';

  @override
  String get toggleThemeTooltip => 'Toggle theme';

  @override
  String get retryButton => 'Retry';

  @override
  String get failureServer => 'Something went wrong on the server';

  @override
  String get failureNetwork => 'No internet connection';

  @override
  String get failureTimeout => 'The connection has timed out';

  @override
  String get failureUnauthorized => 'Session expired, please sign in';

  @override
  String get failureCache => 'Failed to read local data';

  @override
  String get failureUnknown => 'An unexpected error occurred';
}
