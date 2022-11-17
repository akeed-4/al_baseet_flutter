import 'dart:developer';

import 'package:al_baseet/src/screens/home/slide_drawer.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_circ_progress.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final AppAppBar appBar;
  final Widget body;
  final bool ignoring;
  final bool isLoading;
  final floatActionBtn;
  final Function onWillPopUp;

  CustomScaffold({
    this.appBar,
    this.body,
    this.ignoring = false,
    this.isLoading = false,
    this.floatActionBtn,
    this.onWillPopUp,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IgnorePointer(
        ignoring: ignoring,
        child: Scaffold(
          floatingActionButton: floatActionBtn ?? SizedBox(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Container(
            child: Column(
              children: [
                appBar ?? SizedBox(),
                // SizedBox(height: appBar == null ? 0 : 10),
                Expanded(
                  child: Container(
                    // color: Colors.blueGrey,
                    child: Stack(
                      children: [
                        Positioned.fill(child: body ?? SizedBox()),
                        Align(
                          alignment: Alignment.topCenter,
                          child: isLoading
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                  ),
                                  // color: Colors.red,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
