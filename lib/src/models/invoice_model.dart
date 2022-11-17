import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/invoice_type.dart';
import 'package:al_baseet/src/models/key_value_model.dart';
import 'package:al_baseet/src/models/name_model.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceModel {
  int id;
  int invoiceNo;
  InvoiceType type;
  double totalAmountBeforTax;
  double totalAmount;
  double paidAmount;
  int taxPersentage;
  double taxAmount;
  double editAmount;

  DateTime date = DateTime.now();
  bool approvalState;
  CustomerModel customer;
  List<InvoiceProductModel> products;
  String qrData;
  NameModel btc_title;
  NameModel btb_title;
  NameModel invoice_name;
  String customer_name;
  String customer_tax_id;

  InvoiceModel(
      {
        this.id,
        this.invoiceNo,
        this.type,
        this.date,
        this.totalAmountBeforTax,
        this.totalAmount,
        this.paidAmount,
        this.approvalState,
        this.customer,
        this.products,
        this.taxPersentage,
        this.taxAmount,
        this.qrData = 'invoice',
        this.btc_title,
        this.btb_title,
        this.invoice_name,
        this.editAmount = 1,
        this.customer_name = '',
        this.customer_tax_id = ''
      });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        id: json["id"] ?? 00,
        // invoiceNo: json["invoice_no"],
        invoiceNo: json["invoice_no"] != null ? json["invoice_no"].round() : 0,
        type: InvoiceType.getType(
            key: json["invoice_type"] ?? InvoiceType.defaultInvoiceValue),
        date: DateTime.parse(json["invoice_date"] ?? DateTime.now().toString())
            .toLocal(),
        // print();
        // totalAmount: 550,
        totalAmountBeforTax: json["amount_before_tax"] ?? 00,
        totalAmount: json["total_amount"] ?? 00,
        paidAmount: json["paid_amount"] ?? 00,
        taxPersentage: double.parse((json["tax_per"] ?? 00).toString()).floor(),
        taxAmount: json["tax_amount"] ?? 00,
        editAmount: 00,

        approvalState: (json["invoice_acceptance"] ?? 0) == 1 ? true : false,
        customer: json["customer"] == null
            ? CustomerModel()
            : CustomerModel.fromJson(json["customer"] ?? {}),
        qrData: json["qr_data"] ?? 'invoice',
        btc_title: NameModel.fromJson(json["btc_title"] ?? {}),
        btb_title: NameModel.fromJson(json["btb_title"] ?? {}),
        invoice_name: NameModel.fromJson(json["invoice_name"] ?? {}),
        products: InvoiceProductModel.toListOfModel(json["products"] ?? []),
        customer_name: json["customer_name"] ?? '',
        customer_tax_id: json["customer_tax_id"] ?? '',
      );

  static List<InvoiceModel> toListOfModel(List<dynamic> data) {
    return data.map((data) => InvoiceModel.fromJson(data)).toList();
  }

  String get getStateName =>
      approvalState ? "${S.current.approved}" : "${S.current.unapproved}";
  // String get getStateName => approvalState ? "معتمدة" : "غير معتمدة";
  String get datDate => "${DateFormat('yyyy-MM-dd', "en").format(date)}";
  String get datTime => "${DateFormat('hh:mm', "en").format(date)}";
  String get datTimeWithSec => "${DateFormat('hh:mm:ss', "en").format(date)}";
  bool get isPaid => paidAmount >= totalAmount;
  // bool get isCrided => type.;
  bool get canCreateReceipt => !(isPaid || !approvalState || type.isCash);
  InvoicePaymentState get paymentStatus =>
      InvoicePaymentState(paidAmount: paidAmount, totalAmount: totalAmount);
  double get remainAmount => totalAmount - paidAmount;
  double get totalWithTax => totalAmount + taxAmount;
  // bool get isTypageChange(InvoiceModel)=>invoice

  static double getTotalAmount(List<InvoiceModel> data) {
    double total = 0;
    data.forEach((element) {
      total += element.editAmount;
    });
    return total;
  }

  void copy(InvoiceModel invoice) {
    id = invoice.id;
    invoiceNo = invoice.invoiceNo;
    type = invoice.type;
    totalAmount = invoice.totalAmount;
    paidAmount = invoice.paidAmount;
    editAmount = invoice.editAmount;

    date = invoice.date;
    approvalState = invoice.approvalState;
    customer = invoice.customer;
    products = invoice.products;
    customer_name = invoice.customer_name;
    customer_tax_id = invoice.customer_tax_id;
  }
}

