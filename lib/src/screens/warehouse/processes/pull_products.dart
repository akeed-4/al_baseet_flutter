import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/models/recive_statment_model.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/warehouse/products/product_details.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PullProducts extends StatefulWidget {
  @override
  _PullProductsState createState() => _PullProductsState();
}

class _PullProductsState extends State<PullProducts> {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    return CustomScaffold(
      ignoring: _provider.loading,
      isLoading:
          _provider.receiveEvent.loading && !_provider.receiveEvent.refresh,
      body: AppCustomRefresher(
        onRefresh: () => _provider.getReceiveStatements(isRefresh: true),
        child: !_provider.receiveEvent.loading &&
                _provider.receiveEvent.data.length == 0
            ? NoDataPage(
                message: S.of(context).no_new_receive_statement,
              )
            : ListView.builder(
                itemCount: _provider.receiveEvent.data.length,
                padding: EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) {
                  ReceiveStatementModel statement =
                      _provider.receiveEvent.data[index];
                  return Card(
                    elevation: 8,
                    shadowColor: appPrimaryColor,
                    color: Color(0xffF8F9FB),
                    // color: Colors.bla,

                    child: Column(
                      children: [
                        _products(products: statement.products),
                        // SizedBox(height: 10),
                        IgnorePointer(
                          ignoring: !statement.isNon,
                          child: Padding(
                            padding: appPadding,
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppBtn(
                                    height: 40,
                                    text: S.of(context).accept,
                                    backgroundColor: Colors.green,
                                    icon: statement.isAccepted
                                        ? Icons.check_circle
                                        : null,
                                    isLoading: statement.isAcceptLoading,
                                    // onPress: () => _provider.acceptance(index),
                                    onPress: () => showAreYouSureDialog(
                                      subTitle:
                                          S.of(context).accept_statement_info,
                                      onOK: () => _provider.acceptance(index),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: AppBtn(
                                    height: 40,
                                    text: S.of(context).reject,
                                    backgroundColor: Colors.red,
                                    icon: statement.isCanceled
                                        ? Icons.check_circle
                                        : null,
                                    isLoading: statement.isCanceledLoading,
                                    onPress: () => showAreYouSureDialog(
                                      subTitle:
                                          S.of(context).reject_statement_info,
                                      onOK: () => _provider.acceptance(index,
                                          accept: false),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
      ),
    );
  }

  Widget _products({@required List<InvoiceProductModel> products}) {
    // List<ProductModel> products = _provider.receiveEvent.data[0].products;
    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
            // mainAxisAlignment: ,
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
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "${products[index].quantity}",
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 16,
                        color: const Color(0xff7f8e9d),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: " ",
                    ),
                    TextSpan(
                      text: S.of(context).quantity,
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 16,
                        color: const Color(0xff7f8e9d),
                        // fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trail: CurrencyWidget(
            amount: products[index].price,
          ),
        ),
      ),
    );
  }
}
