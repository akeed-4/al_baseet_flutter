
import 'dart:math';

import 'package:flutter/material.dart';

//values



//Colors
Color appPrimaryColor =Color(0xff003d86);
Color appAccentColor = Colors.black;
Color appScaffoldBackground = Color(0xffF8F9FB);

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
