// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserListResponseModel {

 int get page;@JsonKey(name: 'total_pages') int get totalPages; List<UserModel> get data;
/// Create a copy of UserListResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserListResponseModelCopyWith<UserListResponseModel> get copyWith => _$UserListResponseModelCopyWithImpl<UserListResponseModel>(this as UserListResponseModel, _$identity);

  /// Serializes this UserListResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserListResponseModel&&(identical(other.page, page) || other.page == page)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,totalPages,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'UserListResponseModel(page: $page, totalPages: $totalPages, data: $data)';
}


}

/// @nodoc
abstract mixin class $UserListResponseModelCopyWith<$Res>  {
  factory $UserListResponseModelCopyWith(UserListResponseModel value, $Res Function(UserListResponseModel) _then) = _$UserListResponseModelCopyWithImpl;
@useResult
$Res call({
 int page,@JsonKey(name: 'total_pages') int totalPages, List<UserModel> data
});




}
/// @nodoc
class _$UserListResponseModelCopyWithImpl<$Res>
    implements $UserListResponseModelCopyWith<$Res> {
  _$UserListResponseModelCopyWithImpl(this._self, this._then);

  final UserListResponseModel _self;
  final $Res Function(UserListResponseModel) _then;

/// Create a copy of UserListResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? totalPages = null,Object? data = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<UserModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserListResponseModel].
extension UserListResponseModelPatterns on UserListResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserListResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserListResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserListResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _UserListResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserListResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserListResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page, @JsonKey(name: 'total_pages')  int totalPages,  List<UserModel> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserListResponseModel() when $default != null:
return $default(_that.page,_that.totalPages,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page, @JsonKey(name: 'total_pages')  int totalPages,  List<UserModel> data)  $default,) {final _that = this;
switch (_that) {
case _UserListResponseModel():
return $default(_that.page,_that.totalPages,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page, @JsonKey(name: 'total_pages')  int totalPages,  List<UserModel> data)?  $default,) {final _that = this;
switch (_that) {
case _UserListResponseModel() when $default != null:
return $default(_that.page,_that.totalPages,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserListResponseModel implements UserListResponseModel {
  const _UserListResponseModel({required this.page, @JsonKey(name: 'total_pages') required this.totalPages, required final  List<UserModel> data}): _data = data;
  factory _UserListResponseModel.fromJson(Map<String, dynamic> json) => _$UserListResponseModelFromJson(json);

@override final  int page;
@override@JsonKey(name: 'total_pages') final  int totalPages;
 final  List<UserModel> _data;
@override List<UserModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of UserListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserListResponseModelCopyWith<_UserListResponseModel> get copyWith => __$UserListResponseModelCopyWithImpl<_UserListResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserListResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserListResponseModel&&(identical(other.page, page) || other.page == page)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,totalPages,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'UserListResponseModel(page: $page, totalPages: $totalPages, data: $data)';
}


}

/// @nodoc
abstract mixin class _$UserListResponseModelCopyWith<$Res> implements $UserListResponseModelCopyWith<$Res> {
  factory _$UserListResponseModelCopyWith(_UserListResponseModel value, $Res Function(_UserListResponseModel) _then) = __$UserListResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int page,@JsonKey(name: 'total_pages') int totalPages, List<UserModel> data
});




}
/// @nodoc
class __$UserListResponseModelCopyWithImpl<$Res>
    implements _$UserListResponseModelCopyWith<$Res> {
  __$UserListResponseModelCopyWithImpl(this._self, this._then);

  final _UserListResponseModel _self;
  final $Res Function(_UserListResponseModel) _then;

/// Create a copy of UserListResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? totalPages = null,Object? data = null,}) {
  return _then(_UserListResponseModel(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<UserModel>,
  ));
}


}

// dart format on
