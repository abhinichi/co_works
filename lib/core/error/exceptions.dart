/// Exceptions thrown by the **data layer** (data sources).
///
/// These represent low-level, technical errors. They are caught in the
/// repository implementations and converted into domain-level `Failure`s so the
/// rest of the app never has to deal with raw exceptions. See `failures.dart`.
sealed class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType($statusCode): $message';
}

/// The server responded with a non-2xx status code.
class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

/// No internet connection / request never reached the server.
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

/// Request timed out.
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'The connection has timed out']);
}

/// Authentication failed or the session expired (HTTP 401).
class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized']);
}

/// A local persistence (cache) operation failed.
class CacheException extends AppException {
  const CacheException([super.message = 'Cache error']);
}
