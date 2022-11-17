import 'dart:developer';

import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/receipts_model.dart';
import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/screens/Invoices/invoices.dart';
import 'package:al_baseet/src/services/serials_no.dart';
import 'package:al_baseet/src/utils/http/http_helper.dart';
import 'package:flutter/material.dart';

class ReceiptsRepo {
  Future<ResponseModel> getReceipts({Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/receipts/get_receipts",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }

  Future<ResponseModel> createReceipt(
      {@required List<InvoiceModel> invoices, Function() callBack}) async {
    double receiptNo = await Serials.getLastSerial(type: "055");
    var data = {
      "receipt_no": receiptNo,
      "receipt_date": DateTime.now().toUtc().toString(),
      "invoices": invoices
          .map((e) => {"invoice_id": e.id, "paid_amount": e.editAmount})
          .toList()
    };

    print("------------------22");
    print("------------------22");
    log(data.toString());
    print("------------------");
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        bodyData: data,
        url: "/receipts/create",
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }

  Future<ResponseModel> deleteInvoice(
      {@required ReceiptsModel receipt, Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/receipts/delete",
        bodyData: {"id": receipt.id},
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }

  Future<ResponseModel> approveInvoice(
      {@required ReceiptsModel receipt, Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/receipts/approve",
        bodyData: {"id": receipt.id},
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }
}
