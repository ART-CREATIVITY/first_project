import 'package:first_project/web_service/rest_api_url.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: RestApiUrl.SERVER_URL)
abstract class RestClient {

  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
}