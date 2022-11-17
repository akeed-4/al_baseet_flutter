import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/providers/common/language_provider.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:provider/provider.dart';

class ResponseModel {
  int errorCode;
  bool status;
  String message;
  dynamic data;
  ResponseModel({
    this.message = "",
    this.status = false,
    this.errorCode = 100,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    var model = ResponseModel();
    model.status = json["status"];
    model.errorCode = json["error_code"] ?? 100;

    String code = Provider.of<LanguageProvider>(navigatorKey.currentContext,
            listen: false)
        .code;
    model.message=json["message"][code];
    model.data = json["data"] ?? {};
    return model;
  }
  factory ResponseModel.fromMap(Map<String, dynamic> json) {
    var model = ResponseModel();
    model.status = json["status"];
    model.errorCode = json["error_code"] ?? 100;
    model.message = json["message"] as String;
    model.data = json["data"];
    return model;
  }

  bool get isValid => status && data != null;
  bool get isDataValid => data != null;

  @override
  String toString() {
    return "$status , $status, $message $data";
  }
}
