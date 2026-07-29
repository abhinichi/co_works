// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ViewModel for the login screen.
///
/// In this MVVM setup a ViewModel is a Riverpod `Notifier`: it exposes
/// immutable [LoginState] and methods that the View calls in response to user
/// actions. It contains presentation logic only and delegates all business
/// logic to use cases — it never touches Dio, repositories or storage directly.

@ProviderFor(LoginViewModel)
final loginViewModelProvider = LoginViewModelProvider._();

/// ViewModel for the login screen.
///
/// In this MVVM setup a ViewModel is a Riverpod `Notifier`: it exposes
/// immutable [LoginState] and methods that the View calls in response to user
/// actions. It contains presentation logic only and delegates all business
/// logic to use cases — it never touches Dio, repositories or storage directly.
final class LoginViewModelProvider
    extends $NotifierProvider<LoginViewModel, LoginState> {
  /// ViewModel for the login screen.
  ///
  /// In this MVVM setup a ViewModel is a Riverpod `Notifier`: it exposes
  /// immutable [LoginState] and methods that the View calls in response to user
  /// actions. It contains presentation logic only and delegates all business
  /// logic to use cases — it never touches Dio, repositories or storage directly.
  LoginViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginViewModelHash();

  @$internal
  @override
  LoginViewModel create() => LoginViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginState>(value),
    );
  }
}

String _$loginViewModelHash() => r'8dc18df2f6634719fa5a0e7ffb896b5d8a5c2d8f';

/// ViewModel for the login screen.
///
/// In this MVVM setup a ViewModel is a Riverpod `Notifier`: it exposes
/// immutable [LoginState] and methods that the View calls in response to user
/// actions. It contains presentation logic only and delegates all business
/// logic to use cases — it never touches Dio, repositories or storage directly.

abstract class _$LoginViewModel extends $Notifier<LoginState> {
  LoginState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LoginState, LoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoginState, LoginState>,
              LoginState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
