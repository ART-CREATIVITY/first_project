import 'package:dio/dio.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:first_project/payload/api_response.dart';
import 'package:first_project/web_service/rest_api_url.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';

part 'taxpayer_web_service.g.dart';

@RestApi(baseUrl: RestApiUrl.SERVER_URL)
abstract class TaxpayerWebService {

  factory TaxpayerWebService(Dio dio, {String baseUrl}) = _TaxpayerWebService;
  
  @POST("/contribuable")
  Future<Taxpayer> createTaxpayer(@Body()Taxpayer taxpayer);
  @PUT("/contribuable/{id}")
  Future<Taxpayer> updateTaxpayer(@Path("id") String idTaxpayer, @Body() Taxpayer taxpayer);
  @GET("/contribuable/request/{requestNumber}/send")
  Future<ApiResponse> askIFU(@Path()String requestNumber);
  @GET("/contribuable/request/{requestNumber}")
  Future<Taxpayer> getByRequestNumber(@Path() String requestNumber);
  // StatusResponse checkStatus(String requestNumber);
  @GET("/contribuable")
  Future<List<Taxpayer>> getAll();
  
}