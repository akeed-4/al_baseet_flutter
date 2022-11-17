import 'dart:io';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CreateEnglishPdf {
  InvoiceModel invoice;

  CreateEnglishPdf({this.invoice});
  Future<void> createPDF() async {
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(
        await rootBundle.load("assets/fonts/Cairo-Bold.ttf"),
      ),
      // bold: pw.Font.ttf(
      //   await rootBundle.load("assets/fonts/Droid-Arabic-Kufi-Bold.ttf"),
      // ),
    );
    final pdf = pw.Document(
      theme: myTheme,
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3,
        margin: pw.EdgeInsets.all(10),
        build: (pw.Context context) {
          return pw.Container(
              // textDirection: pw.TextDirection.rtl,
              child: pw.Column(
            children: [
              _header(),
              pw.SizedBox(height: 50),
              _info(),
              pw.SizedBox(height: 100),
              _product(),
              pw.SizedBox(height: 100),
              pw.Container(
                margin: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.BarcodeWidget(
                      data: invoice.qrData,
                      barcode: pw.Barcode.qrCode(),
                      width: 200,
                      height: 200,
                    )
                  ],
                ),
              )
            ],
          )); // Center
        },
      ),
    );

    final List<int> bytes = await pdf.save();
    await saveAndLaunchFile(bytes, 'Report.pdf');
  }

  pw.Widget _info() {
    pw.TextStyle style1 = pw.TextStyle(
      fontSize: 12,
      // fontWeight: pw.FontWeight.bold,
      // color: PdfColor.fromHex("#ffffff"),
    );
    return pw.Container(
      padding: pw.EdgeInsets.symmetric(horizontal: 20),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                "Customer : Abdelwahed Abdelraheem",
                style: style1,
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Payment state : ${invoice.paymentStatus.name.en}"
                    .toUpperCase(),
                style: style1,
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Invoice type : ${invoice.type.name.en}",
                style: style1,
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                "Invoice number : ${invoice.invoiceNo}",
                style: style1,
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Date : ${invoice.datDate}",
                style: style1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _header() {
    return pw.Container(
      // padding: pw.EdgeInsets.all(value),
      width: double.infinity,
      height: 100,
      // color: PdfColor.fromHex("#6666ff"),
      child: pw.Container(
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              padding: pw.EdgeInsets.symmetric(horizontal: 10),
              child: pw.Text(
                "Invoice".toUpperCase(),
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  // color: PdfColors.white,
                ),
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(20),
                  // color: PdfColor.fromHex("#4747d1"),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Total amount",
                        style: pw.TextStyle(
                          fontSize: 12,
                          // fontWeight: pw.FontWeight.bold,
                          // color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        "${invoice.totalAmount} S.R",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          // color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 1),
                pw.Container(
                  padding: pw.EdgeInsets.all(20),
                  // color: PdfColor.fromHex("#4747d1"),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Paid amount",
                        style: pw.TextStyle(
                          fontSize: 12,
                          // fontWeight: pw.FontWeight.bold,
                          // color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        "${invoice.paidAmount} S.R",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          // color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _product() {
    pw.TextStyle style1 = pw.TextStyle(
      fontSize: 12,
    );
    pw.TextStyle style2 =
        pw.TextStyle(fontSize: 12, color: PdfColor.fromHex("#ffffff"));
    return pw.Container(
        child: pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Text(
        "Products",
        style: pw.TextStyle(
          fontSize: 18,
        ),
      ),
      pw.SizedBox(height: 10),
      pw.Table(
        columnWidths: {0: pw.FractionColumnWidth(.2)},
        border: pw.TableBorder.all(
          width: 2,
        ),
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex("#6666ff"),
            ),
            children: [
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  "ID",
                  style: style2,
                ),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  "Name",
                  style: style2,
                ),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  "Quantity",
                  style: style2,
                ),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  "Amount/S.R",
                  style: style2,
                ),
              ),
            ],
          ),
          // pw.Tab

          ...List.generate(
            invoice.products.length,
            (index) => pw.TableRow(
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex(index % 2 == 0 ? "#d6d6f5" : "#9999e6"),
              ),
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Text(
                    "${invoice.products[index].product.id}",
                    style: style1,
                  ),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Text(
                    "${invoice.products[index].product.name.en}",
                    style: style1,
                  ),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Text(
                    "${invoice.products[index].quantity}",
                    style: style1,
                  ),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Text(
                    "${invoice.products[index].price}",
                    style: style1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]));
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory()).path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}
