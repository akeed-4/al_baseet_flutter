import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';

class ReceiveStatementModel {
  int id;
  List<InvoiceProductModel> products;
  ReceiveStatement status;
  bool isAcceptLoading = false;
  bool isCanceledLoading = false;

  ReceiveStatementModel(
      {this.id,
      this.products,
      this.status = ReceiveStatement.non,
      this.isAcceptLoading = false,
      this.isCanceledLoading = false});
  factory ReceiveStatementModel.fromJson(Map<String, dynamic> json) =>
      ReceiveStatementModel(
          id: json["id"] ?? 00,
          products: InvoiceProductModel.toListOfModel(json["products"] ?? []));

  bool get isNon => status == ReceiveStatement.non;
  bool get isAccepted => status == ReceiveStatement.accepted;
  bool get isCanceled => status == ReceiveStatement.canceled;
  static List<ReceiveStatementModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => ReceiveStatementModel.fromJson(data)).toList();
  }
}

enum ReceiveStatement {
  canceled,
  accepted,
  non,
}
