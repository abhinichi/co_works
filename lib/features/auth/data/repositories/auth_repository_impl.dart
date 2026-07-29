import 'package:co_works/core/error/failures.dart';
import 'package:co_works/core/network/api_error_mapper.dart';
import 'package:co_works/core/network/network_info.dart';
import 'package:co_works/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:co_works/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:co_works/features/auth/data/models/login_request_model.dart';
import 'package:co_works/features/auth/domain/entities/auth_token.dart';
import 'package:co_works/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

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

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) async {
    // Since reqres.in does not support a forgot-password endpoint, we simulate
    // the network latency and return success.
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
