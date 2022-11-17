import 'dart:io';
// import 'package:al_baseet/src/models/company_model.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/user_model.dart';
// import 'package:al_baseet/src/values/global_context.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:syncfusion_flutter_pdf/pdf.dart';

class CreateRequestProductsPdf {
  InvoiceModel invoice;
  UserModel user;
  CreateRequestProductsPdf({this.invoice, this.user});
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
        // pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(5),
        build: (context) => [
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(children: [
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(5),
                child: pw.Center(child: pw.Text(invoice.btc_title.ar)),
                // child: pw.Center(child: pw.Text("فاتورة ضريبية مبسطة")),
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
              pw.SizedBox(height: 10),

              _product(),

              // pw.SizedBox(height: 10),
              // _otherPaymentMethods(),
              //== pw.SizedBox(height: 10),
              //== pw.Container(
              //==   margin: pw.EdgeInsets.symmetric(horizontal: 20),
              //==   child: pw.Row(
              //==     mainAxisAlignment: pw.MainAxisAlignment.center,
              //==     children: [
              //==       pw.BarcodeWidget(
              //==         data: invoice.qrData,
              //==         // data: invoice.qrData??'invoice',
              //==         barcode: pw.Barcode.qrCode(),
              //==         width: 150,
              //==         height: 150,
              //==       )
              //==     ],
              //==   ),
              //== )
            ]),
          )
        ],
      ),
    );

    final List<int> bytes = await pdf.save();
    await saveAndLaunchFile(bytes, 'طلب بضاعة $invoice.invoiceNo .pdf');
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
                _infoChild(label: "الوقت", info: invoice.datTimeWithSec),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              children: [
                _infoChild(
                    label: "رقم الطلب", info: invoice.invoiceNo.toString()),
                _infoChild(label: "التاريخ", info: invoice.datDate),

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

  pw.Widget _product() {
    // pw.TextStyle style1 = pw.TextStyle(
    //   fontSize: 12,
    //   // fontWeight: pw.FontWeight.normal,
    // );
    pw.TextStyle style2 = pw.TextStyle(
      fontSize: 12,
      // color: PdfColor.fromHex("#ffffff"),
      // fontWeight: pw.FontWeight.normal,
    );
    double _padding = 5;
    pw.EdgeInsets padding = pw.EdgeInsets.symmetric(horizontal: _padding);
    return pw.Wrap(children: [
      pw.Container(
        child:
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
          pw.Table(
            columnWidths: {
              0: pw.FractionColumnWidth(.2),
            },
            border: pw.TableBorder.all(
              width: .3,
            ),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(
                  // color: PdfColor.fromHex("#6666ff"),
                ),
                children: [
                  pw.Container(
                    padding: padding,
                    child: pw.Text(
                      "الكمية",
                      style: style2,
                    ),
                  ),
                  pw.Container(
                    padding: padding,
                    child: pw.Text(
                      "الصنف",
                      style: style2,
                    ),
                  ),
                ],
              ),
              // pw.Tab
              // for (int i = 1; i <= 20; i++)
              ...List.generate(
                invoice.products.length,
                    (index) => pw.TableRow(
                  decoration: pw.BoxDecoration(
                    // color:
                    //     PdfColor.fromHex(index % 2 == 0 ? "#d6d6f5" : "#9999e6"),
                  ),
                  children: [
                    pw.Container(
                      padding: padding,
                      child: pw.Text(
                        "${invoice.products[index].quantity}",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Container(
                      padding: padding,
                      child: pw.Text(
                        // "فينو مشروب غازي 12 ملم",
                        "${invoice.products[index].product.name.ar}",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      )
    ]);
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory()).path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}
