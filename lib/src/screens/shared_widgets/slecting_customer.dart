import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/models/customer_model.dart';
import 'package:al_baseet/src/screens/customers/customer_deatails.dart';
import 'package:al_baseet/src/screens/customers/customers.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_icon_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_list_tile.dart';
import 'package:al_baseet/src/screens/shared_widgets/custom_round_image.dart';
import 'package:al_baseet/src/values/colors.dart';
import 'package:flutter/material.dart';

class SelectingCustomer extends StatefulWidget {
  CustomerModel customer;
  bool isEditable;
  final String invoiceType;
  Function(CustomerModel) onSelected;
  SelectingCustomer(
      {@required this.customer,
      this.onSelected,
      this.isEditable = true,
      this.invoiceType = "002"});

  @override
  _SelectingCustomerState createState() => _SelectingCustomerState();
}

class _SelectingCustomerState extends State<SelectingCustomer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xffffffff),
            border: Border.all(width: 1.0, color: const Color(0xffeef1f7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  appNavPush(
                    context,
                    page: Customers(
                      isSelecting: true,
                      selectingCustomer: widget.customer,
                      onSelected: widget.onSelected,
                      invoiceType: widget.invoiceType,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).customer,
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 13,
                        color: const Color(0xffb1bac9),
                      ),
                      // textAlign: TextAlign.right,
                    ),
                    widget.isEditable
                        ? Icon(
                            Icons.edit,
                            color: appPrimaryColor,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              widget.customer == null
                  ? Text(
                      S.of(context).unselected,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Droid Arabic Kufi',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : CustomListTile(
                      onTap: () => appNavPush(
                        context,
                        page: CustomerDetails(
                          customerModel: widget.customer,
                        ),
                      ),
                      leading: CustomRoundImage(
                        width: 40,
                        height: 40,
                        imageUrl: widget.customer.userImage,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.customer.name.localeName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Droid Arabic Kufi',
                              fontSize: 15,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.customer.address,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontFamily: 'Droid Arabic Kufi',
                              fontSize: 13,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          )),
    );
  }
}
