import 'dart:math';

import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDialog extends StatefulWidget {
  final Widget logo;
  final Widget actions;
  final String title;
  final String info;
  final bool isDismissible;
  CustomDialog(
      {this.logo,
      this.actions,
      this.title,
      this.info,
      this.isDismissible = true});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: appPadding,
      titlePadding: EdgeInsets.zero,
      actionsPadding: appPadding,
      title: Row(
        children: [
          widget.isDismissible
              ? CustomIconBtn(
                  icon: Icon(Icons.clear),
                  onPress: () => widget.isDismissible ? Navigator.pop(context) : null,
                )
              : SizedBox()
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.logo != null
              ? Container(
                  child: widget.logo ?? SizedBox(),
                )
              : SizedBox(),
          SizedBox(height: 4),
          widget.title != null
              ? Text(
                  '${widget.title ?? ''}',
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 20,
                    color: const Color(0xff0f0f0f),
                    letterSpacing: -0.32,
                    fontWeight: FontWeight.w700,
                    height: 2.2,
                  ),
                  textAlign: TextAlign.center,
                )
              : SizedBox(),
          SizedBox(height: 10),
          widget.info != null
              ? Text(
                  '${widget.info ?? ''}',
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 14,
                    color: const Color(0xcc0f0f0f),
                    height: 1.7142857142857142,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                )
              : SizedBox(),
          SizedBox(height: 30),
          widget.actions ?? SizedBox(),
        ],
      ),
    );
  }
}
