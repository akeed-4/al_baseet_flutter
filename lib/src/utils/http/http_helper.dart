import 'dart:io';

import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class HttpHelper {
  static final String _serverIp = "http://app.eofficewebapp.com";

  static Dio _client = Dio(
    BaseOptions(
      // baseUrl: 'https://www.xx.com/api',
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ),
  );
  static Future<Dio> _getInstance(
      {bool isAuth, bool withCookie, bool withToken = false}) async {
    if (!isAuth) {
      _client.options.headers = {
        // "Content-Type": "application/form-data",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      return _client;
    }
    final storageToken = await StorageHelper.get(StorageKeys.token);

    // print("***********************************");
    // print(isAuth);
    // print(withToken);
    // print();
    var headers = {
      // "Content-Type": "application/form-data",
      'Content-type': 'application/json',
      'Accept': 'application/json',

      'Authorization': 'Bearer $storageToken'
    };
    if (withToken == true) headers = {...headers, 'Bearer': '$storageToken'};
    _client.options.headers = headers;

    return _client;
  }

  static Future<Response> httpRequest(RequestModel requestModel) async {
    final String url = requestModel.isDefaultServerUrl
        ? "$_serverIp${requestModel.url}"
        : requestModel.url;
    print(url);
    final instance = await _getInstance(
        isAuth: requestModel.isAuth, withToken: requestModel.withToken);
    switch (requestModel.methodType) {
      case MethodType.get:
        print("in get method ...");
        print("in get method ...");
        print(requestModel.bodyData);
        // return instance.get(url);
        return instance.request(url,

            // data: requestModel.bodyData,
            options: Options(method: "get", extra: {}));
      case MethodType.post:
        print("in post method ...");
        return instance.post(url, data: requestModel.bodyData);
      case MethodType.put:
        return instance.put(url, data: requestModel.bodyData);
      case MethodType.delete:
        return instance.delete(url, data: requestModel.bodyData);
    }
    print("continue to end .....");
    return instance.get(url);
  }

  static Future<ResponseModel> requestMaker(
      {@required RequestModel requestModel}) async {
    ResponseModel response = ResponseModel();
    Response apiResponse;
    try {
      apiResponse = await HttpHelper.httpRequest(requestModel);
      print(apiResponse.data);
      response = ResponseModel.fromJson(apiResponse.data);
    } catch (e) {
      // response.errorCode = apiResponse?.statusCode;
      print("${e.toString()}");
      response = ResponseModel(
        status: false,
        message: "Ops Something went wrong ..",
      );
      if (e is DioError) {
        print("is dio");
        response.message = e.message;
        response.errorCode = e.response?.statusCode;
        if (e.error is SocketException) {
          response.message = S.current.no_internet_connection_error;
        }
      }
    }

    print("******* ${response.errorCode}");
    // response.errorCode = apiResponse?.statusCode;
    _showMessageErrors(response, requestModel.callBack);
    return response;
  }

  static void _showMessageErrors(ResponseModel response, Function() callBack) {
    print("error method ...... ${response.status}   ${response.errorCode}");
    // return;
    // if (!response.status && response.errorCode != 100) {
    if (!response.status) {
      response.errorCode == 501 || response.errorCode == 401
          ? showCustomDialog(
              isDismissible: false,
              logo: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 80,
              ),
              title: S.current.problem,
              info: response.message,
              actions: AppBtn(
                text: S.current.logout,
                onPress: () {
                  Navigator.pop(navigatorKey.currentContext);
                  AuthProvider().doLogout();
                },
              ),
            )
          : showCustomDialog(
              title: S.current.problem,
              logo: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 80,
              ),
              info: response.message,
              actions: AppBtn(
                text: S.current.retry,
                onPress: () {
                  Navigator.pop(navigatorKey.currentContext);
                  if (callBack != null) callBack();
                  return;
                },
              ),
            );
    }
  }
}
