class ResponseObject<T> {
  ResponseObject({
    int? status,
    String? error,
    T? data,
  }) {
    _status = status;
    _error = error;
    _data = data;
  }

  int? _status;
  String? _error;
  T? _data;

  int? get status => _status;

  String? get error => _error;

  T? get data => _data;

}
