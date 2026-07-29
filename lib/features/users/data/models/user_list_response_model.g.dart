// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserListResponseModel _$UserListResponseModelFromJson(
  Map<String, dynamic> json,
) => _UserListResponseModel(
  page: (json['page'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  data: (json['data'] as List<dynamic>)
      .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserListResponseModelToJson(
  _UserListResponseModel instance,
) => <String, dynamic>{
  'page': instance.page,
  'total_pages': instance.totalPages,
  'data': instance.data,
};
