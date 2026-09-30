import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  String? _role;
  String? _userId;

  String? get token => _token;
  String? get role => _role;
  String? get userId => _userId;

  bool get isAuthenticated => _token != null;

  void setUser({
    required String token,
    required String role,
    required String userId,
  }) {
    _token = token;
    _role = role;
    _userId = userId;
    notifyListeners();
  }

  void clearUser() {
    _token = null;
    _role = null;
    _userId = null;
    notifyListeners();
  }
}
