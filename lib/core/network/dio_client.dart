import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:co_works/core/constants/app_constants.dart';
import 'package:co_works/core/network/interceptors/auth_interceptor.dart';
import 'package:co_works/core/network/interceptors/logging_interceptor.dart';

/// Factory that assembles a fully configured [Dio] instance.
///
/// Construction lives here (and not in a provider) so the wiring is in one
/// place and easy to test. The provider in `core_providers.dart` simply calls
/// [DioClient.create] with its dependencies.
class DioClient {
  const DioClient._();

  static Dio create({
    required String baseUrl,
    required AuthInterceptor authInterceptor,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        sendTimeout: AppConstants.sendTimeout,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.acceptHeader: ContentType.json.value,
        },
        // Dio's default: 2xx succeeds, everything else raises a DioException
        // that the repository layer catches and maps to a Failure.
      ),
    );

    dio.interceptors.add(authInterceptor);
    if (!kReleaseMode) {
      dio.interceptors.add(LoggingInterceptor());
    }

    return dio;
  }
}
