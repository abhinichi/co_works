import 'package:flutter_base_project/core/constants/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wrapper around [FlutterSecureStorage] for **sensitive** data (auth tokens,
/// credentials). Values are encrypted by the platform keystore/keychain.
///
/// Exposing intention-revealing methods (`getAccessToken`, `saveTokens`, …)
/// keeps storage keys in one place and hides the raw key/value API from callers.
class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  /// The stored access token, or `null` if none has been saved.
  Future<String?> getAccessToken() =>
      _storage.read(key: StorageKeys.accessToken);

  /// The stored refresh token, or `null` if none has been saved.
  Future<String?> getRefreshToken() =>
      _storage.read(key: StorageKeys.refreshToken);

  /// Persists [accessToken]; writes [refreshToken] only when it is non-null so
  /// an existing refresh token is not clobbered by a token-only response.
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: StorageKeys.accessToken, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: StorageKeys.refreshToken, value: refreshToken);
    }
  }

  /// Deletes both tokens. Called on logout and on a 401 (see `AuthInterceptor`).
  Future<void> clearTokens() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }
}
