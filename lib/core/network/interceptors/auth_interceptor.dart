import 'package:dio/dio.dart';
import 'package:co_works/core/storage/secure_storage_service.dart';

/// Attaches the bearer token (when present) to every outgoing request.
///
/// The token is read lazily from [SecureStorageService] on each request, so it
/// always reflects the latest sign-in/sign-out state without rebuilding the
/// [Dio] instance.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);

  final SecureStorageService _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // On 401 the session is no longer valid: clear stored credentials so the
    // app can react (e.g. redirect to login). A real app would attempt a
    // refresh-token flow here before giving up.
    if (err.response?.statusCode == 401) {
      await _secureStorage.clearTokens();
    }
    handler.next(err);
  }
}
