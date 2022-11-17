import 'package:al_baseet/src/values/global_context.dart';

import 'name_model.dart';

class CustomerModel {
  int id;
  NameModel name;
  String address;
  String userImage;
  int invoices;
  double receipts;
  String taxid;
  String segal;
  String country;
  String city;
  String state;
  String postcode;
  String building;
  String street;
  String mobile;

  CustomerModel({
    this.id,
    this.name,
    this.address,
    this.invoices,
    this.receipts,
    this.userImage,
    this.taxid,
    this.segal,
    this.country,
    this.city,
    this.state,
    this.postcode,
    this.building,
    this.street,
    this.mobile
  });
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["customer_id"] ?? 00,
        name: NameModel.fromJson(json["customer_name"] ?? {}),
        address: json["customer_address"] ?? "العنوان",
        invoices: json["invoices_count"] ?? 00,
        receipts: json["receipts_amount"] ?? 00,
        // invoices: json["invoices"] ?? "00",
        // receipts: json["receipts"] ?? "00",
        userImage: json["customer_image"] ??
            randomImage(
              isUser: true,
              index: json["customer_id"],
            ),
        taxid: json["customer_taxid"] ?? "",
        segal: json["customer_segal"] ?? "",
        country: json["customer_country"] ?? "",
        city: json["customer_city"] ?? "",
        state: json["customer_state"] ?? "",
        postcode: json["customer_postcode"] ?? "",
        building: json["customer_building"] ?? "",
        street: json["customer_street"] ?? "",
        mobile: json["customer_mobile"] ?? "",
      );

  bool get isNull => id == null || id == 0;
  static List<CustomerModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => CustomerModel.fromJson(data)).toList();
  }

// Map<String, dynamic> toJson() => {
//       "lang": id == null ? null : id,
//     };
}
