import 'package:co_works/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

/// Logs every request, response and error through [AppLogger].
///
/// Wired up only outside of release builds (see `dio_client.dart`) to avoid
/// leaking data and adding overhead in production.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('→ ${options.method} ${options.uri}');
    if (options.data != null) AppLogger.d('  body: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.d('← ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e(
      '✗ ${err.requestOptions.method} ${err.requestOptions.uri}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
