import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  static String _defaultLangCode = StorageKeys.englishLangCode;
  Locale _appLocale = Locale(StorageKeys.englishLangCode);
  LanguageProvider() {
    initLang();
    print("this was called .......................?>>>>>>>>>>>>>>>>>>>>");
    setLocale();
  }
  void initLang() async {}
  Locale get appLocal => _appLocale ?? Locale(_defaultLangCode);

  void setLocale() async {
    final code = await StorageHelper.get(StorageKeys.languageCode);
    _appLocale = Locale(code ?? _defaultLangCode);
    notifyListeners();
  }

  void changeLanguage(Locale locale) {
    StorageHelper.set(StorageKeys.languageCode, locale.languageCode);
    _appLocale = locale;
    S.load(locale);
    notifyListeners();
  }

  void switchLanguage() async {
    final code = await StorageHelper.get(StorageKeys.languageCode);
    // print("------------------$code ");
    String _newCode = code == StorageKeys.englishLangCode
        ? StorageKeys.arabicLangCode
        : StorageKeys.englishLangCode;
    StorageHelper.set(StorageKeys.languageCode, _newCode);
    // print("------------------ $code");
    _appLocale = Locale(_newCode);
    S.load(Locale(_newCode));
    notifyListeners();
  }

  bool get isArabic => appLocal == Locale(StorageKeys.arabicLangCode);
  String get code => appLocal.languageCode;
}
