import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  final CustomerModel customerModel;
  CustomerDetails({this.customerModel});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height * .5,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/png/customer_background.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // color: Colors.blueAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomRoundImage(
                                  imageUrl: customerModel.userImage,
                                  borderColor: Colors.white,
                                  width: 110,
                                  height: 110,
                                ),
                                // Adobe XD layer: 'ful name' (text)
                                Text(
                                  '${customerModel.name.localeName}',
                                  textAlign:TextAlign.center ,
                                  style: TextStyle(
                                    fontFamily: 'Droid Arabic Kufi',
                                    fontSize: 22,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Adobe XD layer: 'country' (text)
                                Text(
                                  customerModel.address,
                                  textAlign:TextAlign.center ,
                                  style: TextStyle(
                                    fontFamily: 'Droid Arabic Kufi',
                                    fontSize: 14,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            CustomIconBtn(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPress: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .43,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x148483a9),
                        offset: Offset(0, 10),
                        blurRadius: 88,
                      ),
                    ],
                  ),
                  height: 114,
                  width: MediaQuery.of(context).size.width * .8,
                  child: Row(
                    children: [
                      Expanded(
                        child: _detailsWidget(
                          icon_url: "assets/png/min_invoice.png",
                          label: S.of(context).invoice,
                          info: "${customerModel.invoices}",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 28),
                        height: 114,
                        width: 2,
                        color: Color(0xffE4EBFF),
                      ),
                      Expanded(
                        child: _detailsWidget(
                          icon_url: "assets/png/min_invoice.png",
                          label: S.of(context).collected_amount,
                          info: "${currencyFormat(customerModel.receipts)}",
                          isCurrency: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailsWidget(
      {String label, String info, String icon_url, bool isCurrency = false}) {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(icon_url, width: 24, height: 21),
          SizedBox(height: 6),
          isCurrency
              ? CurrencyWidget(
                  amount: info,
                  fontSize: 18,
                  amountColor: Color(0xff1e263c),
                  fontWeight: FontWeight.w700,
                )
              : Text(
                  '$info',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 20,
                    color: const Color(0xff1e263c),
                    fontWeight: FontWeight.w700,
                  ),
                ),
          // SizedBox(height: 6), // Adobe XD layer: 'Medal' (text)
          Text(
            '$label',
            style: TextStyle(
              fontFamily: 'Droid Arabic Kufi',
              fontSize: 14,
              color: const Color(0xffa3a4ad),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
