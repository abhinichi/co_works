import 'package:flutter_base_project/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// Status of the login form submission.
enum LoginStatus { initial, submitting, success, failure }

/// Immutable UI state for the login screen — the "VM" half of MVVM.
///
/// The View renders purely from this object and forwards user intent to
/// [LoginViewModel]. Keeping state in a dedicated immutable class (via
/// `freezed`) makes the screen predictable and trivially testable.
@freezed
abstract class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool obscurePassword,
    @Default(LoginStatus.initial) LoginStatus status,
    // Kept as a domain [Failure] (not a String) so the View can localize it.
    Failure? failure,
  }) = _LoginState;

  bool get isSubmitting => status == LoginStatus.submitting;
}
