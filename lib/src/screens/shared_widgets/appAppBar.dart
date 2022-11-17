import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget {
  String title;
  List<Widget> actions;
  bool showBack;
  final VoidCallback onBack;
  final double height;
  AppAppBar(
      {@required this.title,
      this.actions,
      this.showBack = true,
      this.onBack,
      this.height = 150});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black38, width: 0.5)),
        ),
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showBack
                ? CustomIconBtn(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff2A2A2A),
                      size: 30,
                    ),
                    onPress: () => Navigator.pop(context),
                  )
                : SizedBox,
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 22,
                        color: const Color(0xff2a2a2a),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                actions != null
                    ? Row(
                        children: actions.map((e) => e).toList(),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
