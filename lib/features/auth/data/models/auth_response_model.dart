import 'package:flutter_base_project/features/auth/domain/entities/auth_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

/// Response DTO returned by the login endpoint.
///
/// Note the `toEntity()` mapper: the data layer is responsible for translating
/// transport models into pure domain entities, so domain/presentation code
/// never sees JSON-shaped objects.
@freezed
abstract class AuthResponseModel with _$AuthResponseModel {
  const AuthResponseModel._();

  const factory AuthResponseModel({
    required String token,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  AuthToken toEntity() =>
      AuthToken(accessToken: token, refreshToken: refreshToken);
}
