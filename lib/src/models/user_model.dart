import 'package:al_baseet/src/models/company_model.dart';
import 'package:al_baseet/src/screens/shared_widgets/showToast.dart';
import 'package:al_baseet/src/values/global_context.dart';

class UserModel {
  int id;
  String name;
  String address;
  String imageUrl;
  String userName;
  String password;
  CompanyModel company;
  UserModel(
      {this.id,
      this.name,
      this.address,
      this.imageUrl,
      this.password,
      this.company,
      this.userName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel userModel = UserModel();

    userModel = UserModel(
      id: json["user_id"] ?? 0,
      name: json["user_name"] ?? "غير معروف",
      address: json["address"] ?? "Address",
      imageUrl: json["img_url"] ??
          randomImage(
            isUser: true,
            index: json["user_id"],
          ), //link to default url
      userName: json["userName"] ?? "00",
      password: json["password"] ?? "00",
    );

    return userModel;
  }
  // Map<String, dynamic> toJson() => {
  //       "lang": id == null ? null : id,
  //     };
}
