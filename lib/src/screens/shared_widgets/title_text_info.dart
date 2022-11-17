import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:flutter/material.dart';

class TitleTextInfo extends StatelessWidget {
  final String title;
  final String text;
  final Color txtColor;
  final bool isBold;
  final bool isCurrency;
  TitleTextInfo(
      {this.title,
      this.text,
      this.txtColor,
      this.isBold = false,
      this.isCurrency = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adobe XD layer: 'Transaction type' (text)
          Text(
            '$title',
            style: TextStyle(
              fontFamily: 'Droid Arabic Kufi',
              fontSize: 14,
              color: const Color(0xffafafaf),
              letterSpacing: -0.23333329772949218,
            ),
          ),
          // SizedBox(height: 8),
          // Adobe XD layer: 'Money Transfer' (text)
          isCurrency
              ? CurrencyWidget(
                  amount: text,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  amountColor: Colors.black,
                )
              : Text(
                  '$text',
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 16,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    color: const Color(0xff353333),
                    letterSpacing: -0.26666668701171875,
                  ),
                ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
