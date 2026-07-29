import 'package:co_works/core/providers/core_providers.dart';
import 'package:co_works/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:co_works/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:co_works/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:co_works/features/auth/domain/repositories/auth_repository.dart';
import 'package:co_works/features/auth/domain/usecases/login_usecase.dart';
import 'package:co_works/features/auth/domain/usecases/logout_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

/// Dependency-injection graph for the auth feature.
///
/// Riverpod is used as the DI container: each layer is exposed as a provider
/// that `watch`es the layer it depends on. This wiring file is the only place
/// that knows how the concrete pieces fit together, so swapping an
/// implementation (e.g. a fake repository in tests) means overriding one
/// provider.

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) =>
    AuthRemoteDataSource(ref.watch(dioProvider));

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) =>
    AuthLocalDataSource(ref.watch(secureStorageServiceProvider));

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  remote: ref.watch(authRemoteDataSourceProvider),
  local: ref.watch(authLocalDataSourceProvider),
  networkInfo: ref.watch(networkInfoProvider),
);

@riverpod
LoginUseCase loginUseCase(Ref ref) =>
    LoginUseCase(ref.watch(authRepositoryProvider));

@riverpod
LogoutUseCase logoutUseCase(Ref ref) =>
    LogoutUseCase(ref.watch(authRepositoryProvider));
