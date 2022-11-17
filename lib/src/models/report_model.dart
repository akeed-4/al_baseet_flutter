import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/name_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:intl/intl.dart';

class ReportModel {
  List<TransactionModel> transactions = [];
  List<TotalsModel> totals = [];
  ReportModel({this.transactions, this.totals});

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        transactions:
            TransactionModel.toListOfModel(json['transactions'] ?? []),
        totals: TotalsModel.toListOfModel(json['total'] ?? []),
      );
}

class TotalsModel {
  double amount;
  NameModel invoiceName;
  TotalsModel({this.amount, this.invoiceName});

  factory TotalsModel.fromJson(Map<String, dynamic> json) => TotalsModel(
        invoiceName: NameModel.fromJson(json["invoice_name"] ?? {}),
        amount: json["total_amount"] ?? 00,
      );

  static List<TotalsModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => TotalsModel.fromJson(data)).toList();
  }
}

class TransactionModel {
  int id;
  int no;
  String invoiceType;
  NameModel invoiceName;
  NameModel invoiceShortName;
  DateTime date;
  double amount;
  CustomerModel customer;

  TransactionModel(
      {this.id,
      this.no,
      this.invoiceType,
      this.invoiceName,
      this.invoiceShortName,
      this.date,
      this.amount,
      this.customer});
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        no: json["no"] != null ? json["no"].round() : 0,
        invoiceType: json['invoice_type'],
        invoiceName: NameModel.fromJson(json["invoice_name"] ?? {}),
        invoiceShortName: NameModel.fromJson(json["invoice_short_name"] ?? {}),
        date:
            DateTime.parse(json["date"] ?? DateTime.now().toString()).toLocal(),
        amount: json["amount"] ?? 00,
        customer: CustomerModel.fromJson(json["customer"] ?? {}),
      );
  String get datDate => "${DateFormat('yyyy-MM-dd', "en").format(date)}";
  String get datTime => "${DateFormat('hh:mm', "en").format(date)}";

  static List<TransactionModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => TransactionModel.fromJson(data)).toList();
  }
}
