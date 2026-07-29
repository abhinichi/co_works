import 'package:co_works/features/users/domain/entities/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// DTO for a single user as returned by the API.
///
/// `@JsonKey` maps snake_case API fields onto Dart camelCase. `toEntity()`
/// converts the transport model into the domain [AppUser].
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String avatar,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  AppUser toEntity() => AppUser(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    avatarUrl: avatar,
  );
}
