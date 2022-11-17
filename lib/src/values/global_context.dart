import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final navigatorKey = GlobalKey<NavigatorState>();

String randomImage({bool isUser = false, int index}) {
  return isUser
      ? "https://randomuser.me/api/portraits/men/${index ?? (Random().nextInt(10) + 1)}.jpg"
      : "https://picsum.photos/${Random().nextInt(100) + 1}";
}

String currencyFormat(var currency) {
  currency = currency.toString().trim();
  try {
    double dem = double.parse(currency);
    final oCcy = new NumberFormat("#,##0.00", "en_US");
    return oCcy.format(dem);
  } catch (e) {
    print(e);
    return currency;
  }
}

String currencyFormat01(var currency) {
  currency = currency.toString();
  try {
    double dem = double.parse(currency);
    final oCcy = new NumberFormat("#,##0.0", "en_US");
    return oCcy.format(dem);
  } catch (e) {
    print(e);
    return currency;
  }
}
