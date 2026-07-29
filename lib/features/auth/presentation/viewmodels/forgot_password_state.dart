import 'package:co_works/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

/// Status of the forgot password form submission.
enum ForgotPasswordStatus { initial, submitting, success, failure }

/// Immutable UI state for the forgot password screen.
@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const ForgotPasswordState._();

  const factory ForgotPasswordState({
    @Default('') String email,
    @Default(ForgotPasswordStatus.initial) ForgotPasswordStatus status,
    Failure? failure,
  }) = _ForgotPasswordState;

  bool get isSubmitting => status == ForgotPasswordStatus.submitting;
}
