import 'package:dartz/dartz.dart';
import 'package:co_works/core/error/failures.dart';
import 'package:co_works/core/network/api_error_mapper.dart';
import 'package:co_works/core/network/network_info.dart';
import 'package:co_works/features/users/data/datasources/user_remote_data_source.dart';
import 'package:co_works/features/users/domain/entities/app_user.dart';
import 'package:co_works/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remote, this._networkInfo);

  final UserRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<AppUser>>> getUsers({required int page}) {
    return guardApiCall(() async {
      final response = await _remote.getUsers(page);
      return response.data.map((model) => model.toEntity()).toList();
    }, networkInfo: _networkInfo);
  }
}
