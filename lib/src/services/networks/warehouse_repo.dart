import 'dart:convert';

import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/utils/http/http_helper.dart';
import 'package:flutter/cupertino.dart';

class ProductRepo {
  Future<ResponseModel> getWarehouseProducts({Function() callBack, String isAllProducts = ""}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/product/get_warehouse_products/$isAllProducts",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }

  Future<ResponseModel> getReceiveStatements({Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/product/get_product_receive_statement",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }

  Future<ResponseModel> getHistory({Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/product/get_product_history",
        isAuth: true,
        // bodyData: '{"product_id": "A1"}',
        callBack: callBack,
      ),
    );
  }

  Future<ResponseModel> getReports(
      {Function() callBack, DateTime start, DateTime end}) async {
    var _dateRange = jsonEncode({
      "from_date": "${start ?? DateTime.now()}",
      "to_date": "${end ?? DateTime.now().subtract(Duration(days: 7))}"
      // "to_date": end ??
      //     (DateTime(DateTime.now().year, DateTime.now().month,
      //         DateTime.now().day - 7)),//date befor
    });
    print(_dateRange);
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/reports/get_transaction",
        isAuth: true,
        methodType: MethodType.post,
        callBack: callBack,
        bodyData: _dateRange,
      ),
    );
  }

  Future<ResponseModel> returnStatement({
    Function() callBack,
    @required List<dynamic> products,
  }) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        methodType: MethodType.post,
        bodyData: products,
        url: "/product/product_return_statement",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }

  Future<ResponseModel> acceptance(
      {@required statementId,
      Function() callBack,
      bool isAccept = true}) async {
    print("is accept $isAccept  $statementId");
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        methodType: MethodType.post,
        bodyData: {
          // "invoice_id": 654897489,
          "id": statementId,
          "invoice_acceptance": isAccept ? 1 : 0
        },
        url: isAccept
            ? "/product/accept_product_receive_statement"
            : "/product/cancel_product_receive_statement",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }
}
