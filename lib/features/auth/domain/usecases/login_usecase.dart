import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/core/usecase/usecase.dart';
import 'package:flutter_base_project/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_base_project/features/auth/domain/repositories/auth_repository.dart';

/// Use case: sign a user in.
///
/// A use case orchestrates a single business action by delegating to one or
/// more repositories. It is the only place feature-level business rules belong
/// (here, simply forwarding to the repository — but validation, combining
/// multiple sources, etc. would live here too).
class LoginUseCase implements UseCase<AuthToken, LoginParams> {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthToken>> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}

/// Input parameters for [LoginUseCase].
class LoginParams {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;
}
