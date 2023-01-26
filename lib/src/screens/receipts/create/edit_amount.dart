import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditInvoiceAmount extends StatefulWidget {
  final InvoiceModel invoice;
  EditInvoiceAmount({@required this.invoice});

  @override
  _EditInvoiceAmountState createState() => _EditInvoiceAmountState();
}

class _EditInvoiceAmountState extends State<EditInvoiceAmount> {
  double newAmount = 1;
  String errorText = "";
  @override
  void initState() {
    newAmount = widget.invoice.editAmount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InvoicesProvider>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // padding: EdgeInsets.all(18),
      // padding: MediaQuery.of(context).viewInsets,
      child: Container(
        // margin: EdgeInsets.all(15),
        // height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _remainAmountInfo(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-15.]')),
                      ],
                      decoration: InputDecoration(
                        hintText: "ادخل المبلغ الجديد ",
                        errorText: errorText.isEmpty ? null : errorText,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38)),
                      ),
                      autofocus: true,
                      initialValue: "$newAmount",
                      onChanged: (String value) {
                        double _value =
                            double.parse(value.isNotEmpty ? value : "0");

                        if (_value > widget.invoice.remainAmount ||
                            _value <= 0) {
                          setState(() {
                            errorText = S.of(context).invalid_amount;
                            newAmount = _value;
                          });
                        } else {
                          setState(() {
                            errorText = "";
                            newAmount = _value;
                          });
                        }
                      },
                    ),
                  ),
                  Text(
                    S.current.currency_rs,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 14,
                      color: const Color(0xff353333),
                      // letterSpacing: -0.26666668701171875,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AppBtn(
                      height: 40,
                      text: S.of(context).cancel.toUpperCase(),
                      isPlane: true,
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: AppBtn(
                      height: 40,
                      text: S.of(context).save.toUpperCase(),
                      onPress: () {
                        if (errorText.isNotEmpty) {
                          return;
                        }
                        // if (newAmount.toString().isEmpty) {
                        //   Navigator.pop(context);
                        //   return;
                        // }
                        print("do edit ..........$newAmount");
                        _provider.editInvoiceAmount(
                            invoice: widget.invoice, newAmount: newAmount);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _remainAmountInfo() {
    // return CurrencyWidget(
    //   amount: widget.invoice.remainAmount,
    // )
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontFamily: 'Droid Arabic Kufi',
          fontSize: 14,
          color: Color(0xff555568),
        ),
        children: [
          TextSpan(
            text: S.of(context).invoice_remain_amount,
            // style: TextStyle(
            //   fontWeight: FontWeight.w700,
            // ),
          ),
          TextSpan(
            text: " ",
          ),
          TextSpan(
            text: "${currencyFormat(widget.invoice.remainAmount)}",
            style: TextStyle(
              // fontSize: 16,
              color: Colors.redAccent,
            ),
          ),
          TextSpan(
            text: " ",
          ),
          TextSpan(
            text: S.current.currency_rs,
            style: TextStyle(
              fontSize: 12,
              // color: Colors.redAccent,
            ),
          ),
        ],
      ),
      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
      // textAlign: TextAlign.left,
    );
  }
}
