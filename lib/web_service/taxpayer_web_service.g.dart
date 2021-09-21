// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxpayer_web_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TaxpayerWebService implements TaxpayerWebService {
  _TaxpayerWebService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.137.213:8080/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Taxpayer> createTaxpayer(taxpayer) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(taxpayer.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Taxpayer>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/contribuable',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Taxpayer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Taxpayer> updateTaxpayer(idTaxpayer, taxpayer) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(taxpayer.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Taxpayer>(
            Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/contribuable/$idTaxpayer',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Taxpayer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse> askIFU(requestNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(
                    _dio.options, '/contribuable/request/$requestNumber/send',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Taxpayer> getByRequestNumber(requestNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Taxpayer>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/contribuable/request/$requestNumber',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Taxpayer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Taxpayer>> getAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Taxpayer>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/contribuable',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Taxpayer.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
