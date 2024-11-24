class DataState<T> {
  bool isSuccess;
  String message;
  String title;
  T? data;
  DataState({
    required this.isSuccess,
    required this.message,
    required this.title,
    this.data,
  });

  DataState.error({
    required this.title,
    required this.message,
    this.isSuccess = false,
  });

  DataState.success({
    required this.data,
    this.isSuccess = true,
    this.message = "",
    this.title = "",
  });
}
