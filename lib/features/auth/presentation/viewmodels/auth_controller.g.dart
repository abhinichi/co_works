// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Session-wide auth state.
///
/// This is a `keepAlive` ViewModel that holds the *global* auth status. The
/// router (`app_router.dart`) listens to it to redirect between the login flow
/// and the authenticated area. Screen-specific logic (the login form) lives in
/// [LoginViewModel] instead — this controller only tracks "are we signed in".

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Session-wide auth state.
///
/// This is a `keepAlive` ViewModel that holds the *global* auth status. The
/// router (`app_router.dart`) listens to it to redirect between the login flow
/// and the authenticated area. Screen-specific logic (the login form) lives in
/// [LoginViewModel] instead — this controller only tracks "are we signed in".
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AuthStatus> {
  /// Session-wide auth state.
  ///
  /// This is a `keepAlive` ViewModel that holds the *global* auth status. The
  /// router (`app_router.dart`) listens to it to redirect between the login flow
  /// and the authenticated area. Screen-specific logic (the login form) lives in
  /// [LoginViewModel] instead — this controller only tracks "are we signed in".
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStatus>(value),
    );
  }
}

String _$authControllerHash() => r'd6681d4d998a52e2597ed189418ebc393c6c16b6';

/// Session-wide auth state.
///
/// This is a `keepAlive` ViewModel that holds the *global* auth status. The
/// router (`app_router.dart`) listens to it to redirect between the login flow
/// and the authenticated area. Screen-specific logic (the login form) lives in
/// [LoginViewModel] instead — this controller only tracks "are we signed in".

abstract class _$AuthController extends $Notifier<AuthStatus> {
  AuthStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthStatus, AuthStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthStatus, AuthStatus>,
              AuthStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
