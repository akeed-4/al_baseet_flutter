import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/services/serials_no.dart';
import 'package:al_baseet/src/utils/http/http_helper.dart';
import 'package:flutter/cupertino.dart';

class InvoiceRepo {
  Future<ResponseModel> getInvoices({Function() callBack,String invoiceType=""}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/invoices/get_invoices/$invoiceType",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }

  Future<ResponseModel> createInvoice(
      {@required InvoiceModel invoice, Function() callBack}) async {
    double invoiceNo = await Serials.getLastSerial(type: invoice.type.key);

    Map<String, dynamic> _data = {
      "id": invoice.id,
      "invoice_type": invoice.type.key,
      "invoice_no": invoice.invoiceNo,
      "customer_id": invoice.customer == null ? null : invoice.customer.id,
      "customer_name": invoice.customer_name,
      "customer_tax_id": invoice.customer_tax_id,
      "invoice_date": DateTime.now().toUtc().toString(),
      // "invoice_date": DateTime.now().toUtc(),
      "products": invoice.products
          .map(
            (e) => {
              "product_id": e.product.id,
              "quantity": e.editQuantity,
              "price": e.editPrice
            },
          )
          .toList()
    };

    print(_data);
    print("--------------------------------");
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/invoices/create",
        bodyData: _data,
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }

  Future<ResponseModel> updateInvoice(
      {@required InvoiceModel invoice,
      bool isReturn = false,
      Function() callBack}) async {
    double invoiceNo = await Serials.getLastSerial(type: invoice.type.key);
    // if(isReturn)
    Map<String, dynamic> _data = {
      "id": isReturn ? invoiceNo : invoice.id,
      "invoice_type": invoice.type.key,
      "invoice_no": invoice.invoiceNo,
      "customer_id": invoice.customer.id,
      "customer_name": invoice.customer_name,
      "customer_tax_id": invoice.customer_tax_id,
      "invoice_date": DateTime.now().toUtc().toString(),
      // "invoice_date": DateTime.now().toUtc(),
      "products": invoice.products
          .map(
            (e) => {
              "product_id": e.product.id,
              "quantity": e.editQuantity,
              "price": e.editPrice
            },
          )
          .toList()
    };
    print(_data);
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/invoices/update",
        bodyData: _data,
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }

  Future<ResponseModel> deleteInvoice(
      {@required InvoiceModel invoice, Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/invoices/delete",
        bodyData: {"id": invoice.id},
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }

  Future<ResponseModel> approveInvoice(
      {@required InvoiceModel invoice, Function() callBack}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/invoices/approve",
        bodyData: {"id": invoice.id},
        isAuth: true,
        callBack: callBack,
        methodType: MethodType.post,
      ),
    );
  }
}
