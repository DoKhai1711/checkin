import 'package:rxdart/rxdart.dart';

class BaseService {
  final _error = BehaviorSubject<String>();

  void dispose() {
    _error.close();
  }

  Future<String> getMessageError() {
    return _error.stream.first;
  }

  String? getValue() {
    return _error.valueOrNull;
  }

  void addMessageError(String message) {
    _error.sink.add(message);
    }
}
