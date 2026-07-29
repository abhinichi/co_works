// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the app's active [ThemeMode] and persists changes.
///
/// `build()` seeds the initial mode from the stored preference (see
/// `PreferencesService`), so the user's choice survives restarts. The router's
/// `MaterialApp` watches this provider for `themeMode`. Kept alive because the
/// theme is a session-wide concern.

@ProviderFor(ThemeController)
final themeControllerProvider = ThemeControllerProvider._();

/// Holds the app's active [ThemeMode] and persists changes.
///
/// `build()` seeds the initial mode from the stored preference (see
/// `PreferencesService`), so the user's choice survives restarts. The router's
/// `MaterialApp` watches this provider for `themeMode`. Kept alive because the
/// theme is a session-wide concern.
final class ThemeControllerProvider
    extends $NotifierProvider<ThemeController, ThemeMode> {
  /// Holds the app's active [ThemeMode] and persists changes.
  ///
  /// `build()` seeds the initial mode from the stored preference (see
  /// `PreferencesService`), so the user's choice survives restarts. The router's
  /// `MaterialApp` watches this provider for `themeMode`. Kept alive because the
  /// theme is a session-wide concern.
  ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeControllerHash() => r'4bae76eb4133369d1993b60bc2d65082f6f5d257';

/// Holds the app's active [ThemeMode] and persists changes.
///
/// `build()` seeds the initial mode from the stored preference (see
/// `PreferencesService`), so the user's choice survives restarts. The router's
/// `MaterialApp` watches this provider for `themeMode`. Kept alive because the
/// theme is a session-wide concern.

abstract class _$ThemeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