// class InvoiceType {
//   String name;
//   Color background;
//   Color txtColor;
//   String value;
//   static final String cash = "001";
//   static final String returnCash = "003";
//   static final String credit = "002";
//   static final String returnCredit = "004";
//   static final String localReceive = "052";
//   static final String localItemTransfare = "051";
//   InvoiceType({@required String type}) {
//     this.value = type;
//     this.name = type == cash ? "نقدي" : "آجل";
//     background = type == cash ? Color(0xffE6F3ED) : Color(0xffE9E9E9);
//     txtColor = type == cash ? Color(0xff0A8754) : Colors.black54;
//   }
//
//   bool get isCash => value == cash;
//   bool get isCredit => value == credit;
// }
//
// class InvoiceType02 {
//   NameModel name;
//   Color background;
//   Color txtColor;
//   String value;
//
//   static final Map<String, dynamic> cash = {
//     "key": "001",
//     "name": {"en": "Cash", "ar": "نقدي"},
//     "short_cut": {"en": "Cash", "ar": "نقدي"}
//   };
//   static final Map<String, dynamic> returnCash = {
//     "key": "003",
//     "name": {"en": "Return cash", "ar": "ترجيع نقدي"},
//     "short_cut": {"en": "r-cash", "ar": "ترجيع نقدي"}
//   };
//   static final Map<String, dynamic> credit = {
//     "key": "002",
//     "name": {"en": "Cash", "ar": "نقدي"},
//     "short_cut": {"en": "Credit", "ar": "آجل"}
//   };
//   static final Map<String, dynamic> returnCredit = {
//     "key": "004",
//     "name": {"en": "Cash", "ar": "نقدي"},
//     "short_cut": {"en": "r-Credit", "ar": "ترجيع آجل"}
//   };
//   // static final Map<String, dynamic> localReceive = "052";
//   // static final Map<String, dynamic> localItemTransfere = "051";
//   // factory InvoiceType02.fromJson(Map<String, dynamic> json) => InvoiceType02();
//
//   InvoiceType02({@required String typeValue}) {
//     this.value = typeValue;
//     this.name = NameModel();
//     background = typeValue == cash ? Color(0xffE6F3ED) : Color(0xffE9E9E9);
//     txtColor = typeValue == cash ? Color(0xff0A8754) : Colors.black54;
//   }
//
//   bool get isCash => value == cash;
//   bool get isCredit => value == credit;
// }

class InvoicePaymentState {
  NameModel name;
  Color background;
  Color txtColor;
  InvoicePaymentState(
      {@required double totalAmount, @required double paidAmount}) {
    this.name = (paidAmount == 0)
        ? NameModel(ar: "غير مدفوع", en: "unpaid")
        : (paidAmount > 0 && paidAmount < totalAmount)
            ? NameModel(ar: "مدفوع جزئ", en: "subPaid")
            : NameModel(ar: "مدفوع", en: "Paid");
    this.background = (paidAmount == 0 && totalAmount != paidAmount)
        ? Color(0xffE9E9E9) //Color(0x716B6B)
        : (paidAmount < totalAmount)
            ? Colors.orange[50]
            : Color(0xffE6F3ED);
    this.txtColor = (paidAmount == 0 && totalAmount != paidAmount)
        ? Colors.black
        : (paidAmount < totalAmount)
            ? Color(0xffFFB45E)
            : Color(0xff0A8754);
  }
}
