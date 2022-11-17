class EventSource<T> {
  final bool loading;
  final bool refresh;
  final String error;
  final List<T> data;
  final bool stopLoading;
  EventSource({
    this.loading = false,
    this.error = "",
    this.data,
    this.stopLoading = true,
    this.refresh = false,
  });

  // bool get hasError => error?.isNotEmpty ?? false;
  // bool get hasData => data != null;
  bool get isRefresh => data != null;
  bool get isHasNoData =>
      !loading && data.isEmpty || refresh&&data.isEmpty;
}

final initEvent = EventSource(
  loading: true,
  data: [],
);
