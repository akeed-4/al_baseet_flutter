import 'dart:convert';

import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/company_model.dart';
import 'package:al_baseet/src/models/event_source.dart';
import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/models/user_model.dart';
import 'package:al_baseet/src/providers/base/base_provider.dart';
import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/screens/auth/login.dart';
import 'package:al_baseet/src/screens/home/home_page.dart';
import 'package:al_baseet/src/screens/intro/intro_lang.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
import 'package:al_baseet/src/services/networks/auth/auth_repo.dart';
import 'package:al_baseet/src/utils/http/http_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends BaseProvider<UserModel> {
  UserModel userModel = UserModel();
  final AuthRepo _repo = AuthRepo();

  void loadLocalUserInfo() async {
    final userData = await StorageHelper.get(StorageKeys.userData);
    Map<String, dynamic> home = json.decode(userData);

    // print();

    String cName = await StorageHelper.get(StorageKeys.companyName);
    String cTaxId = await StorageHelper.get(StorageKeys.companyTaxId);
    String cAddress = await StorageHelper.get(StorageKeys.companyAddress);
    String cPhone = await StorageHelper.get(StorageKeys.companyPhone);
    String cFax = await StorageHelper.get(StorageKeys.companyFax);
    userModel = UserModel.fromJson(home);
    userModel.company = CompanyModel(
      companyName: cName,
      companyTaxId: cTaxId,
      companyAddress: cAddress,
      companyPhone: cPhone,
      companyFax: cFax,
    );
    notifyListeners();
  }

  void doLogin() async {
    print("user name:  ${userModel.userName} pass: ${userModel.password}");
    FocusScope.of(navigatorKey.currentContext).unfocus();
    if (userModel.userName.trim().isEmpty ||
        userModel.password.trim().isEmpty) {
      CustomToast.showToast(
          S.of(navigatorKey.currentContext).please_fill_field);
      return;
    }
    setEvent(EventSource(loading: true));
    // await Future.delayed(Duration(seconds: 2));
    ResponseModel response = await _repo.doLogin(
      username: userModel.userName.trim(),
      password: userModel.password.trim(),
      lang: navigatorKey.currentContext.read<LanguageProvider>().code,
      callBack: () => doLogin(),
    );
    setEvent(EventSource(loading: false));
    print(response.errorCode.toString() + " ........ error code ");
    if (!response.status && response.isDataValid) {
      // CustomToast.showToast("العميل غير موجود او كلمة المرور غير صحيحة ");
      // showCustomDialog(
      //   logo: Icon(
      //     Icons.warning_amber_outlined,
      //     color: Colors.redAccent,
      //     size: 80,
      //   ),
      //   info: "العميل غير موجود او كلمة المرور غير صحيحة حاول مرة اخرى.",
      // );
      return;
    } else {
      StorageHelper.set(StorageKeys.token, response.data['access_token']);
      StorageHelper.set(StorageKeys.auth, "AUTHENTIC");

      String cName = response.data['company_name'];
      String cTaxId = response.data['company_tax_id'];
      String cAddress = response.data['company_address'];
      String cPhone = response.data['company_phone'];
      String cFax = response.data['company_fax'];

      await StorageHelper.set(StorageKeys.companyName, cName);
      await StorageHelper.set(StorageKeys.companyTaxId,cTaxId);
      await StorageHelper.set(StorageKeys.companyAddress, cAddress);
      await StorageHelper.set(StorageKeys.companyPhone, cPhone);
      await StorageHelper.set(StorageKeys.companyFax, cFax);
      StorageHelper.set(
          StorageKeys.userData, json.encode(response.data['user_data']));
      userModel = UserModel.fromJson(response.data['user_data']);
      userModel.company = CompanyModel(
        companyName: cName,
        companyTaxId: cTaxId,
        companyAddress: cAddress,
        companyPhone: cPhone,
        companyFax: cFax,
      );
      notifyListeners();
      appNavPushReplacement(navigatorKey.currentContext, page: HomePage());
    }
  }

  void doLogout() async {
    print("do logout .....");
    setEvent(EventSource(loading: true));
    // await Future.delayed(Duration(seconds: 2));
    ResponseModel response = await _repo.doLogout(
      callBack: () => doLogin(),
    );
    setEvent(EventSource(loading: false));

    // CustomToast.showToast(response.message);
    // // doLogoutLocal();
    // StorageHelper.clear();
    // // doLogoutLocal();
    if (response.status) {
      CustomToast.showToast(response.message);
      // doLogoutLocal();
    }
    Navigator.pop(navigatorKey.currentContext);
    doLogoutLocal();
  }

  void usernameOnchange(String value) => this.userModel.userName = value;
  void passwordOnchange(String value) => this.userModel.password = value;

  void doLogoutLocal() async {
    StorageHelper.clear();
    userModel = UserModel();
    appNavPushReplacement(navigatorKey.currentContext, page: Login());
  }
}
