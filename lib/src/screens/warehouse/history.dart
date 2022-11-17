import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/history_model.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/warehouse/products/product_details.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  final String title;
  History({this.title});
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<WarehouseProvider>().getHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    return CustomScaffold(
      appBar: AppAppBar(
        title: widget.title??"${S.of(context).history}",
      ),
      isLoading:
          _provider.historyEvent.loading && !_provider.historyEvent.refresh,
      body: AppCustomRefresher(
        onRefresh: () => _provider.getHistory(isRefresh: true),
        child: !_provider.historyEvent.loading &&
                _provider.historyEvent.data.length == 0
            ? NoDataPage()
            : ListView.builder(
                itemCount: _provider.historyEvent.data.length,
                itemBuilder: (context, index) {
                  HistoryModel history = _provider.historyEvent.data[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: appPadding01, vertical: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    // margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black12, width: 1.5)),
                      // color: Colors.black12,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _info(
                                title: "${history.invoice.datDate}",
                                info: history.invoice.datTime),
                            SizedBox(width: 10),
                            CustomRoundImage(
                              imageUrl: history.product.product.image,
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () => appNavPush(context,
                                  page: ProductDetails(
                                    product: history.product.product,
                                  )),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // maina: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    history.product.product.name.localeName,
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
                                      Icon(
                                        history.isPlus
                                            ? Icons.arrow_downward_outlined
                                            : Icons.arrow_upward_outlined,
                                        size: 15,
                                        color: history.isPlus
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      SizedBox(width: 4),
                                      // Adobe XD layer: 'type' (text)
                                      Text(
                                        history.invoice.invoice_name.localeName,
                                        style: TextStyle(
                                          fontFamily: 'Droid Arabic Kufi',
                                          fontSize: 12,
                                          color: const Color(0xff6c7b8a),
                                          height: 0.75,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
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
                            title: "${history.getQuantity}",
                            info: S.of(context).products),
                      ],
                    ),
                  );
                }),
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
            fontSize: 12,
            color: const Color(0xff140f26),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$info',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 14,
            color: const Color(0xff6c7b8a),
          ),
        ),
      ],
    );
  }
}
