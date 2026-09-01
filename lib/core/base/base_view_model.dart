import 'package:flutter/foundation.dart';

enum ViewState { idle, loading, success, error }

abstract class BaseViewModel extends ChangeNotifier {
  ViewState _status = ViewState.idle;
  String? _errorMessage;

  ViewState get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == ViewState.loading;
  bool get hasError => _status == ViewState.error;

  void setLoading() {
    _status = ViewState.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void setIdle() {
    _status = ViewState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  void setError(String message) {
    _status = ViewState.error;
    _errorMessage = message;
    notifyListeners();
  }

  void setSuccess() {
    _status = ViewState.success;
    _errorMessage = null;
    notifyListeners();
  }
}
