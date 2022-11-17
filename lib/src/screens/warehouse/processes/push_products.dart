import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
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
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/warehouse/products/edit_product_quntiy.dart';
import 'package:al_baseet/src/screens/warehouse/products/product_details.dart';
import 'package:al_baseet/src/screens/warehouse/products/products.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PushProducts extends StatefulWidget {
  @override
  _PushProductsState createState() => _PushProductsState();
}

class _PushProductsState extends State<PushProducts> {
  // void
  // @override
  // void initState() {
  //   Future.delayed(Duration(), () {
  //     context.read<WarehouseProvider>().getWarehouseProducts();
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    return CustomScaffold(
      ignoring: _provider.returnEvent.loading,
      body: Padding(
        padding: appPadding,
        child: Container(
          // onRefresh: () => _provider.getWarehouseProducts(isRefresh: true),
          child: Column(
            children: [
              AddNew(
                label: S.of(context).add_product,
                onPress: () => appNavPush(context,
                    page: Products(
                      viewAppBar: true,
                      isSelecting: true,
                    )),
              ),
              Expanded(
                child: _provider.selectedProducts.length == 0
                    ? noProductPage()
                    : _products(_provider.selectedProducts),
              ),
              // SizedBox(height: 10),
              _provider.selectedProducts.length == 0
                  ? SizedBox()
                  : Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: AppBtn(
                              isLoading: _provider.returnEvent.loading,
                              height: 45,
                              text: "${S.of(context).return_product}",
                              onPress: () => showAreYouSureDialog(
                                title: S.of(context).return_products_qu,
                                subTitle: S.of(context).return_products_info,
                                onOK: () => _provider.returnProducts(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noProductPage() {
    return ListView(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(height: 30),
        Image.asset(
          "assets/png/no_data.png",
          width: 200,
          height: 200,
        ),
        SizedBox(height: 50),
        Text(
          S.of(context).add_products_message,
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 18,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _products(List<InvoiceProductModel> products) {
    final _provider = context.watch<WarehouseProvider>();
    return ListView.builder(
      itemCount: products.length,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index) => AppCardList(
        child: CustomListTile(
          onTap: () => appNavPush(context,
              page: ProductDetails(product: products[index].product)),
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
                  // Icon(Icons.add_circle_outline, color: appPrimaryColor),
                  CustomIconBtn(
                    size: 30,
                    icon:
                        Icon(Icons.add_circle_outline, color: appPrimaryColor),
                    onPress: () => _provider.increaseReturnItem(index),
                  ),
                  SizedBox(width: 5),

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
                      padding: EdgeInsets.all(7),
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
                  SizedBox(width: 5),
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
            children: [
              _deleteProduct(products[index].product),
              SizedBox(height: 10),
              CurrencyWidget(
                amount: products[index].price,
              ),
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
