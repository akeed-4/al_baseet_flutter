import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/receipts_model.dart';
import 'package:al_baseet/src/providers/receipts_provider.dart';
import 'package:al_baseet/src/screens/receipts/create/create_step1.dart';
import 'package:al_baseet/src/screens/receipts/receipt_details.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Receipts extends StatefulWidget {
  @override
  _ReceiptsState createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<ReceiptsProvider>().getReceipts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<ReceiptsProvider>();
    return CustomScaffold(
      appBar: AppAppBar(
        title: S.of(context).receipts,
        actions: [
          Container(
            child: AppBtn(
              text: S.of(context).create_receipt,
              height: 40,
              onPress: () => appNavPush(context, page: CreateReceiptStep1(customer: null,)),
            ),
          ),
        ],
      ),
      isLoading: _provider.event.loading && !_provider.event.refresh,
      body: AppCustomRefresher(
        onRefresh: () => _provider.getReceipts(isRefresh: true),
        child: _provider.event.isHasNoData
            ? NoDataPage()
            : ListView.builder(
                padding: appPadding,
                itemCount: _provider.event.data.length,
                itemBuilder: (context, index) {
                  return _receipt(_provider.event.data[index]);
                },
              ),
      ),
    );
  }

  Widget _receipt(ReceiptsModel receipt) {
    return AppCardList(
      background: receipt.approvalState ? null : Colors.deepOrangeAccent[100],
      child: CustomListTile(
        onTap: () => appNavPush(
          context,
          page: ReceiptDetails(
            receipt: receipt,
          ),
        ),
        // leading: paymentState(
        //     label: "${receipt.type.name}",
        //     backgroundColor: receipt.type.background,
        //     textColor: receipt.type.txtColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "# ${receipt.receiptsNo}",
              style: TextStyle(
                fontFamily: 'Droid Arabic Kufi',
                fontSize: 15,
                color: const Color(0xff003d86),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              receipt.datDate,
              style: TextStyle(
                fontFamily: 'Droid Arabic Kufi',
                fontSize: 11,
                color: const Color(0xff7f8e9d),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        trail: // Adobe XD layer: '$ 150.00' (text)
            CurrencyWidget(
          amount: receipt.amount,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
