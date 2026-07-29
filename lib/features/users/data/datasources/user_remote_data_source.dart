import 'package:co_works/core/constants/api_endpoints.dart';
import 'package:co_works/features/users/data/models/user_list_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_remote_data_source.g.dart';

/// Retrofit remote data source for the users feature.
@RestApi()
abstract class UserRemoteDataSource {
  factory UserRemoteDataSource(Dio dio) = _UserRemoteDataSource;

  @GET(ApiEndpoints.users)
  Future<UserListResponseModel> getUsers(@Query('page') int page);
}
