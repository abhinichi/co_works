import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/config/app_config.dart';
import 'package:flutter_base_project/core/network/dio_client.dart';
import 'package:flutter_base_project/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_base_project/core/network/network_info.dart';
import 'package:flutter_base_project/core/storage/preferences_service.dart';
import 'package:flutter_base_project/core/storage/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core_providers.g.dart';

/// Cross-cutting infrastructure providers (network, storage).
///
/// They are `keepAlive` because they wrap singletons that should live for the
/// whole app session rather than being disposed when no widget is listening.

// ---- Storage ---------------------------------------------------------------

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) =>
    const FlutterSecureStorage();

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) =>
    SecureStorageService(ref.watch(flutterSecureStorageProvider));

/// Overridden in `ProviderScope` at startup with the resolved instance (see
/// `bootstrap.dart`). Reading it before the override is a programmer error,
/// hence the explicit throw.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('sharedPreferencesProvider must be overridden');

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) =>
    PreferencesService(ref.watch(sharedPreferencesProvider));

// ---- Network ---------------------------------------------------------------

@Riverpod(keepAlive: true)
AuthInterceptor authInterceptor(Ref ref) =>
    AuthInterceptor(ref.watch(secureStorageServiceProvider));

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => DioClient.create(
  baseUrl: AppConfig.instance.baseUrl,
  authInterceptor: ref.watch(authInterceptorProvider),
);

@Riverpod(keepAlive: true)
Connectivity connectivity(Ref ref) => Connectivity();

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) =>
    NetworkInfoImpl(ref.watch(connectivityProvider));
