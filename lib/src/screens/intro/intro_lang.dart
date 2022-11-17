import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/screens/auth/login.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_logo.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class IntroLang extends StatelessWidget {
  void _changeLocal(String langCode) {
    Provider.of<LanguageProvider>(navigatorKey.currentContext, listen: false)
        .changeLanguage(Locale(langCode));
    appNavPush(navigatorKey.currentContext, page: Login());
  }

  @override
  Widget build(BuildContext context) {
    // lang=context.watch
    return Container(
      // color: Colors.blueAccent,
      child: CustomScaffold(
        body: Container(
          // color: Colors.blueAccent,
          child: ListView(
            padding: EdgeInsets.all(16),
            // shrinkWrap: true,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .16),
              AppLogo(),
              SizedBox(height: 27),
              _langCard(
                imageUrl: "assets/png/ar.png",
                tex: "العربية",
                onPress: () => _changeLocal("ar"),
              ),
              SizedBox(height: 13),
              _langCard(
                imageUrl: "assets/png/en.png",
                tex: "English",
                onPress: () => _changeLocal("en"),
              ),
              SizedBox(height: 72),
              Row(
                children: [
                  Image.asset(
                    "assets/png/intro_lang_icon.png",
                    // color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _langCard({String imageUrl, String tex, Function onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0a4162a9),
              offset: Offset(-13, 47),
              blurRadius: 79,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "$imageUrl",
              // color: Colors.red,
            ),
            // Adobe XD layer: 'Create account' (text)
            Text(
              '$tex',
              style: TextStyle(
                fontFamily: 'Droid Arabic Kufi',
                fontSize: 15,
                color: const Color(0xff2c2e78),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
