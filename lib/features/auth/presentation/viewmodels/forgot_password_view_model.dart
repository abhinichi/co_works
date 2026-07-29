import 'package:co_works/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:co_works/features/auth/presentation/providers/auth_providers.dart';
import 'package:co_works/features/auth/presentation/viewmodels/forgot_password_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_view_model.g.dart';

/// ViewModel for the forgot password screen.
@riverpod
class ForgotPasswordViewModel extends _$ForgotPasswordViewModel {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  void emailChanged(String value) => state = state.copyWith(
    email: value,
    status: ForgotPasswordStatus.initial,
  );

  /// Runs the forgot password use case and updates state.
  Future<void> submit() async {
    if (state.isSubmitting) return;
    state = state.copyWith(
      status: ForgotPasswordStatus.submitting,
      failure: null,
    );

    final result = await ref
        .read(forgotPasswordUseCaseProvider)
        .call(ForgotPasswordParams(email: state.email.trim()));

    state = result.fold(
      (failure) => state.copyWith(
        status: ForgotPasswordStatus.failure,
        failure: failure,
      ),
      (_) => state.copyWith(status: ForgotPasswordStatus.success),
    );
  }
}
