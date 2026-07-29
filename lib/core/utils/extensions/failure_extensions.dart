import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/l10n/generated/app_localizations.dart';

/// Maps a domain [Failure] to a user-facing, **localized** message.
///
/// This lives in the presentation layer on purpose: `Failure` (domain) must not
/// depend on Flutter/localization, so the translation happens here, where the
/// UI already has an [AppLocalizations]. Views call this instead of reading the
/// raw (English fallback) `Failure.message`.
extension FailureLocalizer on Failure {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
    ServerFailure() => l10n.failureServer,
    NetworkFailure() => l10n.failureNetwork,
    TimeoutFailure() => l10n.failureTimeout,
    UnauthorizedFailure() => l10n.failureUnauthorized,
    CacheFailure() => l10n.failureCache,
    UnknownFailure() => l10n.failureUnknown,
  };
}
