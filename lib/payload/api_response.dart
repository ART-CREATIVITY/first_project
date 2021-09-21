import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';


@JsonSerializable()
class ApiResponse {
  bool? success;
  dynamic message;


  ApiResponse({this.success, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}