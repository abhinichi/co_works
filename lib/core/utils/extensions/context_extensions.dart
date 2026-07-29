import 'package:flutter/material.dart';
import 'package:co_works/l10n/generated/app_localizations.dart';

/// Ergonomic shortcuts on [BuildContext] for things accessed constantly in the
/// UI layer. Keeps widget code terse and readable.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Localized strings for the current locale.
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Shows a simple snackbar with [message].
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
