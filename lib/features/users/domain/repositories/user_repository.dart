import 'package:co_works/core/error/failures.dart';
import 'package:co_works/features/users/domain/entities/app_user.dart';
import 'package:dartz/dartz.dart';

/// Repository contract for the users feature.
abstract interface class UserRepository {
  /// Fetches a single page of users.
  Future<Either<Failure, List<AppUser>>> getUsers({required int page});
}
