import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/app/splash_screen.dart';
import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/screens/auth/login.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/zTests/clipPath.dart';
import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:al_baseet/src/values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      theme: AppTheme().themeData(context, true),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: context.watch<LanguageProvider>().appLocal,
      // home: ClipPatExample(),
      home: SplashScreen(),
      navigatorKey: navigatorKey,
      // home: Container(
      //   child: Login(),
      // ),
    );
  }
}
