import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/providers/common/settings.dart';
import 'package:al_baseet/src/providers/customer_provider.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/providers/receipts_provider.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class InitProvider extends StatelessWidget {
  final Widget child;
  // final LanguageProvider lang;
  const InitProvider({Key key, this.child}) : super(key: key);
  // const InitProvider({Key key, this.child, this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => InvoicesProvider()),
        ChangeNotifierProvider(create: (context) => WarehouseProvider()),
        ChangeNotifierProvider(create: (context) => ReceiptsProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: child,
    );
  }
}
