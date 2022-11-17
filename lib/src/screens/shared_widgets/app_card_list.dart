import 'package:flutter/material.dart';

class AppCardList extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Color background;
  AppCardList(
      {@required this.child,
      this.onTap,
      this.background = const Color(0xffffffff)});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: background,
        ),
        child: child ?? SizedBox(),
      ),
    );
  }
}
