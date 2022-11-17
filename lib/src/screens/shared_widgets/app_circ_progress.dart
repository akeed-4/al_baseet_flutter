import 'package:al_baseet/src/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppProgressLoading extends StatelessWidget {
  final double strokeWidth;
  final double size;
  final Color color;
  AppProgressLoading({this.strokeWidth, this.color, this.size});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        accentColor: color ?? Color(0xff2C2E78),
      ),
      child: Container(
        child: SpinKitDualRing(
          size: size ?? 40.0,
          color: color ?? appPrimaryColor,
          lineWidth: strokeWidth ?? 4,
        ),
      ),
    );
  }
}
