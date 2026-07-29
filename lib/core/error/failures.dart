/// Failures belong to the **domain layer**.
///
/// A `Failure` is the left side of every `Either<Failure, T>` returned by
/// repositories and use cases. Unlike exceptions, failures are part of the
/// public contract of the domain: the presentation layer pattern-matches on
/// them to decide what message/UI to show.
sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() => '$runtimeType: $message';
}

/// The server returned an error response.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on the server']);
}

/// The device is offline or the request never reached the server.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// The request timed out.
class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'The connection has timed out']);
}

/// Authentication is required or the session has expired.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Session expired, please sign in',
  ]);
}

/// A local cache/storage operation failed.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to read local data']);
}

/// Anything we did not explicitly anticipate.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred']);
}
