import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/utils/http/http_helper.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  Future<ResponseModel> doLogin(
      {@required username,
      @required password,
      String lang = "en",
      Function() callBack}) async {
    print("lang is $lang");
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/login",
        methodType: MethodType.post,
        callBack: callBack,
        // isAuth: true,
        bodyData: {
          "user_name": username,
          "password": password,
        },
      ),
    );
  }

  Future<ResponseModel> doLogout({Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/logout",
        methodType: MethodType.get,
        callBack: callBack,
        isAuth: true,
      ),
    );
  }

  Future<ResponseModel> doReset() async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/reset",
        isAuth: true,
        methodType: MethodType.post,
        bodyData: {
          "oldPassword": "124",
          "newPassword": "123",
        },
      ),
    );
  }
}
