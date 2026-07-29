import 'package:co_works/features/auth/domain/usecases/login_usecase.dart';
import 'package:co_works/features/auth/presentation/providers/auth_providers.dart';
import 'package:co_works/features/auth/presentation/viewmodels/auth_controller.dart';
import 'package:co_works/features/auth/presentation/viewmodels/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

/// ViewModel for the login screen.
///
/// In this MVVM setup a ViewModel is a Riverpod `Notifier`: it exposes
/// immutable [LoginState] and methods that the View calls in response to user
/// actions. It contains presentation logic only and delegates all business
/// logic to use cases — it never touches Dio, repositories or storage directly.
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState();

  void emailChanged(String value) =>
      state = state.copyWith(email: value, status: LoginStatus.initial);

  void passwordChanged(String value) =>
      state = state.copyWith(password: value, status: LoginStatus.initial);

  void toggleObscurePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  /// Runs the login use case with the current credentials and folds the result
  /// into [LoginState]. On success it flips the global session status via
  /// [AuthController] so the router moves the user into the authenticated area.
  /// No-ops while a submission is already in flight.
  Future<void> submit() async {
    if (state.isSubmitting) return;
    state = state.copyWith(status: LoginStatus.submitting, failure: null);

    final result = await ref
        .read(loginUseCaseProvider)
        .call(LoginParams(email: state.email.trim(), password: state.password));

    state = result.fold(
      (failure) =>
          state.copyWith(status: LoginStatus.failure, failure: failure),
      (_) => state.copyWith(status: LoginStatus.success),
    );

    // On success, flip the global session status so the router moves the user
    // into the authenticated area.
    if (state.status == LoginStatus.success) {
      ref.read(authControllerProvider.notifier).markAuthenticated();
    }
  }
}
