import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:provider/provider.dart';

class NameModel {
  String en;
  String ar;

  NameModel({
    this.en,
    this.ar,
  });
  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        en: json["en"] ?? json["ar"]??"UnKnown",
        ar: json["ar"] ??json["en"]?? "غير معروف",
      );
  String get localeName =>
      navigatorKey.currentContext.read<LanguageProvider>().isArabic
          ? ar ?? en
          : en ?? ar;
}
