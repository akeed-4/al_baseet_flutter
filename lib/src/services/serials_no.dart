import 'dart:convert';

import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:flutter/material.dart';

class Serials {
  static Future<double> getLastSerial({@required String type}) async {
    final userData = await StorageHelper.get(StorageKeys.userData);
    Map<String, dynamic> home = json.decode(userData);
    List serials = home['user_invoices_serials'];
    // print("serials ..... $serials");
    double lastSerial;
    serials.forEach((e) {
      if (e["invoice_type"] == type) {
        lastSerial = e["user_last_serial"];
      }
    });
    // print(lastSerial);
    // return lastSerial;
    return lastSerial == 1 ? lastSerial : ++lastSerial;
  }

  static Future saveLastSerial({@required String type}) async {
    final userData = await StorageHelper.get(StorageKeys.userData);
    Map<String, dynamic> home = json.decode(userData);
    List newSerials = home['user_invoices_serials'];

    newSerials = newSerials.map((e) {
      if (e["invoice_type"] == type) {
        e["user_last_serial"]++;
      }
      return e;
    }).toList();
    home["user_invoices_serials"] = newSerials;

    print(home);

    StorageHelper.set(StorageKeys.userData, json.encode(home));
  }
}
