import 'dart:developer';

import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/invoice_type.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/add_new.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/slecting_customer.dart';
import 'package:al_baseet/src/screens/warehouse/products/edit_product_quntiy.dart';
import 'package:al_baseet/src/screens/warehouse/products/products.dart';
import 'package:al_baseet/src/screens/warehouse/warehouse.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRequestProducts extends StatefulWidget {
  final bool isUpdate;
  final InvoiceModel invoice;
  CreateRequestProducts({this.isUpdate = false, this.invoice});
  @override
  _CreateRequestProductsState createState() => _CreateRequestProductsState();
}

class _CreateRequestProductsState extends State<CreateRequestProducts> {
  InvoiceModel creatingInvoice =
      InvoiceModel(type: InvoiceType.requestproducts, products: []);

  TextStyle textStyle = TextStyle(
    fontFamily: 'Droid Arabic Kufi',
    fontSize: 13,
    color: const Color(0xffb1bac9),
    letterSpacing: -0.21666663360595703,
  );
  String typeValue = "cash";

  @override
  void initState() {
    if (widget.isUpdate) {
      print("is update....");
      creatingInvoice.copy(widget.invoice);
      Future.delayed(
        Duration(),
        () {
          print("on in ...");
          context
              .read<WarehouseProvider>()
              .setSelectedProducts(widget.invoice.products);
          // .setSelectedProducts(creatingInvoice.products);
          setState(() {});
        },
      );
    } else {
      Future.delayed(Duration(), () {
        context.read<WarehouseProvider>().clear();
      });
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<InvoicesProvider>();
    // creatingInvoice.products =
    //     context.watch<WarehouseProvider>().selectedProducts;
    return Container(
      // onWillPop: () async {
      //   context.watch<WarehouseProvider>().clear();
      //   creatingInvoice = InvoiceModel(type: InvoiceType.cash);
      //   return true;
      // },
      child: CustomScaffold(
        ignoring: _provider.loading,
        appBar: AppAppBar(
          title: (widget.isUpdate
                  ? S.of(context).update_request_products
                  : S.of(context).create_request_products),
          actions: [
            Text("#${creatingInvoice?.invoiceNo ?? ''}"),
          ],
          // actions: [Text("#${widget.invoice?.invoiceNo ?? ''}")],
        ),
        body: ListView(
          padding: appPadding,
          children: [
            // SizedBox(height: 27),
            _products(),
            SizedBox(height: 70),
            AppBtn(
              text: widget.isUpdate
                      ? S.of(context).update_request_products
                      : S.of(context).create_request_products,
              onPress: widget.isUpdate
                  ? () => _provider.updateInvoice(
                      invoice: creatingInvoice)
                  : () => _provider.createInvoice(invoice: creatingInvoice),
              isLoading: widget.isUpdate
                  ? _provider.updateLoading
                  : _provider.loading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _products() {
    // return Container();
    creatingInvoice.products =
        context.watch<WarehouseProvider>().selectedProducts;
    final _provider = context.watch<WarehouseProvider>();
    List<InvoiceProductModel> products = _provider.selectedProducts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).products,
          style: textStyle,
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 15),
        AddNew(
                label: S.of(context).add_product,
                onPress: () {
                  print("muller....");
                  appNavPush(context,
                      page: Products(
                        viewAppBar: true,
                        isSelecting: true,
                        isAllProducts: "ALL",
                      ));
                },
              ),
        SizedBox(height: 10),
        ...List.generate(
          products.length,
          //products.length,
          (index) => AppCardList(
            child: CustomListTile(
              leading: CustomRoundImage(
                imageUrl: products[index].product.image,
                width: 56,
                height: 56,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[index].product.name.localeName,
                    style: TextStyle(
                      fontFamily: 'Droid Arabic Kufi',
                      fontSize: 15,
                      color: const Color(0xff003d86),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomIconBtn(
                        size: 30,
                        icon: Icon(Icons.add_circle_outline,
                            color: appPrimaryColor),
                        onPress: () => _provider.increaseReturnItem(index),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) {
                            return EditProductQuantity(
                              product: products[index],
                            );
                          },
                        ),
                        child: Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          // padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xffeef1f7)),
                          ),
                          child: Center(
                            child: Text(
                              "${products[index].editQuantity}",
                              style: TextStyle(
                                fontFamily: 'Droid Arabic Kufi',
                                fontSize: 19,
                                color: const Color(0xff003d86),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomIconBtn(
                        size: 30,
                        icon: Icon(Icons.remove_circle_outline,
                            color: appPrimaryColor),
                        onPress: () => _provider.decreaseReturnItem(index),
                      ),
                    ],
                  )
                ],
              ),
              trail: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _deleteProduct(products[index].product),
                  // SizedBox(height: 10),
                  // CurrencyWidget(
                  //   amount: products[index].price,
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ],
              ),
            ),
          ),
        ),
        // SizedBox(height: 10),
        // AddNew(label: "إضافة اصناف"),
      ],
    );
  }

Widget _deleteProduct(ProductModel product) {
    return CustomIconBtn(
      size: 40,
      icon: Icon(Icons.delete, color: Colors.red),
      onPress: () => showAreYouSureDialog(
        title: S.of(context).delete_product_qu,
        subTitle: S.of(context).delete_product_info,
        onOK: () => context.read<WarehouseProvider>().removeItem(product),
      ),
    );
  }
}
