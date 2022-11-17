import 'package:al_baseet/src/models/request_model.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/utils/http/http_helper.dart';

class CustomerRepo {
  Future<ResponseModel> getCustomers({Function() callBack,String invoiceType="002"}) async {
    return await HttpHelper.requestMaker(
      requestModel: RequestModel(
        url: "/customers/get_customers/$invoiceType",
        isAuth: true,
        callBack: callBack,
      ),
    );
  }

  // Future<ResponseModel> getCustomers2() async {
  //   await Future.delayed(Duration(seconds: 5));
  //   return ResponseModel();
  //   return await HttpHelper.requestMaker(
  //     requestModel: RequestModel(
  //       url: "https://jsonplaceholder.typicode.com/posts",
  //       isDefaultServerUrl: false,
  //       // isAuth: true,
  //     ),
  //   );
  // }
}
