// import 'dart:convert';
import 'dart:developer';
// import 'dart:io';

import 'package:al_baseet/generated/l10n.dart';
// import 'package:al_baseet/src/models/company_model.dart';
import 'package:al_baseet/src/models/event_source.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/models/user_model.dart';
import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/providers/base/base_provider.dart';
import 'package:al_baseet/src/providers/pdf/request_products/request_products_pdf.dart';
import 'package:al_baseet/src/providers/pdf/simple_pdf.dart';
import 'package:al_baseet/src/providers/pdf/tax_pdf.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
// import 'package:al_baseet/src/services/fakeData/fake_data.dart';

import 'package:al_baseet/src/services/networks/invoice_repo.dart';
import 'package:al_baseet/src/services/serials_no.dart';
// import 'package:al_baseet/src/utils/storage/storage_helper.dart';
// import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';

// import 'common/language_provider.dart';
// import 'pdf/details_pdf.dart';

class InvoicesProvider extends BaseProvider<InvoiceModel> {
  InvoiceRepo repo = InvoiceRepo();
  List<InvoiceModel> selectedInvoices = [];
  bool updateLoading = false,
      approveLoading = false,
      printLoading = false,
      deleteLoading = false;
  InvoicesProvider() {
    setEvent(EventSource(loading: true, data: []));
  }
  Future getInvoices({bool isRefresh = false, String invoiceType = "" }) async {
    setEvent(EventSource(loading: true, refresh: isRefresh, data: event.data));
    // await Future.delayed(Duration(seconds: 2));
    // setEvent(EventSource(
    //     loading: false,
    //     data: InvoiceModel.toListOfModel(FakeData.invoices['data'].toList())));
    ResponseModel response =
        await repo.getInvoices(callBack: () => getInvoices(invoiceType: invoiceType),
            invoiceType: invoiceType);
    if (response.status) {
      setEvent(EventSource(
          loading: false, data: InvoiceModel.toListOfModel(response.data)));
      // loading: false, data: InvoiceModel.toListOfModel(response.data)));
      // loading: false, data: InvoiceModel.toListOfModel(response.data)));

      print("total length ${event.data.length}");
      return;
    }
    setEvent(EventSource(loading: false, data: event.data));
  }

  Future createInvoice({@required InvoiceModel invoice}) async {
    //validation
    // print(invoice.products.length);
    if (invoice.customer == null /*&& invoice.type.isCredit*/) {
      CustomToast.showToastInfo(S.current.please_select_customer);
      return;
    }
    if (invoice.products.isEmpty) {
      CustomToast.showToastInfo(S.current.please_select_products);
      return;
    }
    // return;
    //..
    setLoading(true);
    ResponseModel response = await repo.createInvoice(
        invoice: invoice, callBack: () => createInvoice(invoice: invoice));
    setLoading(false);

    if (response.status && response.errorCode == 200) {
      await Serials.saveLastSerial(type: invoice.type.key);
      CustomToast.showToastInfo(response.message);
      print("**************************************+++---+++");
      print(response.data);

      print("**************************************+++---+++");
      event.data.insert(0, InvoiceModel.fromJson(response.data));
      notifyListeners();
      Navigator.pop(navigatorKey.currentContext);
    }
  }

  Future updateInvoice(
      {@required InvoiceModel invoice, bool isReturn = false}) async {
    //validation
    if (invoice.customer == null) {
      CustomToast.showToastInfo("please select customer");
      return;
    }
    if (invoice.products.isEmpty) {
      CustomToast.showToastInfo("please select Products");
      return;
    }
    //..
    print(isReturn);
    print(invoice.type.key);
    //
    // if (isReturn) {
    //   createInvoice(invoice: invoice);
    //   return;
    // }
    //
    // return;

    updateLoading = true;
    notifyListeners();
    ResponseModel response = await repo.updateInvoice(
        invoice: invoice, callBack: () => updateInvoice(invoice: invoice));
    updateLoading = false;
    notifyListeners();

    if (response.status && response.errorCode == 200) {
      CustomToast.showToastInfo(response.message);
      print("9999999999999999999999999");
      print(response.data);
      print("9999999999999999999999999");

      int index = event.data.indexWhere((element) => element.id == invoice.id);
      // event.data[index] = InvoiceModel.fromJson(response.data);
      if (isReturn) {
        print("dooom ............");
        event.data.insert(0, InvoiceModel.fromJson(response.data));
      } else {
        event.data[index] = InvoiceModel.fromJson(response.data);
      }

      Navigator.pop(navigatorKey.currentContext);
      Navigator.pop(navigatorKey.currentContext);
    }
  }

