import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProductPrice extends StatefulWidget {
  final InvoiceProductModel product;
  EditProductPrice({@required this.product});

  @override
  _EditProductPriceState createState() => _EditProductPriceState();
}

class _EditProductPriceState extends State<EditProductPrice> {
  double newPrice = 1;
  String errorText = "";
  @override
  void initState() {
    newPrice = widget.product.editPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).price,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  Text(
                    "${S.of(context).current_price}:"
                        " ${widget.product.price}"
                        "${S.current.currency_rs}",
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: InputDecoration(
                      errorText: errorText.isEmpty ? null : errorText,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)),
                    ),
                    autofocus: true,
                    initialValue: "$newPrice",
                    onChanged: (String value) {
                      double _value = double.parse(value.isNotEmpty ? value : "0");


                      if (_value <= 0) {
                        setState(() {
                          errorText = S.of(context).invalid_quantity;
                          newPrice = _value;
                        });
                      } else {
                        setState(() {
                          errorText = "";
                          newPrice = _value;
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
                        if (newPrice.toString().isEmpty) {
                          Navigator.pop(context);
                          return;
                        }
                        _provider.editProductPrice(
                            product: widget.product, newPrice: newPrice);
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
}
