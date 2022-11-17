import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/history_model.dart';
import 'package:al_baseet/src/models/report_model.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/warehouse/products/product_details.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reports extends StatefulWidget {
  final String title;
  Reports({this.title});
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<WarehouseProvider>().getReports();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    return CustomScaffold(
      appBar: AppAppBar(
        title: widget.title ?? "${S.of(context).history}",
      ),
      isLoading: _provider.reportLoading,
      body: AppCustomRefresher(
          onRefresh: () => _provider.getReports(isRefresh: true),
          child: !_provider.reportLoading &&
                  _provider.report.transactions.isEmpty
              ? NoDataPage()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _provider.report.transactions.length,
                        itemBuilder: (context, index) {
                          TransactionModel transaction =
                              _provider.report.transactions[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: appPadding01, vertical: 10),
                            margin: EdgeInsets.only(bottom: 10),
                            // margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 1.5)),
                              // color: Colors.black12,
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    _info(
                                        title: "${transaction.datDate}",
                                        info: transaction.datTime),
                                    SizedBox(width: 10),
                                    CustomRoundImage(
                                      imageUrl: transaction.customer.userImage,
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      // onTap: () => appNavPush(context,
                                      //     page: ProductDetails(
                                      //       product: history.product.product,
                                      //     )),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // maina: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            transaction
                                                .customer.name.localeName,
                                            style: TextStyle(
                                              fontFamily: 'Droid Arabic Kufi',
                                              fontSize: 10,
                                              color: const Color(0xff140f26),
                                              fontWeight: FontWeight.w700,
                                              height: 0.9,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              // Adobe XD layer: 'type' (text)
                                              Text(
                                                transaction
                                                    .invoiceName.localeName,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Droid Arabic Kufi',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff6c7b8a),
                                                  height: 0.75,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                _info(
                                    title:
                                        "${currencyFormat(transaction.amount)}",
                                    info: S.of(context).currency_rs),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    if (_provider.report.totals.isNotEmpty) _totals(),
                  ],
                )),
    );
  }

  Widget _totals() {
    final _provider = context.watch<WarehouseProvider>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: appPadding01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${S.current.totals}:',
            style: TextStyle(
              fontFamily: 'Droid Arabic Kufi',
              fontSize: 14,
              color: const Color(0xff140f26),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Table(
            children: [
              for (TotalsModel item in _provider.report.totals)
                TableRow(
                  children: [
                    Text(
                      item.invoiceName.localeName,
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 14,
                        color: const Color(0xff140f26),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${currencyFormat(item.amount)} ${S.current.currency_rs}",
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 14,
                        color: const Color(0xff140f26),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }

  Widget _info({String title, String info}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$title',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 14,
            color: const Color(0xff140f26),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$info',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 12,
            color: const Color(0xff6c7b8a),
          ),
        ),
      ],
    );
  }
}
