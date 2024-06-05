import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/userModel/user_model.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: "https://reqres.in/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<HttpResponse<UserData>> fetchUsers();

  @POST("/register")
  Future<HttpResponse<dynamic>> createUser(@Body() UserSave user);

  @POST("/login")
  Future<HttpResponse<dynamic>> loginUser(@Body() Map<String, dynamic> user);

  @PUT("/users/")
  Future<HttpResponse<dynamic>> updateUser(
      @Path("id") int id, @Body() Map<String, dynamic> user);

  @DELETE("/users/")
  Future<HttpResponse<void>> deleteUser(@Path("id") int id);
}
