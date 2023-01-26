import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/screens/request_products/create_request_products.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/warehouse/products/product_details.dart';

import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestProductsDetails extends StatefulWidget {
  final InvoiceModel invoice;
  final bool canEdit;
  RequestProductsDetails({@required this.invoice, this.canEdit = true});
  @override
  _RequestProductsDetailsState createState() => _RequestProductsDetailsState();
}

class _RequestProductsDetailsState extends State<RequestProductsDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.invoice.date.toLocal());
    // DateTime mm = DateTime.parse("2021-11-08 17:36:38.738131Z");
    print("----------------------------");
    print(DateTime.now().toUtc());
    // print(mm);
    // print(mm.toUtc());
    // print(mm.toLocal());
    print("----------------------------");

    final _provider = context.watch<InvoicesProvider>();
    // final _provider02 = context.watch<WarehouseProvider>();
    return CustomScaffold(
      ignoring: _provider.updateLoading ||
          _provider.deleteLoading | _provider.approveLoading,
      appBar: AppAppBar(
        title: S.of(context).request_products,
        actions: [ SizedBox()],
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
                    "# ${widget.invoice.invoiceNo}",
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 20,
                      color: const Color(0xff353333),
                      letterSpacing: -0.3333332824707031,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // paymentType(
                  //     label: widget.invoice.paymentStatus.name.localeName,
                  //     backgroundColor: widget.invoice.paymentStatus.background,
                  //     textColor: widget.invoice.paymentStatus.txtColor)
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.invoice.datDate}",
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 16,
                      color: const Color(0x80353333),
                      letterSpacing: -0.26666668701171875,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${widget.invoice.datTime}",
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
              SizedBox(height: 25),
              // TitleTextInfo(title: "الحالة", text: "نجاح"),
              _products(),
              // SizedBox(height: 10),
              SizedBox(height: 60),
              widget.canEdit ? _actions() : SizedBox(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actions() {
    final _provider = context.watch<InvoicesProvider>();
    return Column(
      children: [
        widget.invoice.approvalState
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: AppBtn(
                    text: S.of(context).update,
                    // isLoading: _provider.deleteLoading,
                    onPress: () {
                      appNavPush(
                        context,
                        page: CreateRequestProducts(
                          isUpdate: true,
                          invoice: widget.invoice,
                        ),
                      );
                    }),
              ),
        // !widget.invoice.approvalState && !widget.invoice.type.canReturn
        //     ? SizedBox()
        //     : Container(
        //         margin: EdgeInsets.only(bottom: 20),
        //         child: AppBtn(
        //           text: S.of(context).return_invoice,
        //           isLoading: _provider.updateLoading,
        //           onPress: () => appNavPush(
        //             context,
        //             page: CreateInvoice(
        //               isUpdate: true,
        //               isReturn: true,
        //               invoice: widget.invoice,
        //             ),
        //           ),
        //         ),
        //       ),
        widget.invoice.approvalState
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: AppBtn(
                    text: S.of(context).approval_invoice,
                    backgroundColor: Color(0xff0A8754),
                    isLoading: _provider.approveLoading,
                    onPress: () => showAreYouSureDialog(
                          subTitle: S.of(context).approve_request_products_qu,
                          onOK: () =>
                              _provider.approveInvoice(invoice: widget.invoice),
                        )
                    // _provider.approveInvoice(invoice: widget.invoice),
                    ),
              ),
        !widget.invoice.approvalState
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: AppBtn(
                  text: S.of(context).print,
                  backgroundColor: Colors.blueGrey,
                  isLoading: _provider.printLoading,
                  onPress: () => _print()
                ),
              ),
        widget.invoice.approvalState
            ? SizedBox()
            : Container(
                child: AppBtn(
                    text: S.of(context).delete,
                    isPlane: true,
                    backgroundColor: Color(0xffCD3327),
                    isLoading: _provider.deleteLoading,
                    onPress: () => showAreYouSureDialog(
                          subTitle: S.of(context).delete_request_products_qu,
                          onOK: () =>
                              _provider.deleteInvoice(invoice: widget.invoice),
                        )
                    // _provider.deleteInvoice(invoice: widget.invoice),
                    ),
              ),
      ],
    );
  }

  void _print() {
    final _provider = context.read<InvoicesProvider>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              // leading: Icon(Icons.share),
              onTap: () => _provider.printRequestProducts(invoice: widget.invoice),
              title: Text(S.of(context).request_products),
            ),
          ],
        );
      },
    );
  }

  Widget _products() {
    List<InvoiceProductModel> _products = widget.invoice.products;
    TextStyle textStyle = TextStyle(
      fontFamily: 'Droid Arabic Kufi',
      fontSize: 14,
      color: const Color(0xffafafaf),
      letterSpacing: -0.23333329772949218,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).products,
          style: textStyle,
        ),
        SizedBox(height: 10),
        ...List.generate(
          _products.length,
          (index) => Container(
            child: AppCardList(
              background: Color(0xffF8F9FB),
              child: CustomListTile(
                onTap: () => appNavPush(
                  context,
                  page: ProductDetails(
                    product: _products[index].product,
                  ),
                ),
                leading: CustomRoundImage(
                  imageUrl: "${_products[index].product.image}",
                  width: 40,
                  height: 40,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Adobe XD layer: 'Cloud Ear Pink' (text)
                    Text(
                      '${_products[index].product.name.localeName}',
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 15,
                        color: const Color(0xff003d86),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: S.of(context).quantity,
                            style: TextStyle(
                              fontFamily: 'Droid Arabic Kufi',
                              fontSize: 11,
                              color: const Color(0xff7f8e9d),
                              // fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "${_products[index].quantity}",
                            style: TextStyle(
                              fontFamily: 'Droid Arabic Kufi',
                              fontSize: 11,
                              color: const Color(0xff7f8e9d),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // trail: // Adobe XD layer: '$282' (text)
                //     CurrencyWidget(
                //   amount: _products[index].price,
                //   fontWeight: FontWeight.w700,
                //   amountColor: Color(0xff003d86),
                //   fontSize: 19,
                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
