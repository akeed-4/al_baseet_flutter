import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/screens/Invoices/invoices.dart';
import 'package:al_baseet/src/screens/auth/login.dart';
import 'package:al_baseet/src/screens/backup/back_up.dart';
import 'package:al_baseet/src/screens/customers/customers.dart';
import 'package:al_baseet/src/screens/home/slide_drawer.dart';
import 'package:al_baseet/src/screens/receipts/receipts.dart';
import 'package:al_baseet/src/screens/reports/reports.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_logo.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
import 'package:al_baseet/src/screens/warehouse/history.dart';
import 'package:al_baseet/src/screens/warehouse/warehouse.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Color _color1 = Color(0xffE4F2FD);
  final Color _color2 = Color(0xffE4E9F2);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime currentPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final DateTime now = DateTime.now();
        if (currentPressTime == null ||
            now.difference(currentPressTime) > Duration(seconds: 2)) {
          currentPressTime = now;
          CustomToast.showToast(S.of(context).press_again_to_exit);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        endDrawer: SlidDrawer(),
        key: _scaffoldKey,
        body: CustomScaffold(
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              // SizedBox(height: 10),
              _homeAppBar(),
              SizedBox(height: 10),
              Text(
                S.of(context).home,
                style: TextStyle(
                  fontFamily: 'Droid Arabic Kufi',
                  fontSize: 22,
                  color: const Color(0xff2a2a2a),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 28),
              _homebody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            print("muller......");
            _scaffoldKey.currentState.openEndDrawer();
          },
          child: Icon(
            Icons.menu,
            size: 35,
          ),
        ),
        Image.asset(
          "assets/png/logo_full.png",
          width: 98,
          height: 63,
        )
      ],
    );
  }

  Widget _homebody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _homeCard(
                  label: S.of(context).reports,
                  icon: "assets/png/home/reports.png",
                  background: _color1,
                  // onPress: () => showCustomDialog(context)),
                  onPress: () => appNavPush(context,
                      page: Reports(
                        title: S.of(context).reports,
                      )),
                  // onPress: () => appNavPush(context, page: Reports()),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _homeCard(
                    label: S.of(context).backup,
                    icon: "assets/png/home/backup.png",
                    background: _color2,
                    onPress: () =>
                        CustomToast.showToastInfo(S.of(context).soon)),
                // onPress: () => appNavPush(context, page: BackUpHome())),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _homeCard(
                    label: S.of(context).warehouse,
                    icon: "assets/png/home/warehouse.png",
                    background: _color2,
                    onPress: () => appNavPush(context, page: Warehouse())),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _homeCard(
                    label: S.of(context).customers,
                    icon: "assets/png/home/customer.png",
                    background: _color1,
                    onPress: () => appNavPush(context, page: Customers())),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _homeCard(
                    label: S.of(context).receipts,
                    icon: "assets/png/home/products.png",
                    background: _color1,
                    onPress: () => appNavPush(context, page: Receipts())),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _homeCard(
                  label: S.of(context).invoices,
                  icon: "assets/png/home/invoice.png",
                  background: _color2,
                  onPress: () {
                    appNavPush(context, page: Invoices());
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _homeCard(
      {String label, String icon, Color background, Function onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(20),
        width: 157,
        // height: 157,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: background ?? const Color(0x15003d86),
        ),
        child: Column(
          children: [
            Image.asset(
              icon,
              width: 70,
              height: 70,
            ),
            SizedBox(height: 22),
            Text(
              '$label',
              style: TextStyle(
                fontFamily: 'Droid Arabic Kufi',
                // fontFamily: 'Droid Arabic Kufi',
                fontSize: 15,
                color: const Color(0xff2a2a2a),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
