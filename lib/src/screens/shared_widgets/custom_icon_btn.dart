import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final Widget icon;
  final Function onPress;
  final double size;
  CustomIconBtn({@required this.icon, @required this.onPress, this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox.fromSize(
        size: Size(size ?? 56, size ?? 56), // button width and height
        child: ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
                splashColor: Colors.white, // splash color
                onTap: onPress, // button pressed
                child: icon),
          ),
        ),
      ),
    );
  }
}
