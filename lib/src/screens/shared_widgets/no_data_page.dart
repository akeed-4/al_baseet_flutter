import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String message;
  final String logo;
  NoDataPage({this.message, this.logo});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,

        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .1),
          Image.asset(
            logo ?? "assets/png/no_data.png",
            width: 200,
            height: 200,
          ),
          SizedBox(height: 50),
          Text(
            message ?? S.of(context).no_data_to_view,
            style: TextStyle(
              fontFamily: 'Droid Arabic Kufi',
              fontSize: 30,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Text(
                  S.of(context).back_again,
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 17,
                    color: const Color(0xff333a4d),
                    height: 1.2941176470588236,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
