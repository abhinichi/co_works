import 'package:flutter/material.dart';
import 'package:co_works/core/providers/core_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

/// Holds the app's active [ThemeMode] and persists changes.
///
/// `build()` seeds the initial mode from the stored preference (see
/// `PreferencesService`), so the user's choice survives restarts. The router's
/// `MaterialApp` watches this provider for `themeMode`. Kept alive because the
/// theme is a session-wide concern.
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() => _parse(ref.watch(preferencesServiceProvider).themeMode);

  /// Sets and persists [mode]. No-op if it is already active.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == state) return;
    state = mode;
    await ref.read(preferencesServiceProvider).setThemeMode(mode.name);
  }

  /// Cycles system → light → dark → system, for a single toggle control.
  Future<void> cycle() {
    final next = switch (state) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    return setThemeMode(next);
  }

  static ThemeMode _parse(String? value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
