import 'package:al_baseet/src/screens/Invoices/create_invoice.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNew extends StatelessWidget {
  String label;
  Function onPress;
  AddNew({@required this.label, this.onPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            // onTap: onPress,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: appPrimaryColor),
                  child: CustomIconBtn(
                    onPress: onPress,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Adobe XD layer: 'Cloud Ear Pink' (text)
                Text(
                  '$label',
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 15,
                    color: const Color(0xff003d86),
                    // color: appPrimaryColor
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
