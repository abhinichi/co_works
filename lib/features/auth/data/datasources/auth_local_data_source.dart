import 'package:co_works/core/storage/secure_storage_service.dart';

/// Local data source for authentication: persists and reads the session token
/// via secure storage. Keeping this behind its own class means the repository
/// depends on a clear "local" boundary, symmetrical to the remote one.
class AuthLocalDataSource {
  AuthLocalDataSource(this._secureStorage);

  final SecureStorageService _secureStorage;

  /// Persists the session tokens after a successful login.
  Future<void> cacheTokens({
    required String accessToken,
    String? refreshToken,
  }) {
    return _secureStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Removes the persisted session (used on logout).
  Future<void> clear() => _secureStorage.clearTokens();

  /// Whether a non-empty access token is currently stored.
  Future<bool> hasToken() async {
    final token = await _secureStorage.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
