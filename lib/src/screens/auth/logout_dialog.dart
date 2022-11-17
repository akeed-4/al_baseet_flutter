import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _con = context.watch<AuthProvider>();
    return AlertDialog(
      contentPadding: appPadding,
      titlePadding: EdgeInsets.zero,
      actionsPadding: appPadding,
      title: Row(
        children: [
          CustomIconBtn(
            icon: Icon(Icons.clear),
            onPress: () => Navigator.pop(context),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/png/intro_lang_icon.png"),
          SizedBox(height: 4),
          Text(
            S.of(context).logout_q,
            style: TextStyle(
              fontFamily: 'Droid Arabic Kufi',
              fontSize: 20,
              color: const Color(0xff0f0f0f),
              letterSpacing: -0.32,
              fontWeight: FontWeight.w700,
              height: 2.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            S.of(context).logout_info,
            style: TextStyle(
              fontFamily: 'Droid Arabic Kufi',
              fontSize: 14,
              color: const Color(0xcc0f0f0f),
              height: 1.7142857142857142,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: AppBtn(
                  text: S.of(context).ok,
                  height: 40,
                  backgroundColor: Colors.red,
                  isLoading: _con.event.loading,
                  onPress: _con.doLogout,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: AppBtn(
                  text: S.of(context).cancel,
                  height: 40,
                  isPlane: true,
                  onPress: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
