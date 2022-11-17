import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/screens/Invoices/invoice_details.dart';
import 'package:al_baseet/src/screens/receipts/create/create_step2.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/shared_widgets/slecting_customer.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReceiptStep1 extends StatefulWidget {
  CustomerModel customer;
  CreateReceiptStep1({@required this.customer});

  @override
  _CreateReceiptStep1State createState() => _CreateReceiptStep1State();
}

class _CreateReceiptStep1State extends State<CreateReceiptStep1> {
  List<InvoiceModel> selectedInvoices = [];

  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<InvoicesProvider>().clear();
      // if(widget.customer!=null)
      context.read<InvoicesProvider>().getInvoices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InvoicesProvider>();
    return CustomScaffold(
      appBar: AppAppBar(
        title: S.of(context).create_receipt,
      ),
      body: Container(
        padding: appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectingCustomer(
              customer: widget.customer,
              onSelected: (selectingCustomer) {
                setState(() {
                  widget.customer = selectingCustomer;
                  context.read<InvoicesProvider>().clear();
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              S.of(context).select_invoices,
              style: TextStyle(
                fontFamily: 'Droid Arabic Kufi',
                fontSize: 14,
                color: const Color(0xff2a2a2a),
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: _selectInvoices()),
            SizedBox(height: 40),
            _provider.selectedInvoices.isNotEmpty
                ? AppBtn(
                    text: S.of(context).next,
                    onPress: () => appNavPush(
                      context,
                      page: CreateReceiptStep2(
                        customer: widget.customer,
                        // selectedInvoices: selectedInvoices,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _selectInvoices() {
    final _provider = context.watch<InvoicesProvider>();

    List<InvoiceModel> _invoices = [];
    _provider.event.data.forEach((element) {
      if (element.customer.id == widget.customer?.id &&
          element.type.isCredit &&
          !element.isPaid &&
          element.approvalState) _invoices.add(element);
    });
    return CustomScaffold(
      isLoading: _provider.event.loading && !_provider.event.refresh,
      body: AppCustomRefresher(
        onRefresh: () => _provider.getInvoices(isRefresh: true),
        child: Container(
          child: _invoices.isEmpty && !_provider.event.loading
              ? NoDataPage()
              : ListView.builder(
                  itemCount: _invoices.length,
                  // itemCount: _provider.event.data.length,
                  itemBuilder: (context, index) {
                    // InvoiceModel invoice = _provider.event.data[index];
                    InvoiceModel invoice = _invoices[index];
                    // if (invoice.isPaid ||
                    //     !invoice.approvalState ||
                    //     invoice.type.isCash) return SizedBox();
                    // if (!invoice.canCreateReceipt) return SizedBox();
                    return AppCardList(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _provider.isChecked(invoice),
                            onChanged: (_) => _provider.onSelect(invoice),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomListTile(
                              onTap: () => appNavPush(
                                context,
                                page: InvoiceDetails(
                                  invoice: invoice,
                                  canEdit: false,
                                ),
                              ),
                              leading: paymentState(
                                  label: "${invoice.type.shortCut.localeName}",
                                  backgroundColor: invoice.type.background,
                                  textColor: invoice.type.txtColor),
                              title: invoiceInfo(
                                  dateSize: 9, nameSize: 11, invoice: invoice),
                              trail: paymentType(
                                  label: invoice.paymentStatus.name.localeName,
                                  backgroundColor:
                                      invoice.paymentStatus.background,
                                  textColor: invoice.paymentStatus.txtColor),
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
}
