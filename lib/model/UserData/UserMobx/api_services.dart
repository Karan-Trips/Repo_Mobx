import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../userModel/user_model.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: "https://reqres.in/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<HttpResponse<UserData>> fetchUsers();

  @POST("/register")
  Future<HttpResponse<Datum>> createUser(@Body() UserSave user);

  @POST("/login")
  Future<HttpResponse<Datum>> loginUser(@Body() UserSave user);

  @PUT("/users/{id}")
  Future<HttpResponse<Datum>> updateUser(@Path("id") int id, @Body() SaveJob user);

  @DELETE("/users/{id}")
  Future<HttpResponse<void>> deleteUser(@Path("id") int id);
}
