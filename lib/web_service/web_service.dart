
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:first_project/web_service/taxpayer_web_service.dart';
import 'package:http/http.dart' as http;

import 'package:first_project/entities/taxpayer.dart';
import './rest_api_url.dart';

class WebService {
  // http.Client _httpClient = http.Client();
  static var dio = Dio();
  static TaxpayerWebService? _taxpayerWebService;

  static getTaxpayerWebService(){
    if(_taxpayerWebService==null){
      _taxpayerWebService = TaxpayerWebService(dio);
    }

    return _taxpayerWebService;
  }

  // Future<Taxpayer?> createTaxpayer(Taxpayer taxpayer) async {
  //   try {
  //     var uriResponse = await _httpClient.post(Uri.parse(RestApiUrl.TAXPAYER),
  //     body: jsonEncode(taxpayer.toRestJson()), headers: {"Content-Type": "application/json"});
  //     if(uriResponse.statusCode==200) {
  //       return Taxpayer.fromJson(jsonDecode(uriResponse.body));
  //     }
  //   } finally {
  //
  //   }
  //
  //   return null;
  // }

  Future<Taxpayer?> createTaxpayer(Taxpayer taxpayer) async {
    try {
      var response = await dio.post(RestApiUrl.TAXPAYER, data: taxpayer.toRestJson());
      if(response.statusCode==200) {
        return Taxpayer.fromJson(response.data as Map<String, dynamic>);
      }
    } finally {

    }

    return null;
  }

  Future<List<Taxpayer?>?> getAll() async {
    var response = await dio.get(RestApiUrl.TAXPAYER);
    var mapList = response.data as List<dynamic>;
    return List.generate(mapList.length,
            (index) => Taxpayer.fromJson(mapList[index] as Map<String, dynamic>));
  }
}