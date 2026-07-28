import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// The title of the application shown in the browser or OS header
  ///
  /// In en, this message translates to:
  /// **'CoWork Member Login'**
  String get appTitle;

  /// The brand name of the app
  ///
  /// In en, this message translates to:
  /// **'CoWork'**
  String get appName;

  /// Sub-header below brand name
  ///
  /// In en, this message translates to:
  /// **'MEMBER LOGIN'**
  String get memberLogin;

  /// Main title of the login form
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginHeader;

  /// Sub-description of the login form
  ///
  /// In en, this message translates to:
  /// **'Please enter your credentials to log in.'**
  String get loginSubtitle;

  /// Label for the User ID input field
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userIdLabel;

  /// Label for the Password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Label for the Remember me checkbox
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Button/link text for resetting password
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Text for the sign-in submit button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Validation error when user ID field is empty
  ///
  /// In en, this message translates to:
  /// **'User ID is required'**
  String get userIdRequired;

  /// Validation error when email address format is incorrect
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get userIdInvalid;

  /// Validation error when password field is empty
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// Validation error when password is too short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordInvalid;

  /// Footer helper text asking if the user has an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Link text to contact administrator
  ///
  /// In en, this message translates to:
  /// **'Contact Admin'**
  String get contactAdmin;

  /// Footer link for Help Center
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// Footer link for Privacy Policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Copyright notice footer
  ///
  /// In en, this message translates to:
  /// **'© 2026 CoWork Management Systems. All rights reserved.'**
  String get copyrightText;

  /// Snackbar message when successfully submitting login form
  ///
  /// In en, this message translates to:
  /// **'Signing in as {email}...'**
  String signingInAs(String email);

  /// Snackbar message when forgot password link is tapped
  ///
  /// In en, this message translates to:
  /// **'Forgot password link clicked'**
  String get forgotPasswordClicked;

  /// Snackbar message when contact admin link is tapped
  ///
  /// In en, this message translates to:
  /// **'Contact Admin clicked'**
  String get contactAdminClicked;

  /// Forgot password screen heading
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// Instructions under forgot password heading
  ///
  /// In en, this message translates to:
  /// **'Enter your User ID or registered Email to receive reset instructions.'**
  String get forgotPasswordInstruction;

  /// Label for the email/user ID input field on forgot password screen
  ///
  /// In en, this message translates to:
  /// **'Email or User ID'**
  String get emailOrUserIdLabel;

  /// Placeholder hint for email/user ID input field
  ///
  /// In en, this message translates to:
  /// **'e.g., naren@nichi.com'**
  String get emailOrUserIdPlaceholder;

  /// Text for button that sends reset link
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLinkLabel;

  /// Link text to go back to the login screen
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// Footer link for Terms of Use
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// Toast message showing email reset link has been sent
  ///
  /// In en, this message translates to:
  /// **'Reset link sent to {email}'**
  String resetLinkSent(String email);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
