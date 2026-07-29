// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CoWork Member Login';

  @override
  String get appName => 'CoWork';

  @override
  String get memberLogin => 'MEMBER LOGIN';

  @override
  String get loginHeader => 'Login';

  @override
  String get loginSubtitle => 'Please enter your credentials to log in.';

  @override
  String get userIdLabel => 'User ID';

  @override
  String get passwordLabel => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signInButton => 'Sign In';

  @override
  String get userIdRequired => 'User ID is required';

  @override
  String get userIdInvalid => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordInvalid => 'Password must be at least 6 characters';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get contactAdmin => 'Contact Admin';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get copyrightText =>
      '© 2026 CoWork Management Systems. All rights reserved.';

  @override
  String signingInAs(String email) {
    return 'Signing in as $email...';
  }

  @override
  String get forgotPasswordClicked => 'Forgot password link clicked';

  @override
  String get contactAdminClicked => 'Contact Admin clicked';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordInstruction =>
      'Enter your User ID or registered Email to receive reset instructions.';

  @override
  String get emailOrUserIdLabel => 'Email or User ID';

  @override
  String get emailOrUserIdPlaceholder => 'e.g., naren@nichi.com';

  @override
  String get sendResetLinkLabel => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String resetLinkSent(String email) {
    return 'Reset link sent to $email';
  }

  @override
  String get signInAppBarTitle => 'Sign in';

  @override
  String get loginWelcome => 'Welcome back';

  @override
  String get emailLabel => 'Email';

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
