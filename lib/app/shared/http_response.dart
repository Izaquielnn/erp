class HttpResponse<T> {
  bool success;
  String message;

  T? value;

  HttpResponse({required this.success, required this.message, this.value});
}
