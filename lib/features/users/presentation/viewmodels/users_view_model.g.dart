// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ViewModel for the users list, implemented as an async `Notifier`.
///
/// For screens whose state is "the result of loading something", an
/// `AsyncNotifier` (generated here via `@riverpod`) is the idiomatic choice: it
/// exposes an `AsyncValue` that captures loading / data / error in one type, so
/// the View can render all three states with a single `.when(...)`.

@ProviderFor(UsersViewModel)
final usersViewModelProvider = UsersViewModelProvider._();

/// ViewModel for the users list, implemented as an async `Notifier`.
///
/// For screens whose state is "the result of loading something", an
/// `AsyncNotifier` (generated here via `@riverpod`) is the idiomatic choice: it
/// exposes an `AsyncValue` that captures loading / data / error in one type, so
/// the View can render all three states with a single `.when(...)`.
final class UsersViewModelProvider
    extends $AsyncNotifierProvider<UsersViewModel, List<AppUser>> {
  /// ViewModel for the users list, implemented as an async `Notifier`.
  ///
  /// For screens whose state is "the result of loading something", an
  /// `AsyncNotifier` (generated here via `@riverpod`) is the idiomatic choice: it
  /// exposes an `AsyncValue` that captures loading / data / error in one type, so
  /// the View can render all three states with a single `.when(...)`.
  UsersViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersViewModelHash();

  @$internal
  @override
  UsersViewModel create() => UsersViewModel();
}

String _$usersViewModelHash() => r'416a19ca67d58b2c7fef70181a07350b1c7ecb3a';

/// ViewModel for the users list, implemented as an async `Notifier`.
///
/// For screens whose state is "the result of loading something", an
/// `AsyncNotifier` (generated here via `@riverpod`) is the idiomatic choice: it
/// exposes an `AsyncValue` that captures loading / data / error in one type, so
/// the View can render all three states with a single `.when(...)`.

abstract class _$UsersViewModel extends $AsyncNotifier<List<AppUser>> {
  FutureOr<List<AppUser>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AppUser>>, List<AppUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AppUser>>, List<AppUser>>,
              AsyncValue<List<AppUser>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
