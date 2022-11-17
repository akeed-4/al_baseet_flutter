import 'package:al_baseet/src/models/event_source.dart';
import 'package:flutter/material.dart';

class BaseProvider<T> with ChangeNotifier {
  // BuildContext context;
  bool loading = false;
  EventSource<T> event = EventSource();
  void setEvent(EventSource<T> event) {
    this.event = event;
    notifyListeners();
  }

  void setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}
