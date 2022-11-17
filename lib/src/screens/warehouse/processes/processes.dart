import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/providers/warehouse_provider.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:al_baseet/src/screens/warehouse/processes/pull_products.dart';
import 'package:al_baseet/src/screens/warehouse/processes/push_products.dart';
import 'package:al_baseet/src/values/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Processes extends StatefulWidget {
  @override
  _ProcessesState createState() => _ProcessesState();
}

class _ProcessesState extends State<Processes> {
  bool _isPull = true;

  @override
  void initState() {
    Future.delayed(Duration(), () {
      context.read<WarehouseProvider>().getReceiveStatements();
      context.read<WarehouseProvider>().clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<WarehouseProvider>();
    return CustomScaffold(
      ignoring: _provider.loading,
      appBar: AppAppBar(
        title: "${S.of(context).processes}",
      ),
      // isLoading: _provider.loading,
      body: Column(
        children: [
          Container(
            padding: appPadding,

            // padding: EdgeInsets.symmetric(horizontal: appPadding01),
            child: Row(
              children: [
                _selection(
                  txt: S.of(context).pull_products,
                  isSelected: _isPull,
                  onPress: () {
                    setState(() {
                      _isPull = true;
                    });
                  },
                ),
                SizedBox(width: 10),
                _selection(
                  txt: S.of(context).push_products,
                  isSelected: !_isPull,
                  onPress: () {
                    setState(() {
                      _isPull = false;
                    });
                  },
                ),
              ],
            ),
          ),
          // SizedBox(height: 20),
          Expanded(
            child: _isPull ? PullProducts() : PushProducts(),
          ),
        ],
      ),
    );
  }

  Widget _selection(
      {@required String txt, bool isSelected = false, Function onPress}) {
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
            child: // Adobe XD layer: 'All' (text)
                Text(
          '$txt',
          style: TextStyle(
            fontFamily: 'Droid Arabic Kufi',
            fontSize: 14,
            color: isSelected ? const Color(0xffffffff) : Color(0xff79A9D2),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        )),
      ),
    );
  }
}
