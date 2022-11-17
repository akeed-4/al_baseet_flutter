import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/values/global_context.dart';

import 'name_model.dart';

class InvoiceProductModel {
  ProductModel product;
  int quantity = 0;
  int editQuantity = 1;
  double price = 0;
  double editPrice = 1;
  InvoiceProductModel({
    this.product,
    this.price = 0,
    this.quantity = 0,
    this.editQuantity = 1,
    this.editPrice = 1,
  });
  factory InvoiceProductModel.fromJson(Map<String, dynamic> json) =>
      InvoiceProductModel(
        product: ProductModel.fromJson(json["product_data"] ?? {}),
        price: json["price"] ?? 0.0,
        quantity: json["quantity"]?.toInt() ?? 0,
        editQuantity: json["quantity"]?.toInt() ?? 0,
        editPrice: json["price"] ?? 0.0,
      );
  Map<String, dynamic> toJson() => {
        "price": price,
        "quantity": quantity,
      };
  // String get name => customerName.en;

  static double getTotalAmount(List<InvoiceProductModel> data) {
    double total = 0;
    data.forEach((element) {
      total += element.editPrice * element.editQuantity;
    });
    return total;
  }

  static List<InvoiceProductModel> toListOfModel(List<dynamic> data) {
    // return data.map((data) => ProductModel.fromJson({"product_data":data})).toList();
    return data.map((data) => InvoiceProductModel.fromJson(data)).toList();
  }

  static List<dynamic> toListOfJson(List<InvoiceProductModel> data) {
    return data.map((data) => (data.toJson())).toList();
  }

  void copy(InvoiceProductModel productToCopy) {
    product = productToCopy.product;
    quantity = productToCopy.quantity;
    editQuantity = productToCopy.editQuantity;
    price = productToCopy.price;
    editPrice = productToCopy.editPrice;
  }
}
