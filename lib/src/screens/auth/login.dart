import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/providers/auth/login_povider.dart';
import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_logo.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordShowHide = true;
  @override
  Widget build(BuildContext context) {
    final _con = context.watch<AuthProvider>();
    return CustomScaffold(
      ignoring: _con.event.loading,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .16),
          AppLogo(),
          SizedBox(height: 13),
          Row(
            children: [
              Text(
                '${S.of(context).login}',
                // 'الدخول',
                style: TextStyle(
                  fontFamily: 'Droid Arabic Kufi',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          TextField(
            onChanged: (value) => _con.usernameOnchange(value),
            // onChanged: (String value) {},
            decoration: InputDecoration(
              hintText: S.of(context).user_name,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: _passwordShowHide,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => _con.passwordOnchange(value),
            decoration: InputDecoration(
              hintText: S.of(context).password,
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _passwordShowHide = !_passwordShowHide;
                  });
                },
                child: Icon(
                  _passwordShowHide
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          AppBtn(
            text: S.of(context).login,
            isLoading: _con.event.loading,
            onPress: _con.doLogin,
            // onPress: _con.doLogin,
            // onPress:()=> _con.doLogin(context: context),
            // isPlane: ,
          )
        ],
      ),
    );
  }
}
