import 'package:al_baseet/src/screens/shared_widgets/app_circ_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppBtn extends StatelessWidget {
  final String text;
  final bool isPlane;
  final bool isLoading;
  final Function onPress;
  final double height;
  final Color backgroundColor;
  IconData icon;
  AppBtn(
      {@required this.text,
      this.isPlane = false,
      this.onPress,
      this.backgroundColor,
      this.isLoading = false,
      this.icon,
      this.height = 50});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: height,
        decoration: BoxDecoration(
            color:
                isPlane ? Colors.white : backgroundColor ?? Color(0xff2C2E78),
            border: Border.all(
              color: backgroundColor ?? Color(0xff2C2E78),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: isLoading
                  ? SpinKitDualRing(
                      color: isPlane ? backgroundColor : Colors.white,
                      size: 30.0,
                      lineWidth: 4,
                    )
                  : Text(
                      text,
                      style: TextStyle(

                        color: isPlane
                            ? backgroundColor ?? Color(0xff2C2E78)
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
            ),
            icon != null
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      icon ?? Icons.check,
                      color: isPlane
                          ? backgroundColor ?? Color(0xff2C2E78)
                          : Colors.white,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
