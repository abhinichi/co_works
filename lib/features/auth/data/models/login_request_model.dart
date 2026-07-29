import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

/// Request DTO sent to the login endpoint.
///
/// Models (DTOs) live in the data layer and own all JSON serialization. They
/// are generated with `freezed` (immutability, copyWith, ==) +
/// `json_serializable` (to/fromJson) so we never hand-write boilerplate.
@freezed
abstract class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    required String email,
    required String password,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}
