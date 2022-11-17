import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/event_source.dart';
import 'package:al_baseet/src/models/prodcut_invoice_model.dart';
import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/providers/common/settings.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_card_list.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/screens/shared_widgets/no_data_page.dart';
import 'package:al_baseet/src/screens/shared_widgets/pull_to_refresh.dart';
import 'package:al_baseet/src/screens/shared_widgets/search.dart';
import 'package:al_baseet/src/screens/warehouse/products/product_details.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:al_baseet/src/values/global_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  final bool viewAppBar;
  final bool isSelecting;
  final String isAllProducts;
  List<InvoiceProductModel> selectedProducts = [];

  Function(List<ProductModel>) onSelected;
  Products({
    this.viewAppBar = false,
    this.isSelecting = false,
    this.selectedProducts,
    this.onSelected,
    this.isAllProducts = ""
  });
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool _isListView = true;
  // List<ProductModel> products = [];
  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<WarehouseProvider>().getWarehouseProducts(isAllProducts: widget.isAllProducts);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    final _settingProvider = context.watch<SettingsProvider>();

    return WillPopScope(
      onWillPop: () async {
        _provider.runFilter('');
        return true;
      },
      child: CustomScaffold(
        floatActionBtn: widget.isSelecting
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: FloatingActionButton(
                      child: Icon(Icons.arrow_forward_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              )
            : SizedBox(),
        appBar: widget.viewAppBar
            ? AppAppBar(
                title: S.current.products,
              )
            : null,
        isLoading: _provider.event.loading && !_provider.event.refresh,
        body: AppCustomRefresher(
          onRefresh: () => _provider.getWarehouseProducts(isRefresh: true, isAllProducts: widget.isAllProducts),
          child: _provider.event.isHasNoData
              ? NoDataPage()
              : ListView.builder(
                  padding: appPadding,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return Column(
                        children: [
                          // CustomSearch(label: S.of(context).search_for_product),
                          // SizedBox(height: 10),
                          Row(
                            children: [
                              _selection(
                                iconData: Icons.menu,
                                isSelected: _settingProvider.isGirdView,
                                onPress: () => _settingProvider.editView(true),
                              ),
                              SizedBox(width: 10),
                              _selection(
                                  iconData: Icons.grid_view,
                                  isSelected: !_settingProvider.isGirdView,
                                  onPress: () =>
                                      _settingProvider.editView(false)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: CustomSearch(
                              label: S.of(context).search_for_product,
                              onValueChange: _provider.runFilter,
                            ),
                          )
                          // SizedBox(height: 20),
                        ],
                      );
                    return _settingProvider.isGirdView
                        ? _productsListView(_provider.filteredProducts)
                        : _productsGirdView(_provider.filteredProducts);
                  },
                ),
        ),
      ),
    );
  }

  // bool isChecked(ProductModel product) {
  //   int index = widget.selectedProducts
  //       .indexWhere((element) => element.product.id == product.id);
  //   return index == -1 ? false : true;
  // }

  Widget _productsListView(List<ProductModel> products) {
    final _provider = context.watch<WarehouseProvider>();
    if (widget.isSelecting) {
      products = products.where((element) => element.quantity > 0).toList();
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel product = products[index];
        // if (widget.isSelecting && product.quantity <= 0) return SizedBox();

        return Container(
          child: AppCardList(
            background:
                widget.isSelecting && _provider.isChecked(products[index])
                    ? Colors.blue[50]
                    : null,
            child: Row(
              children: [
                widget.isSelecting
                    ? Checkbox(
                        value: _provider.isChecked(product),
                        onChanged: (bool value) {
                          print("muller ............");
                          _provider.onSelect(product);
                        }
                        // onChanged: (bool value) => _provider.onSelect(product),
                        )
                    : SizedBox(),
                Expanded(
                  child: CustomListTile(
                    onTap: () => appNavPush(
                      context,
                      page: ProductDetails(
                        product: products[index],
                      ),
                    ),
                    leading: CustomRoundImage(
                      imageUrl: products[index].image,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Adobe XD layer: 'Cloud Ear Pink' (text)
                        Text(
                          '${products[index].name.localeName}',
                          style: TextStyle(
                            fontFamily: 'Droid Arabic Kufi',
                            fontSize: 15,
                            color: const Color(0xff003d86),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "${products[index].quantity}",
                                style: TextStyle(
                                  fontFamily: 'Droid Arabic Kufi',
                                  fontSize: 11,
                                  color: const Color(0xff7f8e9d),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                text: S.of(context).available_in_warehouse,
                                style: TextStyle(
                                  fontFamily: 'Droid Arabic Kufi',
                                  fontSize: 11,
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
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _productsGirdView(List<ProductModel> products) {
    final _provider = context.watch<WarehouseProvider>();
    final orientation = MediaQuery.of(context).orientation;
    if (widget.isSelecting) {
      products = products.where((element) => element.quantity > 0).toList();
    }
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.9),
        itemBuilder: (BuildContext context, int index) {
          // if (widget.isSelecting && products[index].quantity <= 0) return null;
          return InkWell(
            onTap: () => appNavPush(
              context,
              page: ProductDetails(
                product: products[index],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color:  _provider.isChecked(products[index])?Colors.blue[50]: Color(0xffffffff),
              ),
              child: Stack(
                children: [
                  // _provider.isChecked(products[index])
                  //     ? Positioned.fill(
                  //         child: Container(color: Colors.blue[50]))
                  //     : SizedBox(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRoundImage(
                          imageUrl: products[index].image,
                          width: 56,
                          height: 56,
                        ),
                        SizedBox(height: 10),
                        Text(
                          products[index].name.localeName,
                          style: TextStyle(
                            fontFamily: 'Droid Arabic Kufi',
                            fontSize: 15,
                            color: const Color(0xff003d86),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // Adobe XD layer: '4.4' (text)
                        Text(
                          '${products[index].quantity}',
                          style: TextStyle(
                            fontFamily: 'Droid Arabic Kufi',
                            fontSize: 11,
                            color: const Color(0xff7f8e9d),
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Text(
                          S.of(context).available_in_warehouse,
                          style: TextStyle(
                            fontFamily: 'Droid Arabic Kufi',
                            fontSize: 7,
                            color: const Color(0xff7f8e9d),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        widget.isSelecting
                            ? Checkbox(
                                value: _provider.isChecked(products[index]),
                                onChanged: (bool value) {
                                  print("muller ............");
                                  _provider.onSelect(products[index]);
                                }
                                // onChanged: (bool value) => _provider.onSelect(product),
                                )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 4),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                        ),
                        color: const Color(0xff2c2e78),
                      ),
                      child: Center(
                        child: // Adobe XD layer: 'Price' (group)
                            CurrencyWidget(
                          amount: products[index].price,
                          fontSize: 12,
                          amountColor: Colors.white,
                          currencyColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _selection(
      {@required IconData iconData,
      bool isSelected = false,
      Function onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xff2c2e78),
              )
            : null,
        child: Center(
          child: Icon(
            iconData,
            color: isSelected ? Colors.white : Color(0xff79A9D2),
          ),
        ),
      ),
    );
  }
}
