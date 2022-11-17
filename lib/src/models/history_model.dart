import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/invoice_type.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/values/global_context.dart';

class HistoryModel {
  InvoiceProductModel product;
  InvoiceModel invoice;
  double quantity;

  HistoryModel({this.product, this.invoice, this.quantity = 0});
  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        product: InvoiceProductModel.fromJson(
            {"product_data": json["product_data"]}),
        invoice: InvoiceModel.fromJson(json["invoice"]),
        quantity: json['quantity'],
      );

  static List<HistoryModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => HistoryModel.fromJson(data)).toList();
  }

  String get getQuantity => isPlus ? "+ $quantity" : "- ${quantity.abs()}";
  bool get isPlus => quantity > 0;
  // !(invoice.type == InvoiceType.cash || invoice.type == InvoiceType.credit);

  // static List<dynamic> toListOfJson(List<HistoryModel> data) {
  //   return data.map((data) => (data.toJson())).toList();
  // }
}
