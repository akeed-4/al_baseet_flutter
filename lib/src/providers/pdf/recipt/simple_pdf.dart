import 'dart:io';
import 'package:al_baseet/src/models/company_model.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/receipts_model.dart';
import 'package:al_baseet/src/models/user_model.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CreateReciptSimplePdf {
  ReceiptsModel recipt;
  UserModel user;
  CreateReciptSimplePdf({this.recipt, this.user});
  Future<void> createPDF() async {
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(
        await rootBundle.load("assets/fonts/HacenTunisia.ttf"),
        // await rootBundle.load("assets/fonts/Droid-Arabic-Kufi.ttf"),
        // await rootBundle.load("assets/fonts/Tajawal-Regular.ttf"),
        // await rootBundle.load("assets/fonts/GE-SS-Two-Bold.otf"),
      ),
      bold: pw.Font.ttf(
        // await rootBundle.load("assets/fonts/Droid-Arabic-Kufi.ttf"),
        await rootBundle.load("assets/fonts/HacenTunisia.ttf"),
      ),
    );

    final pdf = pw.Document(
      theme: myTheme,
    );
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a6,
        margin: pw.EdgeInsets.all(5),
        build: (context) => [
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(children: [
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(5),
                // child: pw.Center(child: pw.Text(recipt.btc_title.ar)),
                child: pw.Center(child: pw.Text("سند قبض")),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 3),
                ),
              ),
              pw.SizedBox(height: 10),
              // pw.Image(AssetImage('')),
              pw.SizedBox(height: 10),
              pw.Text(
                user.company.companyName,
                style: pw.TextStyle(
                    // color: PdfColors.red,
                    // decoration: pw.TextDecoration.underline,
                    ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "${user.company.companyAddress}",
                style: pw.TextStyle(
                    // color: PdfColors.red,
                    // decoration: pw.TextDecoration.underline,
                    ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "Tel. ${user.company.companyPhone} Fax ${user.company.companyFax}",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "${user.company.companyTaxId}",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      "رقم التعريف الضريبي",
                      style: pw.TextStyle(
                          // fontWeight: pw.FontWeight.bold
                          ),
                    ),
                  ]),
              pw.SizedBox(height: 5),
              _info(),
            ]),
          )
        ],
      ),
    );

    final List<int> bytes = await pdf.save();
    await saveAndLaunchFile(bytes, 'تقرير سند قبض.pdf');
  }

  pw.Widget _info() {
    return pw.Container(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // _infoChild(label: "المستخدم", info:"محمد"),
                _infoChild(label: "المستخدم", info: "${user.name}"),
                _infoChild(label: "الوقت", info: recipt.datDate),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              children: [
                _infoChild(
                    label: "رقم السند", info: recipt.receiptsNo.toString()),
                _infoChild(label: "التاريخ", info: recipt.datDate),

                // _infoChild(label: "نقطة البيع", info: ""),
                // _infoChild(label: "الوردية", info: ""),
              ],
            ),
          )
        ],
      ),
    );
  }

  pw.Widget _infoChild({String label, String info}) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Container(
                child: pw.Text(
              info,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                fontStyle: pw.FontStyle.normal,
              ),
            )),
          ),
          // pw.SizedBox(width: 5),
          pw.Container(
            width: 70,
            margin: pw.EdgeInsets.only(left: 5),
            padding: pw.EdgeInsets.all(5),
            // color: PdfColor.fromHex("#bfbfbf"),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: .5)),
            child: label.isEmpty
                ? pw.SizedBox()
                : pw.Text(
                    label,
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory()).path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}
