import 'package:co_works/core/error/failures.dart';
import 'package:co_works/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// Runs a data-source call and converts any thrown error into a [Failure],
/// returning the canonical `Either<Failure, T>` used throughout the app.
///
/// Repository implementations wrap their data-source calls in this helper so
/// they stay free of repetitive try/catch boilerplate:
///
/// ```dart
/// Future<Either<Failure, AuthToken>> login(LoginParams params) {
///   return guardApiCall(() async {
///     final dto = await _remote.login(params.toModel());
///     return dto.toEntity();
///   });
/// }
/// ```
Future<Either<Failure, T>> guardApiCall<T>(
  Future<T> Function() call, {
  NetworkInfo? networkInfo,
}) async {
  try {
    // Fail fast (and offer a clear message) when the device is offline, instead
    // of waiting for the request to time out.
    if (networkInfo != null && !await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    return Right(await call());
  } on DioException catch (e) {
    return Left(e.toFailure());
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}

/// Maps a low-level [DioException] to a domain [Failure].
extension DioExceptionMapper on DioException {
  Failure toFailure() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const TimeoutFailure();
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return const UnauthorizedFailure();
        }
        return ServerFailure(
          _messageFromResponse() ?? 'Server error ($statusCode)',
        );
      case DioExceptionType.cancel:
        return const UnknownFailure('Request was cancelled');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }

  /// Best-effort extraction of a human readable message from an error body.
  String? _messageFromResponse() {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      final value = data['message'] ?? data['error'];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }
}
