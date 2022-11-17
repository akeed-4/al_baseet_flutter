import 'package:al_baseet/src/models/name_model.dart';
import 'package:flutter/material.dart';

class InvoiceType {
  NameModel name;
  NameModel shortCut;
  String key;
  Color _background; //optional
  Color _txtColor; //optional
  InvoiceType({this.name, this.shortCut, this.key});

  factory InvoiceType.fromJson(Map<String, dynamic> json) => InvoiceType(
        name: NameModel.fromJson(json["name"]),
        shortCut: NameModel.fromJson(json["short_cut"] ?? json["name"]),
        key: json['key'],
      );

  static InvoiceType getType({@required String key}) {
    for (InvoiceType item in _invoicesTypes) {
      if (item.key == key) return item;
    }
    return InvoiceType.fromJson({
      "key": key,
      "name": {"en": "unknown", "ar": "unknown"},
      "short_cut": {"en": "unknown", "ar": "غير معروف"}
    });
  }

  bool get isCash => key == cash.key;
  bool get isCredit => key == credit.key;
  bool get canReturn => key == credit.key||key == cash.key;

  Color get background => key == cash.key
      ? Color(0xffE6F3ED)
      : key == returnCash.key || key == returnCredit.key
          ? Colors.red[100]
          : Color(0xffE9E9E9);
  Color get txtColor => key == cash.key ? Color(0xff0A8754) : Colors.black54;

  ///
  /// all invoices type in system
  ///

  static List<InvoiceType> _invoicesTypes = [
    cash,
    returnCash,
    credit,
    returnCredit,
    receiveLocalItems,
    localIssue,
    requestproducts
  ];
  static String defaultInvoiceValue = "00";


  /// any one of this should add to list above
  static final InvoiceType cash = InvoiceType.fromJson({
    "key": "001",
    "name": {"ar": "بيع نقدا", "en": "CASH SALES"},
    "short_cut": {"en": "Cash", "ar": "نقدي"}
  });
  static final InvoiceType returnCash = InvoiceType.fromJson({
    "key": "003",
    "name": {"ar": "ترجيع بيع نقدا", "en": "CASH SALES RET."},
    "short_cut": {"en": "r-cash", "ar": "ترجيع نقدي"}
  });
  static final InvoiceType credit = InvoiceType.fromJson({
    "key": "002",
    "name": {"ar": "بيع اجل", "en": "CREDIT SALES"},
    "short_cut": {"en": "Credit", "ar": "آجل"}
  });
  static final InvoiceType returnCredit = InvoiceType.fromJson({
    "key": "004",
    "name": {"ar": "ترجيع بيع آجل", "en": "CREDIT SALES RET."},
    "short_cut": {"en": "r-Credit", "ar": "ترجيع آجل"}
  });
  static final InvoiceType receiveLocalItems = InvoiceType.fromJson({
    "key": "052",
    "name": {"ar": "استلام بضاعة داخلي", "en": "LOCAL ITEMS RECEIVE"},
    "short_cut": {"en": "unknown", "ar": "غير معروف"}
  });
  static final InvoiceType localIssue = InvoiceType.fromJson({
    "key": "051",
    "name": {"ar": "نقل بضاعة داخلي", "en": "LOCAL ITEMS ISSUE"},
    "short_cut": {"en": "unknown", "ar": "غير معروف"}
  });
  static final InvoiceType requestproducts = InvoiceType.fromJson({
    "key": "113",
    "name": {"ar": "طلب بضاعة", "en": "REQUEST PRODUCTS"},
    "short_cut": {"en": "REQUEST", "ar": "طلب"}
  });
}
