import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Thin static wrapper around the `logger` package.
///
/// Using a wrapper (instead of calling `logger` everywhere) means the logging
/// backend can be swapped — or silenced in release builds — from a single
/// place. Logging is disabled in release mode.
class AppLogger {
  const AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0),
    level: kReleaseMode ? Level.off : Level.debug,
  );

  static void d(Object? message) => _logger.d(message);
  static void i(Object? message) => _logger.i(message);
  static void w(Object? message) => _logger.w(message);

  static void e(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
