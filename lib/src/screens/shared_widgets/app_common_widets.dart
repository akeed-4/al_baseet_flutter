import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/cutom_dialog.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';

import '../../models/invoice_type.dart';
// import 'package:intl/intl.dart';

Widget paymentState({@required label, Color textColor, Color backgroundColor}) {
  return Container(
    width: 56,
    height: 56,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      // borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
      color: backgroundColor ?? const Color(0xffe6f3ed),
    ),
    child: Center(
      child: FittedBox(
        child: Text(
          '$label',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 12,
            color: textColor ?? const Color(0xff0a8754),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Widget paymentType({@required label, Color textColor, Color backgroundColor}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: backgroundColor ?? const Color(0x1a0a8754),
    ),
    child: Text(
      '$label',
      style: TextStyle(
        fontFamily: 'Droid Arabic Kufi',
        fontSize: 10,
        color: textColor ?? const Color(0xff0a8754),
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget invoiceInfo({
  @required InvoiceModel invoice,
  double nameSize,
  double dateSize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '# ${invoice.invoiceNo}',
        style: TextStyle(
          fontFamily: 'Droid Arabic Kufi',
          fontSize: nameSize ?? 15,
          color: const Color(0xff003d86),
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: 5),
      // Adobe XD layer: '4.4' (text)
      Text(
        "${invoice.datDate}",
        style: TextStyle(
          fontFamily: 'Droid Arabic Kufi',
          fontSize: dateSize ?? 11,
          color: const Color(0xff7f8e9d),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.right,
      ),
      SizedBox(height: 2),
      Text(
        "${(invoice.type.key == InvoiceType.cash.key || invoice.type.key == InvoiceType.returnCash.key) && invoice.customer_name != null && invoice.customer_name != '' ? invoice.customer_name : invoice.customer.name.localeName}",
        style: TextStyle(
          fontFamily: 'Droid Arabic Kufi',
          fontSize: dateSize ?? 11,
          color: const Color(0xff7f8e9d),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.right,
      ),
    ],
  );
}

void showCustomDialog(
    {BuildContext context,
    bool isDismissible = true,
    Widget logo,
    Widget actions,
    String title,
    String info}) {
  showDialog(
    barrierDismissible: isDismissible,
    context: context ?? navigatorKey.currentContext,
    builder: (BuildContext context) {
      return CustomDialog(
          title: title,
          info: info,
          isDismissible: isDismissible,
          actions: actions,
          logo: logo);
    },
  );
}

void showAreYouSureDialog(
    {String title, String subTitle, @required Function onOK}) {
  showCustomDialog(
    title: title ?? S.current.are_you_sure,
    info: subTitle ?? "",
    actions: Row(
      children: [
        Expanded(
          child: AppBtn(
            text: S.current.cancel,
            backgroundColor: Colors.black54,
            isPlane: true,
            onPress: () {
              Navigator.pop(navigatorKey.currentContext);
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: AppBtn(
              text: S.current.ok,
              backgroundColor: Colors.redAccent,
              onPress: () {
                Navigator.pop(navigatorKey.currentContext);
                onOK();
              }),
        ),
      ],
    ),
  );
}

void showPrintingDesignDialog(
    {String title, String subTitle, @required Function onBTC, @required Function onBTB}) {
  showCustomDialog(
    title: title ?? S.current.print_design_title,
    info: subTitle ?? S.current.print_design_sub_title,
    actions:
    Row(
      children: [
        Expanded(
          child: AppBtn(
            text: S.current.print_design_BTB,
            backgroundColor: Colors.black54,
            onPress: () {
              Navigator.pop(navigatorKey.currentContext);
              onBTB();
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: AppBtn(
              text: S.current.print_design_BTC,
              backgroundColor: Colors.redAccent,
              onPress: () {
                Navigator.pop(navigatorKey.currentContext);
                onBTC();
              }),
        ),
      ],
    ),
  );
}