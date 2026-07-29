// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's [GoRouter], exposed as a Riverpod provider so it can react to
/// global auth state.
///
/// `redirect` is the single source of truth for navigation guards:
///  * while auth status is `unknown` → stay on the splash screen;
///  * unauthenticated → forced to `/login`;
///  * authenticated → kept out of `/login` and `/`.
///
/// A [ValueNotifier] bridges the Riverpod [AuthController] to go_router's
/// `refreshListenable`, so the router re-evaluates `redirect` on every auth
/// change.

@ProviderFor(goRouter)
final goRouterProvider = GoRouterProvider._();

/// The app's [GoRouter], exposed as a Riverpod provider so it can react to
/// global auth state.
///
/// `redirect` is the single source of truth for navigation guards:
///  * while auth status is `unknown` → stay on the splash screen;
///  * unauthenticated → forced to `/login`;
///  * authenticated → kept out of `/login` and `/`.
///
/// A [ValueNotifier] bridges the Riverpod [AuthController] to go_router's
/// `refreshListenable`, so the router re-evaluates `redirect` on every auth
/// change.

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// The app's [GoRouter], exposed as a Riverpod provider so it can react to
  /// global auth state.
  ///
  /// `redirect` is the single source of truth for navigation guards:
  ///  * while auth status is `unknown` → stay on the splash screen;
  ///  * unauthenticated → forced to `/login`;
  ///  * authenticated → kept out of `/login` and `/`.
  ///
  /// A [ValueNotifier] bridges the Riverpod [AuthController] to go_router's
  /// `refreshListenable`, so the router re-evaluates `redirect` on every auth
  /// change.
  GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'c14a01fac8064bf49590d421041afadb55edf390';
