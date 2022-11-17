import 'dart:developer';

import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/event_source.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/receipts_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/models/user_model.dart';
import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/providers/base/base_provider.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/providers/pdf/recipt/simple_pdf.dart';
import 'package:al_baseet/src/providers/pdf/simple_pdf.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
import 'package:al_baseet/src/services/networks/receipts_repo.dart';
import 'package:al_baseet/src/services/serials_no.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptsProvider extends BaseProvider<ReceiptsModel> {
  ReceiptsRepo repo = ReceiptsRepo();
  bool updateLoading = false,
      approveLoading = false,
      printLoading = false,
      deleteLoading = false;
  ReceiptsProvider() {
    setEvent(EventSource(loading: true, data: []));
  }
  Future getReceipts({bool isRefresh = false}) async {
    print("in ...............");
    setEvent(EventSource(loading: true, refresh: isRefresh, data: event.data));

    ResponseModel response =
        await repo.getReceipts(callBack: () => getReceipts());
    if (response.status) {
      setEvent(EventSource(
          loading: false, data: ReceiptsModel.toListOfModel(response.data)));
      // loading: false, data: InvoiceModel.toListOfModel(response.data)));
      return;
    }
    setEvent(EventSource(loading: false, data: event.data));
  }

  Future createReceipt({@required List<InvoiceModel> invoices}) async {
    log("home ..");

    int index = invoices.indexWhere((element) => element.editAmount == 0);
    // print(index!=-1);

    if (index != -1) {
      CustomToast.showToastInfo(S.current.valid_receipts_message);
      return;
    }
    // return;
    setLoading(true);
    ResponseModel response = await repo.createReceipt(
        invoices: invoices, callBack: () => createReceipt(invoices: invoices));
    setLoading(false);

    if (response.status && response.errorCode == 200) {
      await Serials.saveLastSerial(type: "055");
      InvoicesProvider _provider =
          navigatorKey.currentContext.read<InvoicesProvider>();
      _provider.clear();

      CustomToast.showToastInfo(response.message);
      print("**************************************+++---+++");
      print(response.data);
      print("**************************************+++---+++");
      event.data.insert(0, ReceiptsModel.fromJson(response.data));
      notifyListeners();
      //todo add created recipte to the old array
      Navigator.pop(navigatorKey.currentContext);
      Navigator.pop(navigatorKey.currentContext);
    }
  }

  Future deleteInvoice({@required ReceiptsModel receipt}) async {
    print(receipt.id);
    deleteLoading = true;
    notifyListeners();
    ResponseModel response = await repo.deleteInvoice(
        receipt: receipt, callBack: () => deleteInvoice(receipt: receipt));
    deleteLoading = false;
    notifyListeners();

    if (response.status && response.errorCode == 200) {
      CustomToast.showToastInfo(response.message);
      Navigator.pop(navigatorKey.currentContext);
      print("**************************************+++---+++");
      print(response.data);
      // event.data.rem(0, InvoiceModel.fromJson(response.data));
      event.data.removeWhere((element) => element.id == receipt.id);
      notifyListeners();
      notifyListeners();
      print("**************************************+++---+++");
      // Navigator.pop(navigatorKey.currentContext);
    }
  }

  Future approveReceipts({@required ReceiptsModel receipt}) async {
    approveLoading = true;
    notifyListeners();

    ResponseModel response = await repo.approveInvoice(
      receipt: receipt,
      callBack: () => approveReceipts(receipt: receipt),
    );
    approveLoading = false;
    notifyListeners();

    if (response.status && response.errorCode == 200) {
      int index = event.data.indexWhere((element) => element.id == receipt.id);
      event.data[index].approvalState = true;
      CustomToast.showToastInfo(response.message);
    }
  }

  Future printReceipts(
      {@required ReceiptsModel receiptsModel,
      bool isSimpleTaxInvoice = true}) async {
    printLoading = true;
    notifyListeners();
    UserModel user = navigatorKey.currentContext.read<AuthProvider>().userModel;
    // await Future.delayed(Duration(seconds: 2));
    // print("muller ${invoice.qrData}");

    // CreateEnglishPdf pdf = CreateEnglishPdf(invoice: invoice);
    CreateReciptSimplePdf pdfAR =
        CreateReciptSimplePdf(recipt: receiptsModel, user: user);

    try {
      await pdfAR.createPDF();
    } catch (e) {
      CustomToast.showToast("حدثت مشكلة حاول لاحقا");
      print(e);
    }

    printLoading = false;
    notifyListeners();
  }
}
