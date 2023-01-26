import 'dart:developer';

import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/invoice_model.dart';
import 'package:al_baseet/src/models/invoice_type.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/providers/invoices_provider.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/customers/customer_deatails.dart';
import 'package:al_baseet/src/screens/customers/customers.dart';
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
import 'package:al_baseet/src/services/permissions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../warehouse/products/edit_product_price.dart';

class CreateInvoice extends StatefulWidget {
  final bool isUpdate;
  final bool isReturn;
  final InvoiceModel invoice;
  CreateInvoice({this.isUpdate = false, this.isReturn = false, this.invoice});
  @override
  _CreateInvoiceState createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  InvoiceModel creatingInvoice =
      InvoiceModel(type: InvoiceType.cash, products: []);

  List<bool> permissions = [];
  TextStyle textStyle = TextStyle(
    fontFamily: 'Droid Arabic Kufi',
    fontSize: 13,
    color: const Color(0xffb1bac9),
    letterSpacing: -0.21666663360595703,
  );
  String typeValue = "cash";
  bool customerNameVisible = false;

  @override
  void initState() {
    if (widget.isUpdate || widget.isReturn) {
      print("is update....");
      creatingInvoice.copy(widget.invoice);
      customerNameVisible = creatingInvoice.type.isCash;
      if (widget.isReturn)
        creatingInvoice.type = creatingInvoice.type.isCash
            ? InvoiceType.returnCash
            : InvoiceType.returnCredit;
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
    checkPermission();
  }
  Future<void> checkPermission() async {
    bool result = await Permissions.getPermission(permissionName: "edit_price");
    setState(() => permissions.add(result));  // set the local variable
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
          title: (widget.isReturn
              ? S.current.return_invoice
              : widget.isUpdate
                  ? S.of(context).update_invoice
                  : S.of(context).create_invoice),
          actions: [
            Text("#${creatingInvoice?.invoiceNo ?? ''}"),
          ],
        ),
        body: ListView(
          padding: appPadding,
          children: [
            // _customer(),
            widget.isReturn || widget.isUpdate ? SizedBox() : _type(),
            SizedBox(height: 23),
            SelectingCustomer(
              customer: creatingInvoice.customer,
              invoiceType:creatingInvoice.type.key,
              isEditable: !widget.isReturn,
              onSelected: (selectingCustomer) {
                setState(() {
                  creatingInvoice.customer = selectingCustomer;
                  customerNameVisible = (creatingInvoice.type.key == InvoiceType.cash.key) || (creatingInvoice.type.key == InvoiceType.returnCash.key);
                });
              },
            ),
            _customerName(),
            _customerTaxId(),
            // SizedBox(height: 27),
            _products(),
            SizedBox(height: 20),
            _total(),
            SizedBox(height: 70),
            AppBtn(
              text: widget.isReturn
                  ? S.current.return_invoice
                  : widget.isUpdate
                      ? S.of(context).update_invoice
                      : S.of(context).create_invoice,
              onPress: widget.isUpdate && !widget.isReturn
                  ? () => _provider.updateInvoice(
                      invoice: creatingInvoice, isReturn: widget.isReturn)
                  : () => _provider.createInvoice(invoice: creatingInvoice),
              isLoading: widget.isUpdate && !widget.isReturn
                  ? _provider.updateLoading
                  : _provider.loading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _type() {
    return Container(
      margin: EdgeInsets.only(bottom: 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).payment_type,
            style: textStyle,
            textAlign: TextAlign.right,
          ),
          // SizedBox(height: 18),
          Row(
            children: [
              Radio(
                value: InvoiceType.cash,
                groupValue: creatingInvoice.type,
                onChanged: (value) {
                  setState(() {
                    creatingInvoice.type = value;
                    creatingInvoice.customer=null;
                    customerNameVisible = false;
                  });
                },
              ),
              Text(
                S.of(context).cash,
                style: TextStyle(
                  fontFamily: 'Droid Arabic Kufi',
                  fontSize: 13,
                  color: const Color(0xff2a2a2a),
                  height: 1.8461538461538463,
                ),
              ),
              SizedBox(width: 10),
              Radio(
                value: InvoiceType.credit,
                groupValue: creatingInvoice.type,
                onChanged: (value) {
                  setState(() {
                    creatingInvoice.type = value;
                    creatingInvoice.customer=null;
                    customerNameVisible = false;
                  });
                },
              ),
              Text(
                S.of(context).credit,
                style: TextStyle(
                  fontFamily: 'Droid Arabic Kufi',
                  fontSize: 13,
                  color: const Color(0xff2a2a2a),
                  height: 1.8461538461538463,
                ),
              ),
            ],
          )
        ],
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
        widget.isReturn
            ? SizedBox()
            : AddNew(
                label: S.of(context).add_product,
                onPress: () {
                  print("muller....");
                  appNavPush(context,
                      page: Products(
                        viewAppBar: true,
                        isSelecting: true,
                      ));
                  FocusManager.instance.primaryFocus?.unfocus();
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
                        onPress: () => _provider.increaseReturnItem(index,
                            isRerunInvoice: widget.isReturn),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) {
                            return EditProductQuantity(
                              product: products[index],
                              isReturn: widget.isReturn,
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
                  SizedBox(height: 10),
                  permissions.length > 0 && permissions[0] ?
                  InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (ctx) {
                        return EditProductPrice(product: products[index]);
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
                            '${currencyFormat(products[index].editPrice)}',
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
                  ) :
                   CurrencyWidget(
                     amount: products[index].editPrice,
                     fontSize: 16,
                     fontWeight: FontWeight.w700,
                   )

                  // Text(
                  //   '\$ ${products[index].price}',
                  //   style: TextStyle(
                  //     fontFamily: 'Droid Arabic Kufi',
                  //     fontSize: 16,
                  //     color: const Color(0xff353333),
                  //     letterSpacing: -0.26666668701171875,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // )
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

  Widget _total() {
    final _provider = context.watch<WarehouseProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).total_amount, style: textStyle),
        SizedBox(height: 8),
        CurrencyWidget(
          amount:
              '${currencyFormat(InvoiceProductModel.getTotalAmount(_provider.selectedProducts))}',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),

       
      ],
    );
  }

  Widget _customerName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(visible: customerNameVisible,
          child: TextFormField(
            keyboardType: TextInputType.text,
            maxLines: 1,
            maxLength: 200,
            initialValue: creatingInvoice.customer_name,
            enabled: !widget.isReturn,
            /*  controller: _textNameController,*/
            decoration: InputDecoration(

              hintText: S.of(context).customer_name_qr,
              labelText:  S.of(context).customer_name,
              border: OutlineInputBorder(),
            ),
            onChanged : (customerName) {
              setState((){
                creatingInvoice.customer_name = customerName;
              });
            },
          ),
        ),
      ],
    );
  }
  Widget _customerTaxId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(visible: customerNameVisible,
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLines: 1,
            maxLength: 15,
            initialValue: creatingInvoice.customer_tax_id,
            enabled: !widget.isReturn,
            /*  controller: _textNameController,*/
            decoration: InputDecoration(

              hintText: S.of(context).tax_id_qr,
              labelText: S.of(context).tax_id,
              border: OutlineInputBorder(),
            ),
            onChanged : (taxId) {
              setState((){
                creatingInvoice.customer_tax_id = taxId;
              });
            },
          ),
        ),
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
