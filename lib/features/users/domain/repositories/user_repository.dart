import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/features/users/domain/entities/app_user.dart';

/// Repository contract for the users feature.
abstract interface class UserRepository {
  /// Fetches a single page of users.
  Future<Either<Failure, List<AppUser>>> getUsers({required int page});
}
