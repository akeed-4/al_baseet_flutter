import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/key_value_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptsModel {
  int id;
  int receiptsNo;
  double amount;
  DateTime date;
  bool approvalState;

  List<InvoiceModel> invoices;

  ReceiptsModel({
    this.id,
    this.receiptsNo,
    this.date,
    this.amount,
    this.invoices,
    this.approvalState,
  });

  factory ReceiptsModel.fromJson(Map<String, dynamic> json) => ReceiptsModel(
        id: json["id"] ?? 00,
        receiptsNo: json["receipt_no"] != null ? json["receipt_no"].round() : 0,
        date: DateTime.parse(json["receipt_date"] ?? DateTime.now().toString()),
        amount: json["receipt_amount"] ?? 00,
        invoices: InvoiceModel.toListOfModel(
            json["invoices"].map((e) => e["invoice"]).toList() ?? []),
        approvalState: (json["receipt_acceptance"] ?? 0) == 1 ? true : false,
      );

  static List<ReceiptsModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => ReceiptsModel.fromJson(data)).toList();
  }


  String get getStateName =>
      approvalState ? "${S.current.approved}" : "${S.current.unapproved}";
  String get datDate => "${DateFormat('yyyy-MM-dd', "en").format(date)}";
  String get datTime => "${DateFormat('hh:mm', "en").format(date)}";
}
