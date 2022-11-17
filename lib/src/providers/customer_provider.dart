import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/event_source.dart';
import 'package:al_baseet/src/models/response_model.dart';
import 'package:al_baseet/src/providers/base/base_provider.dart';
import 'package:al_baseet/src/services/networks/customer_repo.dart';

class CustomerProvider extends BaseProvider<CustomerModel> {
  CustomerRepo repo = CustomerRepo();
  List<CustomerModel> filteredCustomers = [];
  CustomerProvider() {
    setEvent(EventSource(loading: true, data: []));
  }
  Future getCustomers(
      {bool isRefresh = false, String invoiceType = "002"}) async {
    print("mmmmm $invoiceType mmmmm");
    setEvent(EventSource(loading: true, refresh: isRefresh, data: event.data));
    await Future.delayed(Duration(seconds: 5));

    ResponseModel response = await repo.getCustomers(
        callBack: () => getCustomers(invoiceType: invoiceType),
        invoiceType: invoiceType);
    if (response.status) {
      setEvent(EventSource(
          loading: false, data: CustomerModel.toListOfModel(response.data)));

      filteredCustomers = event.data;
      return;
    }
    setEvent(EventSource(loading: false, data: event.data));
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      filteredCustomers = event.data;
    } else {
      filteredCustomers = event.data
          .where((customer) =>
              customer.name.en
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              customer.name.ar
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    notifyListeners();
  }
}
