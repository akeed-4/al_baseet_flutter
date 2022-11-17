import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/receipts_model.dart';
import 'package:al_baseet/src/providers/receipts_provider.dart';
import 'package:al_baseet/src/screens/Invoices/invoice_details.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/title_text_info.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptDetails extends StatelessWidget {
  final ReceiptsModel receipt;
  ReceiptDetails({@required this.receipt});
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<ReceiptsProvider>();
    return CustomScaffold(
      appBar: AppAppBar(
        title: S.of(context).receipts_details,
      ),
      body: SingleChildScrollView(
        padding: appPadding,
        child: Container(
          padding: EdgeInsets.all(10),
          // height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xffffffff),
            border: Border.all(width: 1.0, color: const Color(0xffc4c2cb)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "# ${receipt.receiptsNo}",
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 20,
                      color: const Color(0xff353333),
                      letterSpacing: -0.3333332824707031,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // paymentType(
                  //     label: receipt.paymentStatus.name,
                  //     backgroundColor: receipt.paymentStatus.background,
                  //     textColor: receipt.paymentStatus.txtColor)
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    receipt.datDate,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 16,
                      color: const Color(0x80353333),
                      letterSpacing: -0.26666668701171875,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    receipt.datTime,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 16,
                      color: const Color(0x80353333),
                      letterSpacing: -0.26666668701171875,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // TitleTextInfo(
              //     title: S.of(context).invoice_no,
              //     text: "${receipt.invoices.length}"),
              // // TitleTextInfo(title: "نوع عملية الدفع", text: "تحويل مالي"),
              // // TitleTextInfo(
              // //     title: S.of(context).deliver_customer,
              // //     text: "${receipt.customer.name}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleTextInfo(
                    title: S.of(context).amount,
                    text: "${receipt.amount}",
                    isBold: true,
                    isCurrency: true,
                  ),
                  TitleTextInfo(
                    title: S.of(context).state,
                    text: "${receipt.getStateName}",
                    // isBold: true,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.invoices,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 16,
                      color: const Color(0x80353333),
                      letterSpacing: -0.26666668701171875,
                    ),
                  ),
                  Text(
                    "${receipt.invoices.length}",
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 16,
                      color: const Color(0xff353333),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              invoices(),
              SizedBox(height: 60),
              receipt.approvalState
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: AppBtn(
                        text: S.of(context).approval_invoice,
                        backgroundColor: Color(0xff0A8754),
                        isLoading: _provider.approveLoading,
                        onPress: () => showAreYouSureDialog(
                          subTitle: S.of(context).approve_receipt_qu,
                          onOK: () =>
                              _provider.approveReceipts(receipt: receipt),
                        ),
                      ),
                    ),
              receipt.approvalState
                  ? SizedBox()
                  : Container(
                      child: AppBtn(
                        text: S.of(context).delete,
                        isPlane: true,
                        backgroundColor: Color(0xffCD3327),
                        isLoading: _provider.deleteLoading,
                        onPress: () => showAreYouSureDialog(
                          subTitle: S.of(context).delete_receipt_qu,
                          onOK: () => _provider.deleteInvoice(receipt: receipt),
                        ),
                      ),
                    ),
              if (receipt.approvalState)
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: AppBtn(
                    text: S.of(context).print,
                    backgroundColor: Colors.blueGrey,
                    isLoading: _provider.printLoading,
                    onPress: () => //_print()
                        _provider.printReceipts(receiptsModel: receipt),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget invoices() {
    return Card(
      elevation: 0,
      color: Color(0xffF8F9FB),
      margin: EdgeInsets.zero,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: receipt.invoices.length,
        itemBuilder: (context, index) =>
            _invoice(receipt.invoices[index], context),
      ),
    );
  }

  Widget _invoice(InvoiceModel invoice, BuildContext context) {
    return AppCardList(
      child: CustomListTile(
          onTap: () => appNavPush(context,
              page: InvoiceDetails(
                invoice: invoice,
                canEdit: false,
              )),
          leading: paymentState(
              label: "${invoice.invoice_name.localeName}",
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
