import 'package:al_baseet/src/values/colors.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final String label;
  final Function(String keyword) onValueChange;

  CustomSearch({@required this.label, this.onValueChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffecf5fc),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: appPrimaryColor,
          ),
          // SizedBox(width: 2),
          Expanded(
            child: TextField(
              onChanged: (value) => onValueChange(value),
              maxLines: 1,
              decoration: InputDecoration(
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: label,
                // contentPadding: EdgeInsets.only(bottom: 12),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
