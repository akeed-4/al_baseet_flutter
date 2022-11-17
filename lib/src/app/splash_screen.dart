import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/providers/common/settings.dart';
import 'package:al_baseet/src/screens/auth/login.dart';
import 'package:al_baseet/src/screens/home/home_page.dart';
import 'package:al_baseet/src/screens/intro/intro_lang.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _redirectApp();
    super.initState();
  }

  void _redirectApp() async {
    final isAuth = await StorageHelper.get(StorageKeys.auth);
    Future.delayed(Duration(seconds: 4), () {
      if (isAuth != null) {
        Provider.of<AuthProvider>(context, listen: false).loadLocalUserInfo();
        Provider.of<SettingsProvider>(context, listen: false).loadSettings();
        appNavPush(context, page: HomePage());
      } else {
        appNavPush(context, page: IntroLang());
      }
      // appNavPush(context, page: IntroLang());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // padding: EdgeInsets.all(20),
            child: SpinKitFoldingCube(
              color: appPrimaryColor,
              size: 35.0,
            ),
          )
        ],
      ),
    );
  }
}
