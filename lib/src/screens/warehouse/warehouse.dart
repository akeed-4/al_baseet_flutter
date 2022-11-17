import 'dart:io';

import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/search.dart';
import 'package:al_baseet/src/screens/warehouse/history.dart';
import 'package:al_baseet/src/screens/warehouse/processes/processes.dart';
import 'package:al_baseet/src/screens/warehouse/products/products.dart';

import 'package:flutter/material.dart';

class Warehouse extends StatefulWidget {
  @override
  _WarehouseState createState() => _WarehouseState();
}

class _WarehouseState extends State<Warehouse> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppAppBar(
        title: S.of(context).warehouse, //
        actions: _actions(),
      ),
      body: Products(),
    );
  }
  // Widget
  // Widget

  List<Widget> _actions() {
    List<Widget> actions = [
      InkWell(
        onTap: () => appNavPush(context, page: History()),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
            color: const Color(0xff2c2e78),
          ),
          child: Center(
            child: Image.asset("assets/png/history.png", width: 20, height: 20),
          ),
        ),
      ),
      SizedBox(width: 15),
      InkWell(
        onTap: () => appNavPush(context, page: Processes()),
        child: Container(
          width: 55,
          height: 55,
          // color: Colors.yellow,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xff2c2e78),
                  ),
                  child: Center(
                    child: Image.asset("assets/png/bag.png",
                        width: 20, height: 20),
                  ),
                ),
              ),
              // Positioned(
              //   top: -1,
              //   right: -1,
              //   child: Container(
              //     padding: EdgeInsets.all(5),
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: const Color(0xffcd3327),
              //       border:
              //           Border.all(width: 2.0, color: const Color(0xfff8f9fb)),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "1",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 12,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    ];
    return actions;
  }
}
