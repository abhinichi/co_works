import 'package:dartz/dartz.dart';
import 'package:co_works/core/error/failures.dart';
import 'package:co_works/features/auth/domain/entities/auth_token.dart';

/// Repository **contract** for authentication.
///
/// This interface lives in the domain layer and is the boundary between
/// business logic and data. Use cases depend on this abstraction; the concrete
/// `AuthRepositoryImpl` in the data layer implements it. This inversion is what
/// keeps the domain independent of Dio, Retrofit, storage, etc.
abstract interface class AuthRepository {
  /// Authenticates with [email]/[password] and persists the session token.
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
  });

  /// Clears the persisted session.
  Future<Either<Failure, Unit>> logout();

  /// Whether a valid session token is currently stored.
  Future<bool> isLoggedIn();
}
