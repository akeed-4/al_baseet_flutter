import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    Key key,
    this.amount,
    this.amountColor,
    this.currencyColor,
    this.fontSize = 16,
    this.fontWeight,
    this.currencySize,
  }) : super(key: key);
  final dynamic amount;
  final Color currencyColor;
  final Color amountColor;
  final double fontSize;
  final double currencySize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(

        TextSpan(

          style:  TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: fontSize,
            color: amountColor ?? Color(0xff555568),
          ),
          children: [
            TextSpan(
              text: "${currencyFormat(amount)}",
              style: TextStyle(
                fontWeight: fontWeight??FontWeight.normal
              )
            ),
            TextSpan(
              text: " ",
            ),
            TextSpan(
              text: "${S.of(context).currency_rs}",
              style: TextStyle(
                color: currencyColor ?? amountColor ?? Color(0xff555568),
                fontSize: currencySize ?? fontSize/2,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        // textAlign: TextAlign.left,
      ),
    );
  }
}
