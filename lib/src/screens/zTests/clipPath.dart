import 'package:flutter/material.dart';

class ClipPatExample extends StatefulWidget {
  @override
  _ClipPatExampleState createState() => _ClipPatExampleState();
}

class _ClipPatExampleState extends State<ClipPatExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ClipPath"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text("data".toUpperCase()),
              ),
            ),
          ),
          // Container(
          //   // color: Colors.blue,
          //   height: 100,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/png/footer.png"),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Container(
          //   color: Colors.lightGreen,
          //   // height: 100,
          //   child: ClipPath(
          //     clipper: MyCustomClipper(),
          //     child: Container(
          //       color: Colors.blue,
          //       height: 100,
          //     ),
          //   ),
          // )
          Container(
            // height: 100,
            child: CustomPaint(
              painter: MyPainter(),
              child: Container(
                height: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = Color(0xffffffff).withOpacity(0);
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width * 0.72, 0, size.width * 0.72, 0);
    path.cubicTo(size.width * 0.72, 0, size.width * 0.72, size.height * 0.56, size.width * 0.72, size.height * 0.56);
    path.cubicTo(size.width * 0.72, size.height * 0.56, 0, size.height * 0.56, 0, size.height * 0.56);
    path.cubicTo(0, size.height * 0.56, 0, 0, 0, 0);
    canvas.drawPath(path, paint);


    // Path number 2


    paint.color = Color(0xff063464);
    path = Path();
    path.lineTo(size.width * 0.19, size.height * 0.27);
    path.cubicTo(size.width * 0.19, size.height * 0.27, size.width * 0.29, size.height * 0.42, size.width * 0.35, size.height * 0.35);
    path.cubicTo(size.width * 0.4, size.height * 0.28, size.width * 0.48, size.height * 0.02, size.width * 0.56, 0);
    path.cubicTo(size.width * 0.63, -0.02, size.width * 0.79, size.height * 0.39, size.width * 0.85, size.height * 0.42);
    path.cubicTo(size.width * 0.85, size.height * 0.42, size.width * 0.85, size.height * 0.68, size.width * 0.85, size.height * 0.68);
    path.cubicTo(size.width * 0.85, size.height * 0.68, size.width * 0.19, size.height * 1.4, size.width * 0.04, size.height * 0.68);
    path.cubicTo(-0.11, -0.04, size.width * 0.19, size.height * 0.27, size.width * 0.19, size.height * 0.27);
    path.cubicTo(size.width * 0.19, size.height * 0.27, size.width * 0.19, size.height * 0.27, size.width * 0.19, size.height * 0.27);
    canvas.drawPath(path, paint);


    // Path number 3


    paint.color = Color(0xffffffff).withOpacity(0);
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width * 0.72, 0, size.width * 0.72, 0);
    path.cubicTo(size.width * 0.72, 0, size.width * 0.72, size.height * 0.56, size.width * 0.72, size.height * 0.56);
    path.cubicTo(size.width * 0.72, size.height * 0.56, 0, size.height * 0.56, 0, size.height * 0.56);
    path.cubicTo(0, size.height * 0.56, 0, 0, 0, 0);
    canvas.drawPath(path, paint);


    // Path number 4


    // paint.color = Color(0xffbc9f43);
    // path = Path();
    // path.lineTo(0, size.height * 0.06);
    // path.cubicTo(0, size.height * 0.06, size.width * 0.01, size.height * 0.04, size.width * 0.04, size.height * 0.05);
    // path.cubicTo(size.width * 0.06, size.height * 0.06, size.width * 0.12, size.height * 0.11, size.width * 0.16, size.height * 0.1);
    // path.cubicTo(size.width * 0.19, size.height * 0.1, size.width / 4, -0.01, size.width * 0.29, 0);
    // path.cubicTo(size.width / 3, size.height * 0.01, size.width * 0.36, size.height * 0.07, size.width * 0.39, size.height * 0.14);
    // path.cubicTo(size.width * 0.42, size.height / 5, size.width * 0.47, size.height * 0.34, size.width * 0.52, size.height * 0.34);
    // path.cubicTo(size.width * 0.57, size.height * 0.34, size.width * 0.64, size.height * 0.12, size.width * 0.64, size.height * 0.12);
    // path.cubicTo(size.width * 0.64, size.height * 0.12, size.width * 0.66, size.height * 0.06, size.width * 0.69, size.height * 0.13);
    // path.cubicTo(size.width * 0.72, size.height / 5, size.width * 0.83, size.height * 0.49, size.width, size.height * 0.53);
    // path.cubicTo(size.width * 1.14, size.height * 0.57, 0, size.height * 0.55, 0, size.height * 0.55);
    // path.cubicTo(0, size.height * 0.55, 0, size.height * 0.06, 0, size.height * 0.06);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height/3);
    path.quadraticBezierTo(
        size.width / 6,size.height/5, size.width / 3, size.height-30);

    path.quadraticBezierTo(
        size.width*.70,size.height, size.width*.80, size.height/3);
    path.quadraticBezierTo(
        size.width*.8,0, size.width, size.height*.2);

    path.lineTo(size.width, 0);

    return path;
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

  // @override
  // bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  //   // TODO: implement shouldReclip
  //   throw UnimplementedError();
  // }
}
