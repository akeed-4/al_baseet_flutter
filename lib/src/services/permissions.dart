import 'dart:convert';

import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:flutter/material.dart';

class Permissions {
  static Future<bool> getPermission({@required String permissionName}) async {
    final userData = await StorageHelper.get(StorageKeys.userData);
    Map<String, dynamic> home = json.decode(userData);
    List permissionList = home['user_permissions'];
    bool permission = false;
    permissionList.forEach((e) {
      if (e["permission_name"] == permissionName) {
        permission = e["permission_value"];
      }
    });
    // print(lastSerial);
    // return lastSerial;
    return permission;
  }
}
