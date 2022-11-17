import 'package:flutter/material.dart';

appNavPushReplacement(BuildContext context, {@required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

appNavPush(BuildContext context, {@required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
