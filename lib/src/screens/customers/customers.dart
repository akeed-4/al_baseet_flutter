import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/invoice_type.dart';
import 'package:al_baseet/src/providers/customer_provider.dart';
import 'package:al_baseet/src/screens/customers/customer_deatails.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_circ_progress.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/shared_widgets/search.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Customers extends StatefulWidget {
  bool isSelecting;
  CustomerModel selectingCustomer;
  Function(CustomerModel) onSelected;
  final String invoiceType;

  Customers(
      {this.isSelecting = false,
      this.selectingCustomer,
      this.onSelected,
      this.invoiceType = "002"});
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  void initState() {
    Future.delayed(Duration(), () {
      context
          .read<CustomerProvider>()
          .getCustomers(invoiceType: widget.invoiceType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<CustomerProvider>();
    return WillPopScope(
      onWillPop: () async {
        _provider.runFilter('');
        return true;
      },
      child: CustomScaffold(
        ignoring: widget.isSelecting &&
            (_provider.event.loading && !_provider.event.refresh),
        floatActionBtn: widget.isSelecting
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: FloatingActionButton(
                      child: Icon(Icons.arrow_forward_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              )
            : SizedBox(),
        appBar: AppAppBar(
          title: S.of(context).customers,
        ),
        isLoading: _provider.event.loading && !_provider.event.refresh,
        body: AppCustomRefresher(
          onRefresh: () => _provider.getCustomers(isRefresh: true),
          child: !_provider.event.loading && _provider.event.data.length == 0
              ? NoDataPage()
              : ListView.builder(
                  padding: appPadding,
                  itemCount: _provider.filteredCustomers.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: CustomSearch(
                          label: S.of(context).search_customer,
                          onValueChange: _provider.runFilter,
                        ),
                      );
                    index--;
                    CustomerModel customer = _provider.filteredCustomers[index];
                    return AppCardList(
                      child: Row(
                        children: [
                          widget.isSelecting
                              ? Checkbox(
                                  value: widget.selectingCustomer?.id ==
                                      customer?.id,
                                  onChanged: (bool value) {
                                    if (widget.selectingCustomer == customer) {
                                      widget.selectingCustomer = null;
                                      widget.onSelected(null);
                                    } else {
                                      widget.selectingCustomer = customer;
                                      widget.onSelected(customer);
                                    }

                                    setState(() {});
                                  },
                                )
                              : SizedBox(),
                          Expanded(
                            child: CustomListTile(
                              onTap: () => appNavPush(
                                context,
                                page: CustomerDetails(
                                  customerModel:
                                      _provider.filteredCustomers[index],
                                ),
                              ),
                              leading: CustomRoundImage(
                                imageUrl:
                                    '${_provider.filteredCustomers[index].userImage}',
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_provider.filteredCustomers[index].name.localeName}',
                                    // maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Droid Arabic Kufi',
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "${_provider.filteredCustomers[index].address}",
                                    // maxLines: 2,
                                    // overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'Droid Arabic Kufi',
                                      fontSize: 13,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                              trail: Row(
                                children: [
                                  // _info(
                                  //     label: S.of(context).collected,
                                  //     info:
                                  //         '${currencyFormat01(_provider.filteredCustomers[index].receipts)}'),
                                  // // _info(label: "المحصل", info: "350"),
                                  // SizedBox(width: 20),
                                  _info(
                                      label: S.of(context).invoice,
                                      info:
                                          "${_provider.filteredCustomers[index].invoices}"),
                                  // _info(label: "فاتوره", info: "15"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _loading() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => AppCardList(
        child: CustomListTile(
          leading: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            direction: ShimmerDirection.rtl,
            loop: 100,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                // boxShadow: Constants.lightShadow
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                direction: ShimmerDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  height: 10,
                  width: 100,
                ),
              ),
              SizedBox(height: 10),
              Shimmer.fromColors(
                direction: ShimmerDirection.rtl,
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  height: 8,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: AppCardList(
            child: CustomListTile(
              leading: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // boxShadow: Constants.lightShadow
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'خالد حسين',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 15,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'شارع الستين',
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 13,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),
              trail: Row(
                children: [
                  _info(label: "فاتوره", info: "15"),
                  SizedBox(width: 20),
                  _info(label: "المحصل", info: "350"),
                ],
              ),
            ),
          )),
    );
  }

  Widget _info({String label, String info}) {
    return Column(
      children: [
        Text(
          '$info',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 20,
            color: const Color(0xff2c2e78),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 1),
        Text(
          '$label',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 8,
            color: const Color(0xff5c5c5c),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