  Future deleteInvoice({@required InvoiceModel invoice}) async {
    print(invoice.id);
    deleteLoading = true;
    notifyListeners();
    ResponseModel response = await repo.deleteInvoice(
        invoice: invoice, callBack: () => deleteInvoice(invoice: invoice));
    deleteLoading = false;
    notifyListeners();

    if (response.status && response.errorCode == 200) {
      CustomToast.showToastInfo(response.message);
      Navigator.pop(navigatorKey.currentContext);
      print("**************************************+++---+++");
      print(response.data);
      // event.data.rem(0, InvoiceModel.fromJson(response.data));
      event.data.removeWhere((element) => element.id == invoice.id);
      notifyListeners();
      notifyListeners();
      print("**************************************+++---+++");
      // Navigator.pop(navigatorKey.currentContext);
    }
  }

  Future approveInvoice({@required invoice}) async {
    approveLoading = true;
    notifyListeners();

    ResponseModel response = await repo.approveInvoice(
      invoice: invoice,
      callBack: () => approveInvoice(invoice: invoice),
    );
    approveLoading = false;
    notifyListeners();

    if (response.status && response.errorCode == 200) {
      int index = event.data.indexWhere((element) => element.id == invoice.id);

      event.data[index].invoiceNo = InvoiceModel.fromJson(response.data).invoiceNo;
      // Navigator.pop(navigatorKey.currentContext);
      event.data[index].approvalState = true;
      CustomToast.showToastInfo(response.message);
    }
  }

  Future printInvoice(
      {@required InvoiceModel invoice, bool isSimpleTaxInvoice = true}) async {
    printLoading = true;
    notifyListeners();
    // UserModel user = navigatorKey.currentContext.read<AuthProvider>().userModel;
    // await Future.delayed(Duration(seconds: 2));
    print("muller ${invoice.qrData}");

    // CreateEnglishPdf pdf = CreateEnglishPdf(invoice: invoice);
    isSimpleTaxInvoice ? printSimpleInvoice(invoice: invoice) : printTaxInvoice(invoice: invoice);

    // try {
    //   await pdfAR.createPDF();
    // } catch (e) {
    //   CustomToast.showToast("حدثت مشكلة حاول لاحقا");
    //   print(e);
    // }

    printLoading = false;
    notifyListeners();
  }
  Future printRequestProducts(
      {@required InvoiceModel invoice}) async {
    printLoading = true;
    notifyListeners();
    // UserModel user = navigatorKey.currentContext.read<AuthProvider>().userModel;
    // await Future.delayed(Duration(seconds: 2));
    print("muller ${invoice.qrData}");

    // CreateEnglishPdf pdf = CreateEnglishPdf(invoice: invoice);
    UserModel user = navigatorKey.currentContext.read<AuthProvider>().userModel;
    CreateRequestProductsPdf pdfAR = CreateRequestProductsPdf(invoice: invoice, user: user);

    try {
      await pdfAR.createPDF();
    } catch (e) {
      CustomToast.showToast("حدثت مشكلة حاول لاحقا");
      print(e);
    }

    // try {
    //   await pdfAR.createPDF();
    // } catch (e) {
    //   CustomToast.showToast("حدثت مشكلة حاول لاحقا");
    //   print(e);
    // }

    printLoading = false;
    notifyListeners();
  }
void printSimpleInvoice(
    {@required InvoiceModel invoice}) async
{
  UserModel user = navigatorKey.currentContext.read<AuthProvider>().userModel;
  CreateSimplePdf pdfAR = CreateSimplePdf(invoice: invoice, user: user);

try {
    await pdfAR.createPDF();
  } catch (e) {
    CustomToast.showToast("حدثت مشكلة حاول لاحقا");
    print(e);
  }
}
  void printTaxInvoice(
      {@required InvoiceModel invoice}) async
  {
    UserModel user = navigatorKey.currentContext.read<AuthProvider>().userModel;
    CreateTaxPdf pdfAR = CreateTaxPdf(invoice: invoice, user: user);

    try {
      await pdfAR.createPDF();
    } catch (e) {
      CustomToast.showToast("حدثت مشكلة حاول لاحقا");
      print(e);
    }
  }
  void editInvoiceAmount(
      {@required InvoiceModel invoice, @required double newAmount}) {
    // print();
    int index =
        selectedInvoices.indexWhere((element) => element.id == invoice.id);
    if (newAmount > selectedInvoices[index].remainAmount || newAmount <= 0)
      return;
    print("$index  .......  $newAmount");
    selectedInvoices[index].editAmount = newAmount;
    notifyListeners();
  }

//invoice selection

  bool isChecked(InvoiceModel invoice) {
    int index =
        selectedInvoices.indexWhere((element) => element.id == invoice.id);
    return index == -1 ? false : true;
  }

  void onSelect(InvoiceModel invoice) {
    int index =
        selectedInvoices.indexWhere((element) => element.id == invoice.id);

    log("$index");
    index == -1 ? selectedInvoices.add(invoice) : removeItem(invoice);
    notifyListeners();
  }

  void removeItem(InvoiceModel invoice) {
    selectedInvoices.removeWhere((item) => item.id == invoice.id);
    notifyListeners();
  }

  void clear() {
    selectedInvoices.clear();
    notifyListeners();
  }

//
}
