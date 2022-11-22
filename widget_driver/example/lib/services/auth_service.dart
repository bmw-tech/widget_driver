import 'dart:async';

class AuthService {
  bool _isLoggedIn = false;
  final _isLoggedInStreamController = StreamController<bool>.broadcast();

  bool get isLoggedIn => _isLoggedIn;

  Stream<bool> get isLoggedInStream => _isLoggedInStreamController.stream;

  void logIn() {
    _isLoggedIn = true;
    _isLoggedInStreamController.add(_isLoggedIn);
  }

  void logOut() {
    _isLoggedIn = false;
    _isLoggedInStreamController.add(_isLoggedIn);
  }
}
