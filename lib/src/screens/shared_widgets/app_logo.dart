import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  AppLogo({this.height = 100, this.width = 68});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            // color: Colors.blueAccent,
            width: width,
            height: height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                "assets/png/logo.png",
                // color: Colors.red,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'تطبيق البسيط',
            style: TextStyle(
              fontFamily: 'Shorooq Yaraa',
              fontSize: 25,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
