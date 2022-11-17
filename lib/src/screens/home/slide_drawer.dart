import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/screens/Invoices/invoices.dart';
import 'package:al_baseet/src/screens/request_products/request_products.dart';
import 'package:al_baseet/src/screens/auth/logout_dialog.dart';
import 'package:al_baseet/src/screens/backup/back_up.dart';
import 'package:al_baseet/src/screens/customers/customers.dart';
import 'package:al_baseet/src/screens/receipts/receipts.dart';
import 'package:al_baseet/src/screens/reports/reports.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
import 'package:al_baseet/src/screens/warehouse/history.dart';
import 'package:al_baseet/src/screens/warehouse/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidDrawer extends StatefulWidget {
  @override
  _SlidDrawerState createState() => _SlidDrawerState();
}

class _SlidDrawerState extends State<SlidDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      // color: Colors.blueAccent,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(7.75),
            ),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: ListView(
            children: [
              _header(),
              _body(),
            ],
          ),
          // color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      // height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
        ),
        gradient: LinearGradient(
          begin: Alignment(0.0, -0.16),
          end: Alignment(1.65, 2.28),
          colors: [const Color(0xff2c2e78), const Color(0xffcd3327)],
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRoundImage(
            imageUrl: context.read<AuthProvider>().userModel.imageUrl,
            width: 68,
            height: 68,
            borderColor: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            "${context.read<AuthProvider>().userModel.name}",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: const Color(0xfff8f9fb),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "${context.read<AuthProvider>().userModel.company.companyName}",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: const Color(0xfff8f9fb),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "${context.read<AuthProvider>().userModel.company.companyAddress}",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: const Color(0xfff8f9fb),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _drawerItem(
              label: S.of(context).warehouse,
              onPress: () => appNavPush(context, page: Warehouse())),
          // _drawerItem(
          //     label: S.of(context).request_products,
          //     onPress: () => appNavPush(context, page: RequestProducts())),
          _drawerItem(
              label: S.of(context).backup,
              onPress: () => CustomToast.showToastInfo(S.of(context).soon)),
          // onPress: () => appNavPush(context, page: BackUpHome())),
          _drawerItem(
              label: S.of(context).customers,
              onPress: () => appNavPush(context, page: Customers())),
          _drawerItem(
              label: S.of(context).reports,
              onPress: () => appNavPush(context,
                  page: Reports(
                    title: S.of(context).reports,
                  ))),
          // onPress: () => appNavPush(context, page: Reports())),
          _drawerItem(
              label: S.of(context).invoices,
              onPress: () => appNavPush(context, page: Invoices())),
          _drawerItem(
              label: S.of(context).receipts,
              onPress: () => appNavPush(context, page: Receipts())),
          _drawerItem(
            label: S.of(context).change_lang_info,
            onPress: () {
              showCustomDialog(
                context: context,
                title: S.of(context).change_language_qu,
                // isDismissible: false,
                actions: Row(
                  children: [
                    Expanded(
                      child: AppBtn(
                        text: S.of(context).cancel_lang,
                        height: 40,
                        isPlane: true,
                        onPress: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: AppBtn(
                        text: S.of(context).change_lang,
                        height: 40,
                        onPress: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          context.read<LanguageProvider>().switchLanguage();
                        },
                        // backgrounColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          _drawerItem(
              label: S.of(context).logout,
              onPress: () {
                showDialog(
                  // barrierDismissible: isDismissible,
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog();
                  },
                );
              },
              textColor: Color(0xffcd3327)),
        ],
      ),
    );
  }

  Widget _drawerItem({String label, Function onPress, Color textColor}) {
    return InkWell(
      onTap: onPress,
      child: Container(
          // color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                '$label',
                style: TextStyle(
                  fontFamily: 'Droid Arabic Kufi',
                  fontSize: 15,
                  color: textColor ?? const Color(0xff2a2a2a),
                ),
                // textAlign: TextAlign.right,
              ),
            ],
          )),
    );
  }
}
