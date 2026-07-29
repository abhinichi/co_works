import 'package:flutter_base_project/core/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around [SharedPreferences] for **non-sensitive** flags and settings
/// (onboarding state, theme choice, …). For tokens and other secrets use
/// `SecureStorageService` instead.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  /// Whether the user has completed onboarding. Defaults to `false`.
  bool get isOnboardingComplete =>
      _prefs.getBool(StorageKeys.isOnboardingComplete) ?? false;

  Future<void> setOnboardingComplete({required bool isComplete}) =>
      _prefs.setBool(StorageKeys.isOnboardingComplete, isComplete);

  /// The persisted theme choice as a `ThemeMode.name` string
  /// (`'system' | 'light' | 'dark'`), or `null` if never set. Parsed by
  /// `ThemeController`.
  String? get themeMode => _prefs.getString(StorageKeys.themeMode);

  /// Persists [value], expected to be a `ThemeMode.name` string.
  Future<void> setThemeMode(String value) =>
      _prefs.setString(StorageKeys.themeMode, value);
}
