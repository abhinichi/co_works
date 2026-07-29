import 'package:co_works/core/error/failures.dart';
import 'package:co_works/core/usecase/usecase.dart';
import 'package:co_works/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case: request password reset instructions.
class ForgotPasswordUseCase implements UseCase<Unit, ForgotPasswordParams> {
  const ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(ForgotPasswordParams params) {
    return _repository.forgotPassword(email: params.email);
  }
}

/// Input parameters for [ForgotPasswordUseCase].
class ForgotPasswordParams {
  const ForgotPasswordParams({required this.email});

  final String email;
}
