import 'package:flutter/material.dart';

class RequestModel {
  String url;
  MethodType methodType;
  dynamic bodyData;
  bool isDefaultServerUrl;
  bool isAuth;
  bool withToken;
  Function() callBack;
  RequestModel({
    @required this.url,
    this.methodType = MethodType.get,
    this.bodyData,
    this.isAuth = false,
    this.isDefaultServerUrl = true,
    this.withToken = false,
    this.callBack,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        url: json["url"] ?? "default url",
      );
}

enum MethodType { get, post, put, delete }
