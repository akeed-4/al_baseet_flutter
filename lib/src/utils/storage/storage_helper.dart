import 'package:al_baseet/src/screens/auth/login.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static SharedPreferences _prefs;

  static Future _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future<String> get(String key) async {
    await _getInstance();
    return _prefs.getString(key);
  }

  static Future set(String key, dynamic value) async {
    await _getInstance();
   await _prefs.setString(key, value);
  }

  static void remove(String key) async {
    await _getInstance();
    _prefs.remove(key);
  }

  static void clear() async {
   await _getInstance();
    _prefs.clear();
    appNavPush(navigatorKey.currentContext, page: Login());
  }

  // static void savePayloadInfo(Map<String ,dynamic> payload)  {
  //   StorageHelper.set(StorageKeys.userId, payload['uid']);
  //   StorageHelper.set(StorageKeys.phone, "+${payload['phone']}");
  //   StorageHelper.set(StorageKeys.userFullName, payload['fullName']);
  //   StorageHelper.set(StorageKeys.userProfileImage, payload['photo']);
  // }
}
