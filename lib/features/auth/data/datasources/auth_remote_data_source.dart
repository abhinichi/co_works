import 'package:dio/dio.dart';
import 'package:co_works/core/constants/api_endpoints.dart';
import 'package:co_works/features/auth/data/models/auth_response_model.dart';
import 'package:co_works/features/auth/data/models/login_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_data_source.g.dart';

/// Remote data source for authentication, implemented with **Retrofit**.
///
/// Retrofit generates the boilerplate Dio calls from these annotations. A
/// remote data source only knows how to talk to the network and return DTOs;
/// it performs no error mapping (that happens in the repository).
@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST(ApiEndpoints.login)
  Future<AuthResponseModel> login(@Body() LoginRequestModel body);
}
