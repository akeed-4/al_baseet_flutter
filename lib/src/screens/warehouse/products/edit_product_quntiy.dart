import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProductQuantity extends StatefulWidget {
  final InvoiceProductModel product;
  final bool isReturn;
  EditProductQuantity({@required this.product, this.isReturn = false});

  @override
  _EditProductQuantityState createState() => _EditProductQuantityState();
}

class _EditProductQuantityState extends State<EditProductQuantity> {
  int newQuantity = 00;
  String errorText = "";
  @override
  void initState() {
    newQuantity = widget.product.editQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      //== padding: EdgeInsets.symmetric(horizontal: 18),
      // padding: MediaQuery.of(context).viewInsets,
      child: Container(
        //== margin: EdgeInsets.all(15),
        // height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    S.of(context).quantity,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(
                  "${S.of(context).available_quantity}:"
                  " ${widget.isReturn ? widget.product.quantity : widget.product.product.quantity}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      errorText: errorText.isEmpty ? null : errorText,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)),
                    ),
                    autofocus: true,
                    initialValue: "$newQuantity",
                    onChanged: (String value) {
                      int _value = int.parse(value.isNotEmpty ? value : "0");

                      int compareValidation = widget.isReturn
                          ? widget.product.quantity
                          : widget.product.product.quantity;
                      if (_value > compareValidation || _value <= 0) {
                        setState(() {
                          errorText = S.of(context).invalid_quantity;
                          newQuantity = _value;
                        });
                      } else {
                        setState(() {
                          errorText = "";
                          newQuantity = _value;
                        });
                      }
                    },
                  ),
                ),
                // Text(
                //   '\$',
                //   style: TextStyle(
                //     fontFamily: 'Droid Arabic Kufi',
                //     fontSize: 14,
                //     color: const Color(0xff353333),
                //     // letterSpacing: -0.26666668701171875,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
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

                      if (newQuantity.toString().isEmpty) {
                        Navigator.pop(context);
                        return;
                      }
                      print("do edit ..........");
                      _provider.editProductQuantity(
                          product: widget.product, newQuantity: newQuantity);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
