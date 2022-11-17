import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/providers/receipts_provider.dart';
import 'package:al_baseet/src/screens/Invoices/invoice_details.dart';
import 'package:al_baseet/src/screens/receipts/create/edit_amount.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/slecting_customer.dart';
import 'package:al_baseet/src/screens/shared_widgets/title_text_info.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReceiptStep2 extends StatefulWidget {
  CustomerModel customer;
  CreateReceiptStep2({@required this.customer});
  // List<InvoiceModel> selectedInvoices = [];
  // CreateReceiptStep2({@required this.selectedInvoices});
  @override
  _CreateReceiptStep2State createState() => _CreateReceiptStep2State();
}

class _CreateReceiptStep2State extends State<CreateReceiptStep2> {
  InvoicesProvider _provider;
  @override
  Widget build(BuildContext context) {
    _provider = context.watch<InvoicesProvider>();
    final _provider02 = context.watch<ReceiptsProvider>();
    return CustomScaffold(
      ignoring: _provider02.loading,
      floatActionBtn: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: AppBtn(
          text: S.of(context).create,
          isLoading: _provider02.loading,
          onPress: () =>
              _provider02.createReceipt(invoices: _provider.selectedInvoices),
        ),
      ),
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
              isEditable: false,
              onSelected: (selectingCustomer) {
                setState(() {
                  widget.customer = selectingCustomer;
                  context.read<InvoicesProvider>().clear();
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).edit_invoices,
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 14,
                    color: const Color(0xff2a2a2a),
                  ),
                ),
                Text(
                  "${_provider.selectedInvoices.length}",
                  style: TextStyle(
                    fontFamily: 'Droid Arabic Kufi',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff2a2a2a),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(child: _editInvoices()),
            SizedBox(height: 23),
            TitleTextInfo(
              title: S.of(context).total,
              text:
                  "${InvoiceModel.getTotalAmount(_provider.selectedInvoices)}",
              isCurrency: true,
            ),
            SizedBox(height: 30),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _editInvoices() {
    TextStyle textStyle = TextStyle(
      fontFamily: 'Droid Arabic Kufi',
      fontSize: 14,
      color: const Color(0xff353333),
      // letterSpacing: -0.26666668701171875,
      fontWeight: FontWeight.w700,
    );
    return Container(
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: _provider.selectedInvoices.length,
        itemBuilder: (context, index) {
          InvoiceModel invoice = _provider.selectedInvoices[index];
          return AppCardList(
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
                textColor: invoice.type.txtColor,
              ),
              title: invoiceInfo(dateSize: 9, nameSize: 11, invoice: invoice),
              trail: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _deleteInvoice(invoice),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (ctx) {
                        return EditInvoiceAmount(invoice: invoice);
                      },
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                              width: 1.0,
                              color: const Color(0xffeef1f7),
                            ),
                          ),
                          child: Text(
                            '${currencyFormat(invoice.editAmount)}',
                            style: textStyle,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          S.current.currency_rs,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _deleteInvoice(InvoiceModel invoice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomIconBtn(
        size: 40,
        icon: Icon(Icons.delete, color: Colors.red),
        onPress: () => showAreYouSureDialog(
          title: S.of(context).delete_invoice_qu,
          subTitle: S.of(context).delete_invoice_info,
          onOK: () {
            _provider.removeItem(invoice);
            if (_provider.selectedInvoices.isEmpty) Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
