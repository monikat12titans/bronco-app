import 'dart:io';

import 'package:bronco_trucking/di/api/api_client.dart';
import 'package:bronco_trucking/ui/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/ui/common/app_exception.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'base_api_provider.dart' hide ProtectedBase;

class APIMethodProvider extends BaseAPIProvider {
  @protected
  Future<Response<T>> postMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    if (await AppComponentBase.instance.networkManage.isConnected()) {
      try {
        final Response<T> response = await post(ApiClient.baseUrl + url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        logger(response, body);
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @protected
  Future<Response<T>> getMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    if (await AppComponentBase.instance.networkManage.isConnected()) {
      try {
        final Response<T> response = await get(ApiClient.baseUrl + url,
            contentType: contentType, decoder: decoder, query: query);
        logger(response, '');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @protected
  Future<Response<T>> putMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    debugPrint('url: $url\nrequest: $body');
    if (await AppComponentBase.instance.networkManage.isConnected()) {
      try {
        final Response<T> response = await put(ApiClient.baseUrl + url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        logger(response, body);
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @protected
  Future<Response<T>> patchMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    debugPrint('url: $url\nrequest: $body');
    if (await AppComponentBase.instance.networkManage.isConnected()) {
      try {
        final Response<T> response = await patch(ApiClient.baseUrl + url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @protected
  Future<Response<T>> requestMethod<T>(String url, String method,
      {dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    debugPrint('url: $url\nrequest: $body');
    if (await AppComponentBase.instance.networkManage.isConnected()) {
      try {
        final Response<T> response = await request(url, method,
            body: body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @protected
  Future<Response<T>> deleteMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    debugPrint('url: $url');
    if (await AppComponentBase.instance.networkManage.isConnected()) {
      try {
        final Response<T> response = await delete(ApiClient.baseUrl + url,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query);
        logger(response, '');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }
}
