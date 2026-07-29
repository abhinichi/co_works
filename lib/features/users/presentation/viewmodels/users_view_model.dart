import 'package:co_works/features/users/domain/entities/app_user.dart';
import 'package:co_works/features/users/domain/usecases/get_users_usecase.dart';
import 'package:co_works/features/users/presentation/providers/user_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_view_model.g.dart';

/// ViewModel for the users list, implemented as an async `Notifier`.
///
/// For screens whose state is "the result of loading something", an
/// `AsyncNotifier` (generated here via `@riverpod`) is the idiomatic choice: it
/// exposes an `AsyncValue` that captures loading / data / error in one type, so
/// the View can render all three states with a single `.when(...)`.
@riverpod
class UsersViewModel extends _$UsersViewModel {
  @override
  Future<List<AppUser>> build() => _fetch();

  Future<List<AppUser>> _fetch() async {
    final result = await ref
        .read(getUsersUseCaseProvider)
        .call(const GetUsersParams());
    // Translate Either -> value/throw so it slots into AsyncValue: a thrown
    // Failure becomes AsyncError, which the View renders via `.when`.
    return result.fold((failure) => throw failure, (users) => users);
  }

  /// Pull-to-refresh handler.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}
