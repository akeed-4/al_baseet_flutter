import 'package:flutter/material.dart';

class AppCustomRefresher extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  AppCustomRefresher({@required this.child, this.onRefresh});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: child,
    );
  }
}
