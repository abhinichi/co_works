import 'package:co_works/core/error/failures.dart';
import 'package:co_works/core/usecase/usecase.dart';
import 'package:co_works/features/users/domain/entities/app_user.dart';
import 'package:co_works/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case: fetch a page of users.
class GetUsersUseCase implements UseCase<List<AppUser>, GetUsersParams> {
  const GetUsersUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<Either<Failure, List<AppUser>>> call(GetUsersParams params) =>
      _repository.getUsers(page: params.page);
}

class GetUsersParams {
  const GetUsersParams({this.page = 1});

  final int page;
}
