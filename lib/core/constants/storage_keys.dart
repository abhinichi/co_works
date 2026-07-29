/// Keys used for persistent key/value storage.
///
/// Sensitive values (tokens, credentials) are stored through
/// `SecureStorageService`; non-sensitive flags/preferences through
/// `PreferencesService`. Keeping the keys in one place avoids typos and
/// accidental collisions.
class StorageKeys {
  const StorageKeys._();

  // Secure storage
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  // Shared preferences
  static const String isOnboardingComplete = 'is_onboarding_complete';
  static const String themeMode = 'theme_mode';
}
