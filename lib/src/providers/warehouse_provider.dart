import 'dart:developer';
import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/event_source.dart';
import 'package:al_baseet/src/models/history_model.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/models/recive_statment_model.dart';
import 'package:al_baseet/src/models/report_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/providers/base/base_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
import 'package:al_baseet/src/services/fakeData/fake_data.dart';
import 'package:al_baseet/src/services/networks/warehouse_repo.dart';
import 'package:flutter/material.dart';

class WarehouseProvider extends BaseProvider<ProductModel> {
  ProductRepo repo = ProductRepo();
  // List<ReceiveStatementModel> receiveStatements = [];
  // bool receiveStatementsLoading = false;
  EventSource<ReceiveStatementModel> receiveEvent = EventSource(data: []);
  EventSource<HistoryModel> historyEvent = EventSource(data: []);

  EventSource<ProductModel> returnEvent = EventSource(data: []);
  List<InvoiceProductModel> selectedProducts = [];
  List<ProductModel> filteredProducts = [];

  ReportModel report = ReportModel(transactions: [], totals: []);
  bool reportLoading = false;
  WarehouseProvider() {
    setEvent(EventSource(loading: true, data: []));
  }
  Future getWarehouseProducts({bool isRefresh = false, String isAllProducts = ""}) async {
    setEvent(EventSource(loading: true, refresh: isRefresh, data: event.data));
    // await Future.delayed(Duration(seconds: 2));
    ResponseModel response = await repo.getWarehouseProducts(
        callBack: () => getWarehouseProducts(isRefresh: isRefresh, isAllProducts : isAllProducts),
        isAllProducts : isAllProducts);
    if (response.status) {
      setEvent(EventSource(
          // loading: false,
          // data: ProductModel.toListOfModel(FakeData.products['data'])));
          loading: false,
          data: ProductModel.toListOfModel(response.data)));
      filteredProducts = event.data;
      notifyListeners();
      // returnEvent =
      //     EventSource(data: ProductModel.toListOfModel(response.data));
      return;
    }
    setEvent(EventSource(loading: false, data: event.data));
  }

//search in proudcts
  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll dplay all users
      filteredProducts = event.data;
    } else {
      filteredProducts = event.data
          .where((product) =>
              product.name.en
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              product.name.ar
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              product.id.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    notifyListeners();
  }

  Future getReceiveStatements({bool isRefresh = false}) async {
    receiveEvent =
        EventSource(loading: true, refresh: isRefresh, data: receiveEvent.data);
    notifyListeners();
    // await Future.delayed(Duration(seconds: 5));
    ResponseModel response = await repo.getReceiveStatements(
        callBack: () => getReceiveStatements(isRefresh: isRefresh));
    receiveEvent = EventSource(
        loading: false,
        data: ReceiveStatementModel.toListOfModel(response.data));
    notifyListeners();
  }

  Future getReports({bool isRefresh = false}) async {
    if (!isRefresh) {
      reportLoading = true;
      notifyListeners();
    }
    // await Future.delayed(Duration(seconds: 2));
    ResponseModel response =
        await repo.getReports(callBack: () => getReports(isRefresh: isRefresh));
    if (!isRefresh) {
      reportLoading = false;
      notifyListeners();
    }

    if (response.status) {
      report = ReportModel.fromJson(response.data);
    }
  }

  Future getHistory({bool isRefresh = false}) async {
    historyEvent =
        EventSource(loading: true, refresh: isRefresh, data: historyEvent.data);
    notifyListeners();
    // await Future.delayed(Duration(seconds: 2));
    ResponseModel response =
        await repo.getHistory(callBack: () => getHistory(isRefresh: isRefresh));

    historyEvent = EventSource(
        // loading: false,
        // data: HistoryModel.toListOfModel(FakeData.historyData['data']));
        loading: false,
        data: HistoryModel.toListOfModel(response.data));
    notifyListeners();
  }

  Future acceptance(int index, {bool accept = true}) async {
    setLoading(true);
    accept
        ? receiveEvent.data[index].isAcceptLoading = true
        : receiveEvent.data[index].isCanceledLoading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 10));
    ResponseModel response = await repo.acceptance(
        statementId: receiveEvent.data[index].id,
        isAccept: accept,
        callBack: () => acceptance(index, accept: accept));
    setLoading(false);
    accept
        ? receiveEvent.data[index].isAcceptLoading = false
        : receiveEvent.data[index].isCanceledLoading = false;
    notifyListeners();

    if (response.status) {
      getWarehouseProducts(isRefresh: true);
      receiveEvent.data[index].status =
          accept ? ReceiveStatement.accepted : ReceiveStatement.canceled;
      // loading: false, data: InvoiceModel.toListOfModel(response.data)));
    }
  }

  Future returnProducts() async {
    returnEvent = EventSource(loading: true, data: returnEvent.data);
    notifyListeners();
    // log(ProductModel.toListOfJson(returnEvent.data).toString());
    // print(ProductModel.toListOfJson(r));

    List<Map<String, dynamic>> _products = [];
    selectedProducts.forEach((element) {
      _products.add(
          {"product_id": element.product.id, "quantity": element.editQuantity});
    });
    log(_products.toString());
    // await Future.delayed(Duration(seconds: 3));

    ResponseModel response = await repo.returnStatement(
      products: _products,
      callBack: () => returnProducts(),
    );
    returnEvent = EventSource(loading: false, data: returnEvent.data);
    notifyListeners();

    if (response.status) {
      getWarehouseProducts(isRefresh: true);
      selectedProducts.clear();
      CustomToast.showToastInfo(S.current.return_success);
    }
  }

  void increaseReturnItem(int index, {bool isRerunInvoice = false}) {
    if (isRerunInvoice) {
      if (selectedProducts[index].editQuantity ==
          selectedProducts[index].quantity) return;
    }
    if (selectedProducts[index].editQuantity ==
        selectedProducts[index].product.quantity) return;
    selectedProducts[index].editQuantity++;
    notifyListeners();
  }

  void decreaseReturnItem(int index) {
    if (selectedProducts[index].editQuantity == 1) return;
    selectedProducts[index].editQuantity--;
    notifyListeners();
  }

  void editProductQuantity(
      {@required InvoiceProductModel product, @required int newQuantity}) {
    int index = selectedProducts
        .indexWhere((element) => element.product.id == product.product.id);

    if (newQuantity > selectedProducts[index].product.quantity ||
        newQuantity < 1) return;

    selectedProducts[index].editQuantity = newQuantity;
    notifyListeners();
  }
  void editProductPrice(
      {@required InvoiceProductModel product, @required double newPrice}) {
    int index = selectedProducts
        .indexWhere((element) => element.product.id == product.product.id);

    if (newPrice < 1) return;

    selectedProducts[index].editPrice = newPrice;
    notifyListeners();
  }
  bool isChecked(ProductModel product) {
    int index = selectedProducts
        .indexWhere((element) => element.product.id == product.id);
    return index == -1 ? false : true;
  }

  void onSelect(ProductModel product) {
    int index = selectedProducts
        .indexWhere((element) => element.product.id == product.id);

    log("$index");
    // InvoiceProductModel _invoProduct=InvoiceProductModel(pr)

    index == -1
        ? selectedProducts.add(InvoiceProductModel(
            product: product, quantity: product.quantity, price: product.price, editPrice: product.price))
        : removeItem(product);
    notifyListeners();
  }

  void removeItem(ProductModel product) {
    selectedProducts.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void setSelectedProducts(List<InvoiceProductModel> products) {
    print("home .... ${products.length}");
    // selectedProducts.clear();
    // clear();
    print("in replacing .....");
    // InvoiceProductModel proDemo = InvoiceProductModel();
    List<InvoiceProductModel> demo = [];
    products.forEach((element) {
      InvoiceProductModel proDemo = InvoiceProductModel();
      demo.add(proDemo..copy(element));
    });

    selectedProducts = List.from(demo);
    demo.clear();
    notifyListeners();
  }

  void clear() {
    selectedProducts.clear();
    // selectedProducts = [];
    notifyListeners();
  }
}
