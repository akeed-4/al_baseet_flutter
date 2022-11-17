import 'package:al_baseet/src/models/products_model.dart';
import 'package:al_baseet/src/screens/shared_widgets/currencyWidget.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  ProductDetails({this.product});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height * .5,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          // color: Colors.blueAccent,
                          child: FadeInImage.assetNetwork(
                            image: product.image,
                            placeholder: 'assets/png/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black12,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            CustomIconBtn(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPress: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    color: const Color(0xffffffff),
                  ),
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.name.localeName}',
                            style: TextStyle(
                              fontFamily: 'Droid Arabic Kufi',
                              fontSize: 24,
                              color: const Color(0xff003d86),
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),
                          Container(
                            height: 90,
                            width: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                              color: const Color(0xff2c2e78),
                            ),
                            child: Center(
                              child: // Adobe XD layer: '$69' (text)
                                  SingleChildScrollView(
                                child: CurrencyWidget(
                                  amount: product.price,
                                  fontSize: 16,
                                  amountColor: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24),
                      // Adobe XD layer: 'A circular cactus w…' (text)
                      Text(
                        product.description,
                        // '${product.description}',
                        style: TextStyle(
                          fontFamily: 'Droid Arabic Kufi',
                          fontSize: 16,
                          color: const Color(0xff003d86),
                          height: 1.5,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
