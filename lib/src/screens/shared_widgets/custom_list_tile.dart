import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trail;
  final Function onTap;
  CustomListTile(
      {this.leading, this.title = const SizedBox(), this.trail, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                leading ?? SizedBox(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: title,
                  ),
                ),
              ],
            ),
          ),
          trail ?? SizedBox()
        ],
      ),
    );
  }
}
