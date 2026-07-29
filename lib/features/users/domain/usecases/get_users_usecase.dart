import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/core/usecase/usecase.dart';
import 'package:flutter_base_project/features/users/domain/entities/app_user.dart';
import 'package:flutter_base_project/features/users/domain/repositories/user_repository.dart';

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
