import 'package:al_baseet/src/app/app.dart';
import 'package:al_baseet/src/providers/base/int_provider.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: appScaffoldBackground,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark
      //or set color with: Color(0xFF0000FF)
      ));
  runApp(
    InitProvider(child: MyApp()),
  );
}
