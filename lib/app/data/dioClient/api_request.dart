import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salon_app/app/ui/constants/ApiConstants.dart';

class ApiRequest {
  final String url;
  Map data = {};

  ApiRequest({
    @required this.url,
    this.data,
  });

  Dio _dio() {
    // Put your authorization token here
    return Dio(
        // BaseOptions(
        //   headers: {
        //     'Authorization': 'B ....',
        //   },
        // ),
        );
  }

  void get({
    Function() beforeSend,
    Function(dynamic data) onSuccess,
    Map requestData,
    Function(dynamic error) onError,
  }) {
    _dio().get(ApiConstants.baseURL, queryParameters: requestData).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  void post({
    Function() beforeSend,
    Function(dynamic data) onSuccess,
    Function(dynamic error) onError,
  }) {
    _dio().post(this.url, queryParameters: this.data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}
