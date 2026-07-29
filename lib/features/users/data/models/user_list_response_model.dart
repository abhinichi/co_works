import 'package:co_works/features/users/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_list_response_model.freezed.dart';
part 'user_list_response_model.g.dart';

/// DTO wrapping a paginated list response: `{ page, total_pages, data: [...] }`.
///
/// Modelling the envelope (not just the list) keeps pagination metadata
/// available to the data layer if/when it is needed.
@freezed
abstract class UserListResponseModel with _$UserListResponseModel {
  const factory UserListResponseModel({
    required int page,
    @JsonKey(name: 'total_pages') required int totalPages,
    required List<UserModel> data,
  }) = _UserListResponseModel;

  factory UserListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseModelFromJson(json);
}
