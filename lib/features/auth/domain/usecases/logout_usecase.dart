import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/core/usecase/usecase.dart';
import 'package:flutter_base_project/features/auth/domain/repositories/auth_repository.dart';

/// Use case: sign the current user out.
///
/// Takes [NoParams] because it needs no input.
class LogoutUseCase implements UseCase<Unit, NoParams> {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => _repository.logout();
}
