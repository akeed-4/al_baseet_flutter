import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/invoice_type.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/screens/Invoices/create_invoice.dart';
import 'package:al_baseet/src/screens/Invoices/invoice_details.dart';
import 'package:al_baseet/src/screens/receipts/receipts.dart';
import 'package:al_baseet/src/screens/shared_widgets/add_new.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Invoices extends StatefulWidget {
  @override
  _InvoicesState createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<InvoicesProvider>().getInvoices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InvoicesProvider>();
    return CustomScaffold(
      appBar: AppAppBar(
        title: S.of(context).invoices,
        actions: [
          _provider.event.isHasNoData
              ? Container(
                  child: AppBtn(
                    text: S.of(context).create_invoice,
                    height: 40,
                    onPress: () => appNavPush(context, page: CreateInvoice()),
                  ),
                )
              : Container(
                  child: AppBtn(
                    text: S.of(context).receipts,
                    height: 40,
                    onPress: () => appNavPush(context, page: Receipts()),
                  ),
                )
        ],
      ),
      isLoading: _provider.event.loading && !_provider.event.refresh,
      // body: NoDataPage(),
      body: AppCustomRefresher(
        onRefresh: () => _provider.getInvoices(isRefresh: true),
        child: _provider.event.isHasNoData
            ? NoDataPage()
            : ListView.builder(
                padding: appPadding,
                itemCount: _provider.event.data.length + 1,
                // itemCount: _provider.event.data.length,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return AddNew(
                      label: S.of(context).new_invoice,
                      onPress: () => appNavPush(context, page: CreateInvoice()),
                    );
                  return _invoice(_provider.event.data[index - 1]);
                },
              ),
      ),
    );
  }

  Widget _invoice(InvoiceModel invoice) {
    return AppCardList(
      background: invoice.approvalState ? null : Colors.deepOrangeAccent[100],
      child: CustomListTile(
          onTap: () => appNavPush(context,
              page: InvoiceDetails(
                invoice: invoice,
              )),
          leading: paymentState(
              label: "${invoice.invoice_name.localeName}",
              // label: "${invoice.type.shortCut.localeName}",
              backgroundColor: invoice.type.background,
              textColor: invoice.type.txtColor),
          title: invoiceInfo(invoice: invoice),
          trail: paymentType(
              label: invoice.paymentStatus.name.localeName,
              backgroundColor: invoice.paymentStatus.background,
              textColor: invoice.paymentStatus.txtColor)),
    );
  }
}
