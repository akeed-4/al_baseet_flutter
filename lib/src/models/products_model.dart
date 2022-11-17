import 'package:al_baseet/src/values/global_context.dart';

import 'name_model.dart';

class ProductModel {
  String id;
  NameModel name;
  String image;
  int quantity;
  // int editQuantity;
  double price;
  String description;

  // {
  // "product_id": "A1",
  // "product_name": {
  // "ar": "بيبسي",
  // "en": "Pepsi"
  // },
  // "product_image": null,
  // "product_description": null,
  // "available_quantity": -4.0,
  // "price": 100.0
  // },
  ProductModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.image,
    this.description,
    // this.editQuantity = 1,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["product_id"] ?? "00",
        name: NameModel.fromJson(json["product_name"]),
        price: json["price"] ?? 0.0,
        quantity: json["available_quantity"]?.toInt() ?? 0,
        image: json["product_image"] ??
            randomImage(
              index: json["price"].round(),
            ),
        description: json["product_description"] ?? "التفاصيل غير مدرجة",
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
  // String get name => customerName.en;

  // static double getTotalAmount(List<ProductModel> data) {
  //   double total = 0;
  //   data.forEach((element) {
  //     total += element.price * element.editQuantity;
  //   });
  //   return total;
  // }

  static List<ProductModel> toListOfModel(List<dynamic> data) {
    // return data.map((data) => ProductModel.fromJson({"product_data":data})).toList();
    return data.map((data) => ProductModel.fromJson(data)).toList();
  }

  static List<dynamic> toListOfJson(List<ProductModel> data) {
    return data.map((data) => (data.toJson())).toList();
  }
}
