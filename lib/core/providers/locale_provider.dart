import 'package:co_works/core/providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Holds the app's active [Locale] and persists changes.
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale build() {
    final code = ref.watch(preferencesServiceProvider).locale;
    return code != null ? Locale(code) : const Locale('en');
  }

  /// Sets and persists [locale]. No-op if it is already active.
  Future<void> setLocale(Locale locale) async {
    if (locale == state) return;
    state = locale;
    await ref.read(preferencesServiceProvider).setLocale(locale.languageCode);
  }
}
