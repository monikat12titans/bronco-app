library base_api_provider;

import 'package:bronco_trucking/di/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

export 'package:get/get_connect/connect.dart' hide GetConnectInterface;

abstract class BaseAPIProvider extends GetConnect {
  final loggerO = Logger(printer: PrettyPrinter(printTime: true));

  @override
  void onInit() {
    super.onInit();
  }

  @protected
  Future<Response<T>> _postMethod<T>(String? url, dynamic body);

  void logger(dynamic response, dynamic body) {
    if (response != null) {
      loggerO.i(
          ' URL : ${response.request.url ?? ''} \n Header : ${response.request.headers} \n Request Body : $body \n Response : ${response.body}');
    }
  }
/*@
  Future<Response<T>> _getMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder});

  @protected
  Future<Response<T>> _putMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  @protected
  Future<Response<T>> _patchMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  @protected
  Future<Response<T>> _requestMethod<T>(String url, String method,
      {dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  @protected
  Future<Response<T>> _deleteMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder});*/
}

extension ProtectedBase on BaseAPIProvider {
  Future<Response<T>> postMethod<T>(String? url, dynamic body,
      {String contentType = ApiClient.contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) {
    return _postMethod(url, body);
  }
}
