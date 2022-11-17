import 'package:al_baseet/src/utils/storage/storage_helper.dart';
import 'package:al_baseet/src/utils/storage/storage_keys.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool isGirdView = false;
  void loadSettings() async {
    final productView = await StorageHelper.get(StorageKeys.productView);
    isGirdView = productView == null || productView == "1";
    notifyListeners();
  }

  void editView(bool value) {
    isGirdView = value;
    notifyListeners();
    saveProductView(value);
  }

  void saveProductView(bool value) async {
    StorageHelper.set(StorageKeys.productView, value ? "1" : "0");
  }
}
