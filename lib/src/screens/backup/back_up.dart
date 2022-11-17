import 'package:al_baseet/generated/l10n.dart';
import 'package:al_baseet/src/screens/shared_widgets/appAppBar.dart';
import 'package:al_baseet/src/screens/shared_widgets/app_btn.dart';
import 'package:al_baseet/src/screens/shared_widgets/customScffold.dart';
import 'package:flutter/material.dart';

class BackUpHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppAppBar(
        title: S.of(context).backup,
        actions: [
          AppBtn(text: S.of(context).create_backup, height: 40),
        ],
      ),
    );
  }
}
