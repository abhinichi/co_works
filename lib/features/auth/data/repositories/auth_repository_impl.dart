import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/core/network/api_error_mapper.dart';
import 'package:flutter_base_project/core/network/network_info.dart';
import 'package:flutter_base_project/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_base_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_base_project/features/auth/data/models/login_request_model.dart';
import 'package:flutter_base_project/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_base_project/features/auth/domain/repositories/auth_repository.dart';

/// Concrete implementation of [AuthRepository].
///
/// This is where the data layer is orchestrated: call the remote source, map
/// the DTO to a domain entity, persist what needs persisting, and translate any
/// thrown exception into a [Failure] via [guardApiCall]. The domain layer above
/// never learns that Dio/Retrofit/secure-storage were involved.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
    required NetworkInfo networkInfo,
  }) : _remote = remote,
       _local = local,
       _networkInfo = networkInfo;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
  }) {
    return guardApiCall(() async {
      final response = await _remote.login(
        LoginRequestModel(email: email, password: password),
      );
      final token = response.toEntity();
      await _local.cacheTokens(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );
      return token;
    }, networkInfo: _networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _local.clear();
      return const Right(unit);
    } catch (_) {
      return const Left(CacheFailure('Failed to clear session'));
    }
  }

  @override
  Future<bool> isLoggedIn() => _local.hasToken();
}
