import 'package:flutter_base_project/core/providers/core_providers.dart';
import 'package:flutter_base_project/features/users/data/datasources/user_remote_data_source.dart';
import 'package:flutter_base_project/features/users/data/repositories/user_repository_impl.dart';
import 'package:flutter_base_project/features/users/domain/repositories/user_repository.dart';
import 'package:flutter_base_project/features/users/domain/usecases/get_users_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_providers.g.dart';

/// DI graph for the users feature.

@riverpod
UserRemoteDataSource userRemoteDataSource(Ref ref) =>
    UserRemoteDataSource(ref.watch(dioProvider));

@riverpod
UserRepository userRepository(Ref ref) => UserRepositoryImpl(
  ref.watch(userRemoteDataSourceProvider),
  ref.watch(networkInfoProvider),
);

@riverpod
GetUsersUseCase getUsersUseCase(Ref ref) =>
    GetUsersUseCase(ref.watch(userRepositoryProvider));
